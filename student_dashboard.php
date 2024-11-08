<?php
require_once '../config.php';
include_once ROOT_PATH . '/php/config/Database.php';
include_once ROOT_PATH . '/php/class/User.php';
include_once ROOT_PATH . '/php/class/Utils.php';
include_once ROOT_PATH . '/php/class/Lecturer.php';
include_once ROOT_PATH . '/php/class/Student.php';
$utils = new Utils();
$db = new Database();
$conn = $db->getConnection();
$user = new User($conn);
$lecr = new Lecturer($conn);
$std = new Student($conn);


if (!($user->isLoggedIn()) || $_SESSION['user_role'] != 3) {
    header("Location: " . SERVER_ROOT . "/index.php");
}
include ROOT_PATH . '/php/include/header.php';
echo "<title>AMS Student</title>
<style>
.calendar-container {
    width: 100%;
    margin: 0 auto;
    font-family: Arial, sans-serif;
    text-align: center;
}

.calendar-header {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
}

.calendar-table {
    width: 100%;
    border-collapse: collapse;
}

.calendar-table th, .calendar-table td {
    padding: 10px;
    width: 14.28%;
    vertical-align: top;
    border: 1px solid #ccc;
}

.calendar-day {
    position: relative;
    width:30px;
}

.day-number {
    font-size: 16px;
    font-weight: bold;
}

.attendance-status {
    font-size: 12px;
    margin-top: 5px;
    height:50px;
    overflow:scroll;
}

.calendar-day div {
    margin: 2px 0;
}

    table{
        width:50%;
        text-align:center;
        margin:auto;
        border:none;
    }
    .thead{
    font-size:36px;
    border-bottom:2px solid gray;
    }
    .tbody{
        padding:15px auto;

    }
        .calendar-nav {
    text-align: center;
    margin: 10px 0;
}

.calendar-nav a {
    color: white;
    text-decoration: none;
    border-radius: 5px;
    margin: 0 10px;
    font-size:25px;
}

.calendar-nav a:hover {
    background-color: #0056b3;
}


</style>
";
include ROOT_PATH . '/php/include/content.php';
$activeDash = 3;
include ROOT_PATH . '/php/include/nav.php';
?>
<div class="container mt-3">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-center">Student Dashboard</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h4 class="text-center">Welcome <?php echo $_SESSION['user_name']; ?></h4>
        </div>
    </div>
</div>


        <!-- courses -->
        <!-- TODO: add attendance precentile -->
        <div class="container-sm mt-3" id="course_data">
            <?php
            $order = array();
            $itemsPerPage = 10; //10 items per page
            $currentPage = isset($_GET['pageC']) ? $_GET['pageC'] : 1;
            $order['offset'] = ($currentPage - 1) * $itemsPerPage;
            $order['limit'] = $itemsPerPage;
            $totalCount = $user->countRecords('uoj_Student_course', 'std_id', $_SESSION["std_id"]);
            $totalPages = ceil($totalCount / $itemsPerPage);
            ?>

            <table class="table table-striped table-hover border shadow " id="courses_data">
                <h1>Assigned Courses</h1>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Course Code</th>
                        <th>Course Name</th>
                        <th>Attendance Precentage</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $courses = $lecr->getStudentCourseList($_SESSION["std_id"], $order);
                    $i = 1;
                    while ($course = $courses->fetch_assoc()) {
                        $precentage = $lecr->attendancePrecentageForCourse($_SESSION["std_id"], $course['course_id']);
                        echo "<tr data-bs-toggle='modal' data-bs-target='#add_course' data-course-id='" . $course['course_id'] . "'>";
                        echo "<td>" . $i++ . "</td>";
                        echo "<td>" . $course['course_code'] . "</td>";
                        echo "<td>" . $course['course_name'] . "</td>";
                        // echo "<td>" . $precentage[0] . " " . $precentage[1] . "</td>";
                        echo "<td><div class='progressbar' data-pss='rad' style='--pss-value:" . $precentage[0] + $precentage[1] . "'>" . $precentage[0] + $precentage[1] . "%</div></td>";
                        echo "</tr>";
                    }
                    ?>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <?php for ($i = 1; $i <= $totalPages; $i++) : ?>
                        <li class="page-item <?php echo ($i == $currentPage) ? 'active' : ''; ?>">
                            <a class="page-link" href="<?php echo SERVER_ROOT; ?>/php/student_dashboard.php?pageC=<?php echo $i; ?>">
                                <?php echo $i; ?>
                            </a>
                        </li>
                    <?php endfor; ?>
                </ul>
            </nav>
        
        
        
<h1>Calendar </h1>


<?php
// Assuming your database connection is stored in $conn and student ID is stored in the session
$query = "SELECT c.class_date, c.start_time, c.end_time, cu.course_code, cu.course_name, sc.attendance_status 
          FROM uoj_student_class AS sc 
          LEFT JOIN uoj_class AS c ON c.class_id = sc.class_id 
          LEFT JOIN uoj_course AS cu ON cu.course_id = c.course_id 
          WHERE sc.std_id = 1 
          ORDER BY c.class_date DESC";
$result = mysqli_query($conn, $query);

// Prepare an array to store attendance info by date
$attendance = [];

if ($result && mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $classDate = $row['class_date'];
        $attendanceStatus = $row['attendance_status'];

        // Store the attendance info for each day
        $attendance[$classDate][] = [
            'status' => $attendanceStatus,
            'course_code' => $row['course_code'],
            'course_name' => $row['course_name'],
            'start_time' => $row['start_time']
        ];
    }
}

