-- prepares a MySQL/Mariadb server for the project

CREATE DATABASE IF NOT EXISTS amm_games_dev_db;
CREATE USER IF NOT EXISTS 'amm_games_dev'@'localhost' IDENTIFIED BY 'amm_games_dev_pwd';
GRANT ALL PRIVILEGES ON `amm_games_dev_db`.* TO 'amm_games_dev'@'localhost';
GRANT SELECT ON `performance_schema`.* TO 'amm_games_dev'@'localhost';
FLUSH PRIVILEGES;
