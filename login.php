<?php
require_once 'includes/config.php';
require_once 'includes/auth.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    if (attempt_login($username, $password)) {
        // Check user type and redirect accordingly
        $conn = db_connect();
        $user_id = $_SESSION['user_id'];

        // Check if admin
        $admin_check = mysqli_query($conn,
            "SELECT a.admin_id FROM admin a
             JOIN employees e ON a.employee_id = e.employee_id
             WHERE e.user_id = $user_id");

        // Check if customer
        $customer_check = mysqli_query($conn,
            "SELECT customer_id FROM customer WHERE user_id = $user_id");

        if (mysqli_num_rows($admin_check) > 0) {
            header("Location: dashboard.php?type=admin");
        } elseif (mysqli_num_rows($customer_check) > 0) {
            header("Location: dashboard.php?type=customer");
        } else {
            header("Location: dashboard.php");
        }
        exit;
    } else {
        $error = "Invalid username or password";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login - AMM Games</title>
</head>
<body>
    <h1>Login</h1>

    <?php if ($error): ?>
        <p><font color="red"><?php echo htmlspecialchars($error); ?></font></p>
    <?php endif; ?>

    <form method="POST">
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" name="username" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" required></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Login"></td>
            </tr>
        </table>
    </form>
</body>
</html>
