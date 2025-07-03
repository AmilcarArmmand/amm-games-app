<?php
require 'functions.php';
redirect_if_not_logged_in();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h1>Welcome to Dashboard</h1>
    <p>You are logged in as admin.</p>
    <a href="logout.php">Logout</a>
</body>
</html>
