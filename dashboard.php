<?php
require_once 'includes/config.php';
require_once 'includes/auth.php';

redirect_if_not_logged_in();

// Get user type from URL parameter
$user_type = isset($_GET['type']) ? $_GET['type'] : 'unknown';
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - AMM Games</title>
</head>
<body>
    <h1>Welcome to Dashboard</h1>

    <?php
    if ($user_type === 'admin') {
        echo "<p>You are logged in as an administrator.</p>";
    } elseif ($user_type === 'customer') {
        echo "<p>You are logged in as a customer.</p>";
    } else {
        echo "<p>You are logged in.</p>";
    }
    ?>

    <p>User ID: <?php echo $_SESSION['user_id']; ?></p>
    <a href="logout.php">Logout</a>
</body>
</html>
