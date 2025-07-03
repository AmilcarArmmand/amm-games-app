<!DOCTYPE html>
<html>
<head>
    <title>Create, Update, Delete Membership</title>
</head>
<body>
    <center>
        <h3>Create Membership</h3>
        <form action="memberships.php" method="POST">
            Subscription ID
            <input name="subscription_id" required type="number"/>
            <br/><br/>
            Customer ID
            <input name="customer_id" required type="number"/>
            <br/><br/>
            Start Date
            <input name="start_date" required type="date"/>
            <br/><br/>
            End Date
            <input name="end_date" required type="date"/>
            <br/><br/>
            Auto Renew?
            <select name="auto_renew" required>
                <option value="1">Yes</option>
                <option value="0">No</option>
            </select>
            <br/><br/>
            Rewards Points
            <input name="rewards_points" required type="number"/>
            <br/><br/>
            <input type="submit" value="Create Membership"/>
        </form>

        <br/><br/>

        <form action="memberships.php" method="POST">
            <h3>Update Membership</h3>
            Membership ID
            <input name="membership_id" required type="number"/>
            <br/><br/>
            Subscription ID
            <input name="subscription_id" required type="number"/>
            <br/><br/>
            Customer ID
            <input name="customer_id" required type="number"/>
            <br/><br/>
            Start Date
            <input name="start_date" required type="date"/>
            <br/><br/>
            End Date
            <input name="end_date" required type="date"/>
            <br/><br/>
            Auto Renew?
            <select name="auto_renew" required>
                <option value="1">Yes</option>
                <option value="0">No</option>
            </select>
            <br/><br/>
            Rewards Points
            <input name="rewards_points" required type="number"/>
            <br/><br/>
            <input type="submit" name="update" value="Update Membership"/>
        </form>

        <br/><br/>

        <form action="memberships.php" method="POST">
            <h3>Delete Membership</h3>
            Membership ID
            <input name="membership_id" required type="number"/>
            <br/><br/>
            <input type="submit" name="delete" value="Delete Membership"/>
        </form>
    </center>
</body>
</html>

<?php
include '../includes/auth.php';
include '../includes/config.php';

$conn = db_connect();

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_POST['update'])) {
    $membership_id = mysqli_real_escape_string($conn, $_POST['membership_id']);
    $subscription_id = mysqli_real_escape_string($conn, $_POST['subscription_id']);
    $customer_id = mysqli_real_escape_string($conn, $_POST['customer_id']);
    $start_date = mysqli_real_escape_string($conn, $_POST['start_date']);
    $end_date = mysqli_real_escape_string($conn, $_POST['end_date']);
    $auto_renew = mysqli_real_escape_string($conn, $_POST['auto_renew']);
    $rewards_points = mysqli_real_escape_string($conn, $_POST['rewards_points']);

    $sql = "UPDATE membership SET subscription_id='$subscription_id', customer_id='$customer_id', start_date='$start_date', end_date='$end_date', auto_renew='$auto_renew', rewards_points='$rewards_points' WHERE membership_id='$membership_id' AND subscription_id = '$subscription_id'";

    if ($conn->query($sql) === TRUE) {
        echo "Membership updated successfully";
    } else {
        echo "Error updating membership: " . $conn->error;
    }
} elseif (isset($_POST['delete'])) {
    $membership_id = mysqli_real_escape_string($conn, $_POST['membership_id']);
    $sql = "DELETE FROM membership WHERE membership_id='$membership_id'";

    if ($conn->query($sql) === TRUE) {
        echo "Membership deleted successfully";
    } else {
        echo "Error deleting membership: " . $conn->error;
    }
} else {
    //create new
    $subscription_id = mysqli_real_escape_string($conn, $_POST['subscription_id']);
    $customer_id = mysqli_real_escape_string($conn, $_POST['customer_id']);
    $start_date = mysqli_real_escape_string($conn, $_POST['start_date']);
    $end_date = mysqli_real_escape_string($conn, $_POST['end_date']);
    $auto_renew = mysqli_real_escape_string($conn, $_POST['auto_renew']);
    $rewards_points = mysqli_real_escape_string($conn, $_POST['rewards_points']);

    $sql = "INSERT INTO membership (subscription_id, customer_id, start_date, end_date, auto_renew, rewards_points)
            VALUES ('$subscription_id', '$customer_id', '$start_date', '$end_date', '$auto_renew', '$rewards_points')";

    if ($conn->query($sql) === TRUE) {
        echo "New membership created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>
