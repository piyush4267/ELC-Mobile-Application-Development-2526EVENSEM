<?php
// fetch_students.php
// Place this file inside: C:/xampp/htdocs/student_api/

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
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

// Only accept GET requests
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode([
        "success" => false,
        "message" => "Only GET method is allowed."
    ]);
    exit();
}

// Fetch all students ordered by most recent first
$result = $conn->query("SELECT * FROM students ORDER BY id DESC");

if (!$result) {
    echo json_encode([
        "success" => false,
        "message" => "Query failed: " . $conn->error
    ]);
    exit();
}

$students = [];
while ($row = $result->fetch_assoc()) {
    $students[] = [
        "id"          => $row['id'],
        "name"        => $row['name'],
        "roll_number" => $row['roll_number'],
        "email"       => $row['email'],
        "cgpa"        => $row['cgpa'],
    ];
}

echo json_encode([
    "success"  => true,
    "count"    => count($students),
    "students" => $students
]);

$conn->close();
?>
