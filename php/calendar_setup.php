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

header('Content-Type: application/json');

if (isset($_POST['lecr_id'])) {
    if (($user->isAdmin() || $user->isLecturer()) && $_SESSION['lecr_id'] == $_POST['lecr_id']) {
        $lecr_id = $_POST['lecr_id'];
        $events = [];
        $startDate = substr($_POST['start'], 0, 10);
        $endDate = substr($_POST['end'], 0, 10);
        $classes = $lecr->getClassByLecturer($lecr_id, $startDate, $endDate);
        while ($class = $classes->fetch_assoc()) {
            $event = [];
            $event['id'] = $class['class_id'];
            $event['title'] = $class['course_code'] . ' - ' . $class['course_name'];
            $event['start'] = $class['class_date'] . "T" . $class['start_time'];
            $event['end'] = $class['class_date'] . "T" . $class['end_time'];
            $classAttendance = $lecr->classAttendancePrecentage($class['class_id']);
            if ($classAttendance < 0.5) {
                $event['color'] = '#ff0000';
            } else if ($classAttendance < 0.75) {
                $event['color'] = '#ff8000';
            } else {
                $event['color'] = '#00ff00';
            }
            $events[] = $event;
        }
        echo json_encode($events);
    } else {
        echo json_encode(array("message" => "Unauthorized access."));
    }
}

<?php
// Assuming you have already started the session and initialized database connection

// Check if the std_id is passed in the request
if (isset($_POST['std_id'])) {
    $std_id = $_POST['std_id'];

    // Retrieve events based on the student ID
    // Example: Get the classes for the student (customize this query based on your database)
    $query = "SELECT class_id,attend_time, attendance_status FROM uoj_student_class WHERE std_id = ?";
    
    $stmt = $conn->prepare($query);
    $stmt->bind_param('i', $std_id);
    $stmt->execute();
    
    $result = $stmt->get_result();
    $events = [];
    
    while ($row = $result->fetch_assoc()) {
        $event = [
            'id' => $row['class_id'],
            'start' =>$row['attend_time'],
            'status' => $row['attendance_status']
        ];
        $events[] = $event;
    }
    
    // Send events as a JSON response
    echo json_encode($events);
} else {
    echo json_encode(['error' => 'Student ID not provided']);
}
?>


