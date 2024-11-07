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
} else if (isset($_POST['attendanceStatus']) && isset($_POST['currentTimeString']) && isset($_POST['fingerprintId']) && isset($_POST['classId'])) {
    $class_id = $_POST['classId'];
    $attendanceStatus = $_POST['attendanceStatus'];
    $currentTimeString = $_POST['currentTimeString'];
    $fingerprintId = $_POST['fingerprintId'];

    $errors = [];
    $messages = [];
    $response = [];

    // Find student ID by fingerprint ID
    $query = "SELECT std_id FROM uoj_student WHERE fingerprint_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param('s', $fingerprintId);
    $stmt->execute();
    $stmt->bind_result($std_id);
    $stmt->fetch();
    $stmt->close();

    if ($std_id) {
        try {
            // Assuming $lecr is the instance managing attendance
            $lecr->editAttendance($std_id, $class_id, $currentTimeString, $attendanceStatus);
            $messages[] = "Attendance marked successfully for student ID: $std_id";
        } catch (Exception $e) {
            $errors[] = "Error in marking attendance: " . $e->getMessage();
        }
    } else {
        $errors[] = "No student found with the provided fingerprint ID.";
    }

    $response['errors'] = $errors;
    $response['messages'] = $messages;
    $response['error'] = !empty($errors);
    echo json_encode($response);
} else {
    $response['error'] = true;
    $response['errors'] = ["Unauthorized access"];
    echo json_encode($response);
}

