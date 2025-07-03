

<?php
include 'config.php';

function db_connect() {

    /* Create connection using global variables  */
    $conn = @new mysqli($GLOBALS['DB_HOST'], $GLOBALS['DB_USER'], $GLOBALS['DB_PASS'], $GLOBALS['DB_NAME']);

    /* Check connection */
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    return $conn;
}


function attempt_login($email, $password) {
    $conn = db_connect();

    $query = "SELECT p.email, p.password, e.position
              FROM person p
              LEFT JOIN employees e ON p.user_id = e.user_id
              WHERE p.email = ? AND p.is_active = 1";

    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['user_id'];
            $_SESSION['logged_in'] = true;
            $_SESSION['user_type'] = $user['position'] ?? 'customer';
            return true;
        }
    }

    $conn->close();
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

function get_user_type() {
    return $_SESSION['user_type'] ?? null;
}
?>
