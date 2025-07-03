<?php
include 'includes/config.php';
include 'includes/auth.php';

$error = '';
$nameErr = $emailErr = $passErr  = "";
$name = $email = $comment = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty($_POST["email"])) {
        $emailErr = "Email is required";
    } else {
        $email = test_input($_POST["email"]);
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $emailErr = "Invalid email format";
        }
    }

    if (empty($_POST["password"])) {
        $passErr = "Password is required";
    } else {
        $password = test_input($_POST["password"]);
    }

    if (empty($emailErr) && empty($passErr)) {
        if (attempt_login($email, $password)) {
            $user_type = get_user_type();
            echo("$user_type");

            if ($user_type === 'admin') {
                header("Location: dashboards/admin.php");
            } elseif ($user_type === 'manager') {
                header("Location: dashboards/manager.php");
            } else {
                // Default redirect for customers or other types
                header("Location: index.php");
            }
            exit;
        } else {
            $error = "Invalid email or password";
        }
    }
}

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>

<!DOCTYPE HTML>
<html>
<head>
    <title>Login - AMM Games</title>
    <style>
    .error {color: #FF0000;}
    </style>
</head>
<body>
    <h1>AMM Games Login</h1>
    <?php if ($error): ?>
        <p><font color="red"><?php echo htmlspecialchars($error); ?></font></p>
    <?php endif; ?>

    <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
        <table>
            <tr>
                <td>Email:</td>
                <td><input type="text" name="email" required></td>
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



<?php
echo "<h2>Your Input:</h2>";
echo $email;
echo "<br>";
echo $password;
echo "<br>";

echo "<br>";

echo "<br>";

?>

</body>
</html>
