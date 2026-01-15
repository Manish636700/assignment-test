<?php
$host = 'mysql';
$user = 'appuser';
$pass = 'app123';
$db = 'appdb';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

echo " Application successfully connected to mysql.";
?>