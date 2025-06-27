-- prepares a MySQL/Mariadb server for the project

CREATE DATABASE IF NOT EXISTS amm_games_dev_db;

USE amm_games_dev_db;

CREATE TABLE data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

INSERT INTO users (username, password, role) VALUES ('admin', 'adminpass', 'admin');
INSERT INTO users (username, password, role) VALUES ('user', 'userpass', 'user');
