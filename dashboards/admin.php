<?php
include '../includes/auth.php';
include '../includes/config.php';

redirect_if_not_logged_in();

if (get_user_type() !== 'sysadmin') {
    header("Location: ../login.php");
    exit;
}
?>

<!DOCTYPE HTML>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <p>Welcome, SYSAdminr</p>

    <h2>Admin Tools</h2>
    <ul>
        <li><a href="#">Manage Users</a></li>
        <li><a href="#">View Reports</a></li>
        <li><a href="#">System Settings</a></li>
    </ul>

    <p><a href="../logout.php">Logout</a></p>
</body>
</html>
