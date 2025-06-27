<?php
session_start();

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$role = $_SESSION['role'];
$conn = new mysqli('localhost', 'amm_gaems_dev', 'amm_games_dev_pwd', 'amm_games_dev_db');
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['add'])) {
        $name = $_POST['name'];
        $description = $_POST['description'];
        $stmt = $conn->prepare("INSERT INTO data (name, description) VALUES (?, ?)");
        $stmt->bind_param("ss", $name, $description);
        $stmt->execute();
        $stmt->close();
    } elseif (isset($_POST['edit'])) {
        $id = $_POST['id'];
        $name = $_POST['name'];
        $description = $_POST['description'];
        $stmt = $conn->prepare("UPDATE data SET name = ?, description = ? WHERE id = ?");
        $stmt->bind_param("ssi", $name, $description, $id);
        $stmt->execute();
        $stmt->close();
    } elseif (isset($_POST['delete'])) {
        $id = $_POST['id'];
        $stmt = $conn->prepare("DELETE FROM data WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $stmt->close();
    }
}

$result = $conn->query("SELECT * FROM data");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Add Data</h2>
    <form method="post" action="">
        Name: <input type="text" name="name"><br>
        Description: <textarea name="description"></textarea><br>
        <input type="submit" name="add" value="Add Data">
    </form>

    <?php if ($role == 'admin'): ?>
        <h2>Edit/Delete Data</h2>
        <form method="post" action="">
            <select name="id">
                <?php while ($row = $result->fetch_assoc()): ?>
                    <option value="<?php echo $row['id']; ?>"><?php echo $row['name']; ?></option>
                <?php endwhile; ?>
            </select><br>
            Name: <input type="text" name="name"><br>
            Description: <textarea name="description"></textarea><br>
            <input type="submit" name="edit" value="Edit Data">
            <input type="submit" name="delete" value="Delete Data">
        </form>
    <?php endif; ?>

    <h2>Current Data</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
        </tr>
        <?php
        $result = $conn->query("SELECT * FROM data");
        while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?php echo $row['id']; ?></td>
                <td><?php echo $row['name']; ?></td>
                <td><?php echo $row['description']; ?></td>
            </tr>
        <?php endwhile; ?>
    </table>
</body>
</html>

<?php
$conn->close();
?>
