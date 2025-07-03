<html>
<body>
<form action="salaries.php" method="POST">
location ID: <input type="text" name="location_id"><br>
<input type="submit">
</form>

<?php
if (isset($_POST['location_id'])) {

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "amm_games_db";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $location_id = mysqli_real_escape_string($conn, $_POST['location_id']);

    $sql = "SELECT employee_id, first_name, last_name, salary
            FROM employees
            WHERE location_id = '$location_id'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table border='1'>";
        echo "<tr><th>Employee ID</th><th>First Name</th><th>Last Name</th><th>Salary</th></tr>";

        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row["employee_id"]) . "</td>";
            echo "<td>" . htmlspecialchars($row["first_name"]) . "</td>";
            echo "<td>" . htmlspecialchars($row["last_name"]) . "</td>";
            echo "<td>" . htmlspecialchars($row["salary"]) . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "No employees found for location ID: " . htmlspecialchars($location_id);
    }

    $conn->close();
}
?>
</body>
</html>