$query ="SELECT c.class_date,c.start_time,c.end_time,cu.course_code,cu.course_name FROM uoj_class AS c LEFT JOIN uoj_course as cu ON c.course_id=cu.course_id  WHERE c.class_date>now()";
$result = mysqli_query($conn, $query);

if ($result && mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $classDate = $row['class_date'];
        $attendanceStatus = 9;

        // Store the attendance info for each day
        $attendance[$classDate][] = [
            'status' => $attendanceStatus,
            'course_code' => $row['course_code'],
            'course_name' => $row['course_name'],
            'start_time' => $row['start_time']
        ];
    }
}

// Get the current month and year, or use the ones passed via URL
$month = isset($_GET['month']) ? (int)$_GET['month'] : (int)date('m');
$year = isset($_GET['year']) ? (int)$_GET['year'] : (int)date('Y');

// Helper function to get the current month's calendar
function render_calendar($year, $month, $attendance) {
    // Start of calendar structure
    $calendar = '<div class="calendar-container">';
    $prevMonth = date('m', strtotime("$year-$month-01 -1 month"));
    $prevYear = date('Y', strtotime("$year-$month-01 -1 month"));
    $nextMonth = date('m', strtotime("$year-$month-01 +1 month"));
    $nextYear = date('Y', strtotime("$year-$month-01 +1 month"));

    
    // Header with month and year
    //$calendar .= '<div class="calendar-header">' . date('F Y', strtotime("$year-$month-01")) . '</div>';
    
    // Navigation buttons for changing the month
    
    $calendar .= '
        <div class="calendar-nav">
            <a href="?month=' . $prevMonth . '&year=' . $prevYear . '" class="prev-month">⬅️</a>';
    $calendar .=  date('F Y', strtotime("$year-$month-01")) ;
    $calendar .=  '<a href="?month=' . $nextMonth . '&year=' . $nextYear . '" class="next-month">➡️</a>
        </div>';
    
    // Calendar table
    $calendar .= '<table class="calendar-table">';
    $calendar .= '<tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr>';
    
    // Get the first day of the month and the total number of days in the month
    $firstDay = strtotime("$year-$month-01");
    $totalDays = date('t', $firstDay);
    $startingDay = date('w', $firstDay);  // Day of the week the month starts
    
    // Start the calendar rows
    $currentDay = 1;
    $calendar .= '<tr>';
    
    // Add empty cells for days before the start of the month
    for ($i = 0; $i < $startingDay; $i++) {
        $calendar .= '<td></td>';
    }
    
    // Loop through each day in the month
    for ($day = $startingDay; $day < 7; $day++) {
        $date = "$year-$month-" . str_pad($currentDay, 2, '0', STR_PAD_LEFT);
        $attendanceStatusHTML = '';

        // Check if there is any class on this date
        if (isset($attendance[$date])) {
            foreach ($attendance[$date] as $class) {
                // Determine the color for the attendance status
                switch ($class['status']) {
                    case 1:
                        $color = 'green';  // Present
                        break;
                    case 0:
                        $color = 'red';    // Absent
                        break;
                    case 2:
                        $color = 'yellow'; // Excused
                        break;
                    case 9:
                        $color = 'pink'; // Excused
                        break;
                    default:
                        $color = '#0000ff';   // Unknown status
                }
                // Display the course code with the color
                $attendanceStatusHTML .= "<div style='color: $color;'>{$class['course_code']} - {$class['course_name']}</div>";
            }
        }

        // Display the day with the attendance information
        $calendar .= "<td class='calendar-day'>";
        $calendar .= "<div class='day-number'>$currentDay</div>";
        if (!empty($attendanceStatusHTML)) {
            $calendar .= "<div class='attendance-status'>$attendanceStatusHTML</div>";
        }
        $calendar .= "</td>";

        $currentDay++;
        if ($currentDay > $totalDays) {
            break;
        }
    }

    // Close the first row
    $calendar .= '</tr>';

    // Continue creating rows for the rest of the days
    while ($currentDay <= $totalDays) {
        $calendar .= '<tr>';
        for ($day = 0; $day < 7; $day++) {
            if ($currentDay <= $totalDays) {
                $date = "$year-$month-" . str_pad($currentDay, 2, '0', STR_PAD_LEFT);
                $attendanceStatusHTML = '';
                
                // Check if there is any class on this date
                if (isset($attendance[$date])) {
                    foreach ($attendance[$date] as $class) {
                        // Determine the color for the attendance status
                        switch ($class['status']) {
                            case 1:
                                $color = 'green';  // Present
                                break;
                            case 0:
                                $color = 'red';    // Absent
                                break;
                            case 2:
                                $color = 'yellow'; // Excused
                                break;
                            default:
                                $color = 'gray';   // Unknown status
                        }
                        // Display the course code with the color
                        $attendanceStatusHTML .= "<div style='color: $color;'>{$class['course_code']} - {$class['course_name']}</div>";
                    }
                }
                
                // Display the day with the attendance information
                $calendar .= "<td class='calendar-day'>";
                $calendar .= "<div class='day-number'>$currentDay</div>";
                if (!empty($attendanceStatusHTML)) {
                    $calendar .= "<div class='attendance-status'>$attendanceStatusHTML</div>";
                }
                $calendar .= "</td>";
                
                $currentDay++;
            } else {
                // Empty cells after the last day of the month
                $calendar .= '<td></td>';
            }
        }
        $calendar .= '</tr>';
    }

    // Close the table and the calendar container
    $calendar .= '</table></div>';
    return $calendar;
}

// Render the calendar
echo render_calendar($year, $month, $attendance);
?>




</div>


        <?php
        include ROOT_PATH . '/php/include/footer.php';
        ?>