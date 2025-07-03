<?php

for($i=0;$i<5;$i++){
	echo "My first PHP script!";
	echo "<br>";
}
?>


<?php
// Redirect to login by default
header("Location: login.php");
exit;
?>
