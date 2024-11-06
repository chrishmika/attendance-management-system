<?php
// Keep your database connection logic intact
include_once 'config.php';
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/config/Database.php'; 
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/class/Utils.php';
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/class/User.php';
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/class/Lecturer.php';

// Initializing
$database = new Database();
$db = $database->getConnection();
$user = new User($db);
$lecr = new Lecturer($db);
$util = new Utils();

if ($user->isLoggedIn()) {
    if ($user->isAdmin()) {
        header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/admin_dashboard.php");
    } else if ($user->isLecturer()) {
        header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/lecturer_dashboard.php");
    } else if ($user->isInstructor()) {
        header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/instructor_dashboard.php");
    } else if ($user->isStudent()) {
        header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/student_dashboard.php");
    }
}

if (isset($_POST['sign_in'])) {
    $username = $_POST['reg-name'] ?? null;
    $password = $_POST['user_password'] ?? null;
    $rememberMe = $_POST['rem_me'] ?? null;

    if ($user->login($username, $password, $rememberMe)) {
        if ($user->isAdmin()) {
            header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/admin_dashboard.php");
        } else if ($user->isLecturer()) {
            header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/lecturer_dashboard.php");
        } else if ($user->isInstructor()) {
            header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/instructor_dashboard.php");
        } else if ($user->isStudent()) {
            header("Location: " . SERVER_ROOT . "/var/www/html/group7/attendance-management-system/php/student_dashboard.php");
        } else {
            echo "Something went wrong!";
        }
    } else {
        $message[] = $user->getLoginMessage();
        $_POST = array();
        $_SESSION["error"] = $message;
        $logInfoModal = $util->setMessage($message, 'alert', 'danger');
        echo $logInfoModal;
    }
}
?>

<?php
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/include/header.php';
echo "<title> AMS Dashboard </title>";
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/include/content.php';
?>

<!-- Custom CSS for enhanced professional look -->
<style>
    body {
        background-color: #f0f4f8;
        font-family: 'Arial', sans-serif;
        color: #333;
    }
    .dashboard-header {
        background-color: #007bff;
        color: white;
        padding: 30px 0;
        text-align: center;
        border-radius: 0 0 15px 15px;
        position: relative;
    }
    .dashboard-header h1 {
        font-weight: 700;
        font-size: 2.5rem;
        margin-bottom: 0;
    }
    .dashboard-header img {
        position: absolute;
        top: 10px;
        left: 10px;
        width: 60px;
        height: 60px;
    }
    .login-section {
        margin-top: 60px;
        text-align: center;
    }
    .login-section .btn {
        font-size: 1.2rem;
        padding: 15px 30px;
        border-radius: 30px;
        background-color: #007bff;
        color: #fff;
        box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        transition: all 0.3s ease;
    }
    .login-section .btn:hover {
        background-color: #0056b3;
        box-shadow: 0 6px 15px rgba(0, 123, 255, 0.5);
    }
    .modal-content {
        border-radius: 20px;
        padding: 20px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        background: #fff;
    }
    .form-floating {
        margin-bottom: 15px;
    }
    .form-control {
        border-radius: 8px;
        padding: 10px;
        border: 1px solid #ddd;
    }
    .form-check-input {
        margin-top: 10px;
    }
    .modal-header {
        border-bottom: none;
    }
    .modal-title {
        font-weight: 700;
        color: #007bff;
    }
    .modal-footer {
        border-top: none;
    }
    .modal-footer p {
        margin-bottom: 0;
        font-size: 0.9rem;
        color: #777;
    }
    .footer-text {
        margin-top: 20px;
        font-size: 0.9rem;
        text-align: center;
        color: #777;
    }
</style>

<!-- Dashboard content begins -->
<div class="dashboard-header">
    <!-- System logo -->
    <img src="<?php echo SERVER_ROOT; ?>/var/www/html/group7/attendance-management-system/res/logo/AMS_logo_w.png" alt="System Logo">
    <h1>Attendance Management System (AMS)</h1>
    <p class="lead">Streamline your attendance management with ease.</p>
</div>

<div class="container login-section">
    <p class="lead">Log in to access your personalized dashboard</p>
    <!-- Login Button triggers modal -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
        Login
    </button>
</div>

<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">Login to AMS</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Login Form inside the modal -->
                <form action="" method="post" class="form">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="reg-name" name="reg-name" placeholder="2020csc000" autocomplete="username" required>
                        <label for="reg-name">Registration No:</label>
                    </div>
                    <div class="form-floating">
                        <input type="password" class="form-control" id="user_password" name="user_password" placeholder="Password" autocomplete="current-password" required>
                        <label for="user_password">Password</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="rem_me" name="rem_me" id="rem_me">
                        <label class="form-check-label" for="rem_me">Remember me</label>
                    </div>
                    <button type="submit" class="btn btn-primary w-100" name="sign_in" id="sign_in">Sign in</button>
                    
                    <!-- Forgot password and Don't have an account -->
                    <div class="mt-4 text-center">
                        <p>
                            <a href="#" class="link-underline link-opacity-75-hover">Forgot your password?</a>
                        </p>
                        <p>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#reg_user" class="link-underline link-opacity-75-hover">Don't have an account?</a>
                        </p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <p class="text-center w-100 footer-text">&copy; 2023 Attendance Management System</p>
            </div>
        </div>
    </div>
</div>

<?php
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/include/modal_form.php';
include_once ROOT_PATH . '/var/www/html/group7/attendance-management-system/php/include/footer.php';
?>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
