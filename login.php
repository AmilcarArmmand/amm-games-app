<?php
require_once 'includes/config.php';
require_once 'includes/auth.php';

$error = '';
$nameErr = $emailErr = $passErr  = "";
$name = $email = $comment = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["username"])) {
    $nameErr = "Name is required";
  } else {
    $username = test_input($_POST["username"]);
    // check if name only contains letters and whitespace
    if (!preg_match("/^[a-zA-Z-' ]*$/",$username)) {
      $nameErr = "Only letters and white space allowed";
    }
  }

  if (empty($_POST["email"])) {
    $emailErr = "Email is required";
  } else {
    $email = test_input($_POST["email"]);
    // check if e-mail address is well-formed
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $emailErr = "Invalid email format";
    }
  }

  if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["password"])) {
    $passErr = "Password is required";
  } else {
    $password = test_input($_POST["password"]);
  }
  }

  if (attempt_login($username, $password)) {

      /* Get user type from session (set during login) */
      $user_type = $_SESSION['user_type'];

      /* Redirect based on user type */
      switch($user_type) {
      case 'admin':
          header("Location: dashboards/admin.php");
          break;
      case 'manager':
          header("Location: dashboards/manager.php");
          break;
      case 'clerk':
          header("Location: dashboards/staff.php");
          break;
      case 'customer':
          header("Location: dashboards/customer.php");
          break;
      default:
          header("Location: dashboards/customer.php"); // Default fallback
      }
      exit;
  } else {
      $error = "Invalid username or password";
  }

}
function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Login - AMM Games</title>
    <style>
    .error {color: #FF0000;}
    </style>
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

<h2>PHP Form Validation Example</h2>
<p><span class="error">* required field</span></p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
  Name: <input type="text" name="name" value="<?php echo $name;?>">
  <span class="error">* <?php echo $nameErr;?></span>
  <br><br>
  E-mail: <input type="text" name="email" value="<?php echo $email;?>">
  <span class="error">* <?php echo $emailErr;?></span>
  <br><br>


  <br><br>

  <br><br>

  <br><br>
  <input type="submit" name="submit" value="Submit">
</form>

<?php
echo "<h2>Your Input:</h2>";
echo $name;
echo "<br>";
echo $email;
echo "<br>";

echo "<br>";

echo "<br>";

?>

</body>
</html>
