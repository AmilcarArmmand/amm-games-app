<?php
$servername = "localhost";
$username = "amm_games_dev";
$password = "amm_games_dev_pwd";
$dbname = "amm_games_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
