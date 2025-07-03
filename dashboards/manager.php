?>

<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
</head>
<body>
    <h1>Manager Dashboard</h1>
    <p>Welcome, Manager</p>

    <h2>Management Tools</h2>
    <ul>
        <li><a href="#">View Inventory</a></li>
        <li><a href="#">Staff Management</a></li>
        <li><a href="#">Sales Reports</a></li>
    </ul>

    <p><a href="../logout.php">Logout</a></p>
</body>
</html>
```

### 6. Updated logout.php
```php
<?php
include '../includes/config.php';
include '../includes/auth.php';

session_unset();
session_destroy();
header("Location: login.php");
exit;
?>
