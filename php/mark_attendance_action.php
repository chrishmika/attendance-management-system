<?php
require_once '../config.php';
include_once ROOT_PATH . '/php/config/Database.php';
include_once ROOT_PATH . '/php/class/User.php';
include_once ROOT_PATH . '/php/class/Lecturer.php';
include_once ROOT_PATH . '/php/class/Utils.php';



$db = new Database();
$conn = $db->getConnection();
$user = new User($conn);
$lecr = new Lecturer($conn);
$utils = new Utils();

if (!($user->isLoggedIn()) || $_SESSION['user_role'] > 2) {
    header("Location: " . SERVER_ROOT . "/index.php");
}

if (isset($_POST["userSearch"]) && ($user->isAdmin() || $user->isLecturer())) {
    $courseId = $_POST["courseId"];
    $errors = [];
    $messages = [];
    $order = [];
    $response = [];
    $order['search'] = $_POST["userSearch"];
    try {
        $students = $lecr->getStudentsFromCourseId($courseId, $order);
        $response['students'] = $students->fetch_all();
    } catch (Exception $e) {
        $errors[] = $e->getMessage();
        $errors[] = "Error in retrieving students";
        $response['students'] = [];
    }
    $response['errors'] = $errors;
    $response['error'] = false;
    echo json_encode($response);
    //add user to course by admin

} else if (isset($_POST['addStudentsToClassList']) || isset($_POST['removeStudentsFromClassList'])) {
    $classId = $_POST['classId'];
    $studentsToAdd = isset($_POST['addStudentsToClassList']) ? $_POST['addStudentsToClassList'] : [];
    $studentsToRemove = isset($_POST['removeStudentsFromClassList']) ? $_POST['removeStudentsFromClassList'] : [];
    $errors = [];
    $messages = [];
    $response = [];
    foreach ($studentsToAdd as $student) {
        try {
            $lecr->markAttendance($student, $classId, "", 0);
            $messages[] = "Student " . $student . " added to class";
        } catch (Exception $e) {
            $errors[] = "Error in adding student to class";
        }
    }
    foreach ($studentsToRemove as $student) {
        try {
            $lecr->removeStudentFromClass($student, $classId);
            $messages[] = "Student " . $student . " removed from class";
        } catch (Exception $e) {
            $errors[] = "Error in removing student from class";
        }
    }
    $response['errors'] = $errors;
    $response['messages'] = $messages;
    $response['error'] = false;
    echo json_encode($response);
} else if (isset($_POST['attendanceStatus']) && isset($_POST['currentTimeString']) && isset($_POST['fingerprintId'])) {
    $std_id = $_POST['stdId'];
    $class_id = $_POST['classId'];
    $attendanceStatus = $_POST['attendanceStatus'];
    $currentTimeString = $_POST['currentTimeString'];
    $fingerprintId = $_POST['fingerprintId'];

    $errors = [];
    $messages = [];
    $response = [];

    // Verify fingerprint ID
    $query = "SELECT fingerprint_id FROM uoj_student WHERE std_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param('i', $std_id);
    $stmt->execute();
    $stmt->bind_result($storedFingerprintId);
    $stmt->fetch();
    $stmt->close();

    if ($storedFingerprintId == $fingerprintId) {
        try {
            // Assuming $lecr is the instance managing attendance
            $lecr->editAttendance($std_id, $class_id, $currentTimeString, $attendanceStatus);
            $messages[] = "Attendance marked";
        } catch (Exception $e) {
            $errors[] = "Error in marking attendance";
        }
    } else {
        $errors[] = "Fingerprint ID does not match";
    }

    $response['errors'] = $errors;
    $response['messages'] = $messages;
    $response['error'] = false;
    echo json_encode($response);
} else {
    $response['error'] = true;
    $response['errors'] = ["Unauthorized access"];
    echo json_encode($response);
}

// Capture fingerprint and get the template
/* $fingerprintTemplate = captureFingerprint();
if ($fingerprintTemplate) {
    // Example logic to match the captured fingerprint with stored templates
    $userTemplate = '...'; // Retrieve this from your database
    if (matchFingerprints($fingerprintTemplate, $userTemplate)) {
        echo "Attendance marked successfully!";
    } else {
        echo "Fingerprint did not match!";
    }
} else {
    echo "Failed to capture fingerprint!";
}
 */

 // Function to verify and mark attendance
/* function verifyAndMarkAttendance($scannedFingerprint, $conn) {
    // Query to get all fingerprint templates
    $query = "SELECT id, fingerprint_template FROM users";
    $result = $conn->query($query);

    // Iterate through stored templates to find a match
    while ($row = $result->fetch_assoc()) {
        $storedTemplate = $row['fingerprint_template'];
        $userId = $row['id'];
        
        // Assuming a compareFingerprints function from the SDK
        if (compareFingerprints($scannedFingerprint, $storedTemplate)) {
            // Mark attendance
            $date = date("Y-m-d");
            $markAttendanceQuery = "INSERT INTO attendance (user_id, attendance_date) VALUES (?, ?)";
            $stmt = $conn->prepare($markAttendanceQuery);
            $stmt->bind_param("is", $userId, $date);
            $stmt->execute();

            echo "Attendance marked successfully for user ID $userId!";
            return;
        }
    }
    echo "Fingerprint not recognized!";
} */

