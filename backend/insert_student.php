<?php
// insert_student.php
// Place this file inside: C:/xampp/htdocs/student_api/

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// ── Database configuration ─────────────────────────────────────
$host     = "localhost";
$username = "root";
$password = "";          // Default XAMPP password is empty
$database = "student_db";
// ───────────────────────────────────────────────────────────────

// Connect to MySQL
$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Database connection failed: " . $conn->connect_error
    ]);
    exit();
}

// Only accept POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Only POST method is allowed."
    ]);
    exit();
}

// Read JSON body sent from Flutter
$body = file_get_contents("php://input");
$data = json_decode($body, true);

if (!$data) {
    echo json_encode([
        "success" => false,
        "message" => "Invalid JSON body."
    ]);
    exit();
}

// Extract and sanitize fields
$name        = trim($conn->real_escape_string($data['name']        ?? ''));
$roll_number = trim($conn->real_escape_string($data['roll_number'] ?? ''));
$email       = trim($conn->real_escape_string($data['email']       ?? ''));
$cgpa        = floatval($data['cgpa'] ?? 0);

// Basic validation
if (empty($name) || empty($roll_number) || empty($email)) {
    echo json_encode([
        "success" => false,
        "message" => "Name, Roll Number, and Email are required."
    ]);
    exit();
}

if ($cgpa < 0 || $cgpa > 10) {
    echo json_encode([
        "success" => false,
        "message" => "CGPA must be between 0 and 10."
    ]);
    exit();
}

// Insert using prepared statement (prevents SQL injection)
$stmt = $conn->prepare(
    "INSERT INTO students (name, roll_number, email, cgpa) VALUES (?, ?, ?, ?)"
);
$stmt->bind_param("sssd", $name, $roll_number, $email, $cgpa);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Student registered successfully!",
        "id"      => $conn->insert_id
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Failed to insert record: " . $stmt->error
    ]);
}

$stmt->close();
$conn->close();
?>
