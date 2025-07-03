

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


/*
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
*/

?>
