CREATE TABLE fingerprint_scans (
    scan_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,  -- Nullable in case the scan is unsuccessful or the user is unknown
    scan_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Success', 'Failure') NOT NULL,
    error_message VARCHAR(255),  -- Stores error messages for failed attempts
    device_id VARCHAR(50),  -- Optional: Track which fingerprint device was used
    ip_address VARCHAR(45),  -- To track the IP address of the request, useful for security

    -- Foreign key constraint to link to users table if user ID is available
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

//to form action.php
<form id="registrationForm" action="register_user.php" method="POST">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <!-- Capture Fingerprint Button -->
    <button type="button" onclick="captureFingerprint()">Capture Fingerprint</button>

    <!-- Hidden field to store fingerprint template -->
    <input type="hidden" id="fingerprint_template" name="fingerprint_template">
    
    <button type="submit">Register</button>
</form>

<script>
    function captureFingerprint() {
        // Make an AJAX request to capture the fingerprint template
        fetch('capture_fingerprint.php')
            .then(response => response.text())
            .then(data => {
                if (data) {
                    // Store the fingerprint template in the hidden input
                    document.getElementById('fingerprint_template').value = data;
                    alert("Fingerprint captured successfully.");
                } else {
                    alert("Fingerprint capture failed.");
                }
            });
    }
</script>


//to form action.php
<?php
// Database connection
$conn = new mysqli("localhost", "username", "password", "database");

// Retrieve form inputs
$username = $_POST['username'];
$email = $_POST['email'];
$encryptedTemplate = $_POST['fingerprint_template']; // Encrypted fingerprint

// Insert new user record with encrypted fingerprint template
$stmt = $conn->prepare("INSERT INTO users (username, email, fingerprint_template) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $username, $email, $encryptedTemplate);

if ($stmt->execute()) {
    echo "User registered successfully!";
} else {
    echo "Registration failed: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>


//to mark_attendance.php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance</title>
    <script>
        // JavaScript function to initiate fingerprint capture
        function startFingerprintScan() {
            // AJAX request to capture fingerprint
            fetch('capture_fingerprint_for_attendance.php')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Call PHP to mark attendance with the captured template
                        markAttendance(data.template);
                    } else {
                        alert("Fingerprint scan failed. Please try again.");
                    }
                })
                .catch(error => {
                    console.error("Error capturing fingerprint:", error);
                    alert("Fingerprint scan failed. Please try again.");
                });
        }

        // AJAX request to mark attendance
        function markAttendance(fingerprintTemplate) {
            fetch('mark_attendance_action.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ fingerprint_template: fingerprintTemplate })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Attendance marked successfully.");
                } else {
                    alert(data.message || "Attendance marking failed.");
                }
            })
            .catch(error => {
                console.error("Error marking attendance:", error);
            });
        }
    </script>
</head>
<body>
    <h2>Mark Attendance</h2>
    <p>Press the button below and scan your fingerprint to mark attendance.</p>
    <button onclick="startFingerprintScan()">Scan Fingerprint</button>
</body>
</html>


//Create capture_fingerprint_for_attendance.php for Fingerprint Capture
This file will handle the fingerprint capture and 
return the encrypted fingerprint template to the JavaScript function in JSON format.

<?php
include_once 'fingerprint_wrapper.php'; // Wrapper with fingerprint and encryption functions

// Capture the fingerprint
$fingerprintTemplate = captureFingerprint();

if ($fingerprintTemplate) {
    // Encrypt the fingerprint template before returning
    $encryptedTemplate = encryptTemplate($fingerprintTemplate);
    echo json_encode(['success' => true, 'template' => $encryptedTemplate]);
} else {
    echo json_encode(['success' => false]);
}
?>


//Update mark_attendance_action.php to Validate Fingerprint and Mark Attendance
Modify mark_attendance_action.php to 
accept the fingerprint template and compare it with stored templates in the database.

<?php
include_once 'fingerprint_wrapper.php'; // Wrapper with matching function and decryption
include_once 'db_connect.php'; // Connect to the database

// Get JSON input
$data = json_decode(file_get_contents('php://input'), true);
$fingerprintTemplate = $data['fingerprint_template'] ?? null;

if ($fingerprintTemplate) {
    // Retrieve all users' fingerprint templates
    $stmt = $conn->prepare("SELECT user_id, fingerprint_template FROM users");
    $stmt->execute();
    $result = $stmt->get_result();

    $matchedUserId = null;

    // Loop through stored templates to find a match
    while ($row = $result->fetch_assoc()) {
        $storedTemplate = decryptTemplate($row['fingerprint_template']);
        
        // If the captured template matches a stored template, get the user ID
        if (matchFingerprints($fingerprintTemplate, $storedTemplate)) {
            $matchedUserId = $row['user_id'];
            break;
        }
    }
    
    if ($matchedUserId) {
        // Record attendance for the matched user
        $stmt = $conn->prepare("INSERT INTO attendance (user_id, date, time, status) VALUES (?, CURDATE(), CURTIME(), 'Present')");
        $stmt->bind_param("i", $matchedUserId);
        $stmt->execute();
        $stmt->close();

        echo json_encode(['success' => true, 'message' => "Attendance marked for user ID: $matchedUserId"]);
    } else {
        echo json_encode(['success' => false, 'message' => "Fingerprint did not match any user"]);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => "No fingerprint template received"]);
}

$conn->close();
?>




