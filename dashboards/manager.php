<?php
require_once '../includes/config.php';
require_once '../includes/auth.php';

redirect_if_not_logged_in();

if (get_user_type() !== 'manager') {
    header("Location: ../login.php");
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
</head>
<body>
    <h1>Manager Dashboard</h1>
    <p>Welcome, Manager</p>
    <p><a href="../logout.php">Logout</a></p>
</body>
</html>
