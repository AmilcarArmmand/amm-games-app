 <?php
include  __DIR__ . '/../config/db_config.php';
// require_once __DIR__ . '/../config/db_config.php';

class Database {
    private $conn;

    public function __construct() {
        $this->conn = new mysqli(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);

        if ($this->conn->connect_error) {
            die("Connection failed: " . $this->conn->connect_error);
        }
    }

    public function getConnection() {
        return $this->conn;
    }

    public function closeConnection() {
        if ($this->conn) {
            $this->conn->close();
        }
    }
}
?>
