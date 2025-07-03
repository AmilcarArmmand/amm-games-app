<?php
require 'config.php';

function db_connect() {
    $conn = mysqli_connect('DB_HOST', 'DB_USER', 'DB_PASS', 'DB_PASS');
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }
    return $conn;
}

function attempt_login($username, $password) {
    $conn = db_connect();

    $query = "SELECT p.user_id, p.password, a.admin_id
              FROM person p
              JOIN employees e ON p.user_id = e.user_id
              JOIN admin a ON e.employee_id = a.employee_id
              WHERE p.username = ? AND p.is_active = 1";

    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "s", $username);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if (mysqli_num_rows($result) == 1) {
        $user = mysqli_fetch_assoc($result);
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['user_id'];
            $_SESSION['admin_id'] = $user['admin_id'];
            $_SESSION['logged_in'] = true;
            return true;
        }
    }

    mysqli_close($conn);
    return false;
}

function is_logged_in() {
    return isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true;
}

function redirect_if_not_logged_in() {
    if (!is_logged_in()) {
        header("Location: login.php");
        exit;
    }
}
?>
