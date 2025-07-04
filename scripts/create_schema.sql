-- MySQL script that creates the database

-- Drop database if it exists
drop database if exists amm_games_db;

-- create
create database if not exists amm_games_db;

-- set database server to active
use amm_games_db;

-- drop tables if they exist (reverse order)
drop table if exists product_budget;
drop table if exists inventory;
drop table if exists participant;
drop table if exists tournament;
drop table if exists budget;
drop table if exists restocking;
drop table if exists distributor;
drop table if exists product_inventory;
drop table if exists shipment;
drop table if exists ordered_item;
drop table if exists orders;
drop table if exists membership;
drop table if exists subscription;
drop table if exists product;
drop table if exists genre;
drop table if exists category;
drop table if exists customer;
drop table if exists location_staff;
drop table if exists manages;
drop table if exists manager;
drop table if exists admin;
drop table if exists employees;
drop table if exists user_type;
drop table if exists locations;
drop table if exists person;

-- create the user table
create table person (
       user_id           int auto_increment,
       email             varchar(255),
       username          varchar(255) not null,
       password          varchar(255) not null,
       first_name        varchar(50) not null,
       last_name         varchar(50) not null,
       phone_number      varchar(15),
       date_registered   datetime not null,
       last_login        datetime not null,
       is_active         boolean not null default 1,
       primary key (user_id),
       INDEX idx_person_email (email),
       INDEX idx_person_username (username)
       );


-- business locations table
create table locations (
       location_id         int auto_increment,
       address             varchar(255) not null,
       storage_capacity    int not null,
       primary key (location_id)
       );

-- create job description types
create table user_type (
       user_type       varchar(255) not null unique,
       primary key (user_type)
       );

-- create the table employee
create table employees (
       employee_id      int auto_increment,
       user_id          int not null,
       position         varchar(255),
       user_type        enum ('clerk', 'manager', 'sysadmin') not null,
       salary           decimal(10,2) not null,
       hire_date        date not null,
       primary key (employee_id),
       foreign key (user_id) references person (user_id),
       INDEX idx_employee_user (user_id)
       );


-- Create the admin table
create table admin (
       admin_id          int auto_increment,
       employee_id       int not null,
       primary key (admin_id),
       foreign key (employee_id) references employees (employee_id)
       );

-- create the manager table
create table manager (
       manager_id        int auto_increment,
       employee_id       int not null,
       primary key (manager_id),
       foreign key (employee_id) references employees (employee_id)
       );

-- Create manger table
create table manages (
       manager_id        int not null,
       location_id       int not null,
       primary key (manager_id, location_id),
       foreign key (manager_id) references manager (manager_id),
       foreign key (location_id) references locations (location_id)
       );

-- Create the staff table
create table location_staffing (
       employee_id        int not null,
       location_id        int not null,
       primary key (employee_id, location_id),
       foreign key (employee_id) references employees (employee_id),
       foreign key (location_id) references locations (location_id)
       );

-- Create the customer table
create table customer (
       customer_id       int auto_increment,
       user_id           int not null,
       date_of_birth     date,
       join_date         date not null default CURRENT_DATE,
       user_type         enum('customer') not null default 'customer',
       primary key (customer_id),
       foreign key (user_id) references person (user_id),
       UNIQUE (user_id)
       );

-- create the category table
create table category (
       category_id    int auto_increment,
       category_description     varchar(255) not null,
       primary key (category_id)
       );

-- create the game genre table
create table genre (
       genre_id         int auto_increment,
       game_genre       varchar(255) not null unique,
       primary key (genre_id)
       );

-- create the product table
create table product (
       product_id        int auto_increment,
       upc_code          numeric(12) not null unique,
       product_name      varchar(255) not null,
       description       text,
       platform          varchar(50) not null,
       genre_id          int not null,
       release_date      date,
       product_type      varchar(50) not null,
       msrp              decimal(10, 2) not null,
       age_rating        int,
       is_digital        boolean not null default 0,
       photo_url         varchar(255),
       category_id       int not null,
       primary key (product_id),
       foreign key (genre_id) references genre (genre_id),
       foreign key (category_id) references category (category_id),
       INDEX idx_product_name (product_name),
       INDEX idx_product_upc (upc_code)
       );

-- create subscription table
create table subscription (
       subscription_id    int auto_increment,
       subscription_type  varchar(255) not null unique,
       price              decimal(10,2) not null,
       duration_days      int not null,
       primary key (subscription_id)
      );

-- create the membership-subscription table
create table membership (
       membership_id            int auto_increment,
       subscription_id          int not null,
       customer_id              int not null,
       start_date               date not null,
       end_date                 date not null,
       auto_renew               boolean not null default 1,
       rewards_points           int not null default 0,
       primary key (membership_id),
       foreign key (subscription_id) references subscription (subscription_id),
       foreign key (customer_id) references customer (customer_id),
       index idx_membership_customer (customer_id),
       index idx_membership_dates (start_date, end_date)
       );

-- create the digital_key table
--        unique_digital_key varchar(255),
--        primary key()
--          );

-- create the order table
create table orders (
       order_id         int auto_increment,
       customer_id      int not null,
       order_date       datetime not null DEFAULT CURRENT_TIMESTAMP,
       total_amount     decimal(10, 2) not null,
       status           ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL DEFAULT 'pending',
       payment_method      ENUM('credit', 'debit', 'paypal', 'gift_card', 'store_credit') NOT NULL,
       is_preorder         BOOLEAN NOT NULL DEFAULT 0,
       PRIMARY KEY (order_id),
       FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
       INDEX idx_order_customer (customer_id),
       INDEX idx_order_date (order_date)
       );

-- create the ordereditem table
create table ordered_item (
       order_id           INT NOT NULL,
       product_id         INT NOT NULL,
       quantity           INT NOT NULL DEFAULT 1,
       price_sold         DECIMAL(10, 2) NOT NULL,
       discount_applied   DECIMAL(10, 2) DEFAULT 0,
       PRIMARY KEY (order_id, product_id),
       FOREIGN KEY (order_id) REFERENCES orders (order_id),
       FOREIGN KEY (product_id) REFERENCES product (product_id)
       );

-- create the shipment table
create table shipment (
       shipment_id         INT AUTO_INCREMENT,
       order_id           INT NOT NULL,
       carrier            VARCHAR(50) NOT NULL,
       tracking_number    VARCHAR(50) NOT NULL,
       shipped_date       DATETIME,
       estimated_delivery DATETIME,
       actual_delivery    DATETIME,
       shipping_cost      DECIMAL(10, 2) NOT NULL,
       PRIMARY KEY (shipment_id),
       FOREIGN KEY (order_id) REFERENCES orders (order_id),
       INDEX idx_shipment_order (order_id),
       INDEX idx_shipment_tracking (tracking_number)
       );

-- create the product_inventory table
create table product_inventory (
       product_id         INT NOT NULL,
       location_id        INT NOT NULL,
       current_quantity   INT NOT NULL DEFAULT 0,
       total_sold         INT NOT NULL DEFAULT 0,
       last_restocked     DATETIME,
       PRIMARY KEY (product_id, location_id),
       FOREIGN KEY (product_id) REFERENCES product (product_id),
       FOREIGN KEY (location_id) REFERENCES locations (location_id)
       );

-- create the distributor table
create table distributor (
       distributor_id     INT AUTO_INCREMENT,
       name              VARCHAR(255) NOT NULL,
       contact_email     VARCHAR(255) NOT NULL,
       phone            VARCHAR(15) NOT NULL,
       contract_start    DATE NOT NULL,
       contract_end      DATE NOT NULL,
       PRIMARY KEY (distributor_id),
       INDEX idx_distributor_name (name)
       );

-- create the restocking table
create table restocking (
       reorder_id         INT AUTO_INCREMENT,
       product_id         INT NOT NULL,
       location_id        INT NOT NULL,
       distributor_id     INT NOT NULL,
       quantity           INT NOT NULL,
       order_date         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
       expected_delivery  DATE NOT NULL,
       status             ENUM('ordered', 'shipped', 'delivered', 'cancelled') NOT NULL DEFAULT 'ordered',
       unit_cost          DECIMAL(10, 2) NOT NULL,
       PRIMARY KEY (reorder_id),
       FOREIGN KEY (location_id) REFERENCES locations (location_id),
       FOREIGN KEY (product_id) REFERENCES product (product_id),
       FOREIGN KEY (distributor_id) REFERENCES distributor (distributor_id),
       INDEX idx_restocking_product (product_id),
       INDEX idx_restocking_status (status)
       );

-- create the budget table
create table budget (
       budget_id          INT AUTO_INCREMENT,
       category           VARCHAR(50) NOT NULL,
       amount_allocated   DECIMAL(10, 2) NOT NULL,
       amount_spent       DECIMAL(10, 2) NOT NULL DEFAULT 0,
       profit             DECIMAL(10, 2) NOT NULL DEFAULT 0,
       year               INT NOT NULL,
       quarter            INT NOT NULL CHECK (quarter BETWEEN 1 AND 4),
       location_id        INT NOT NULL,
       PRIMARY KEY (budget_id),
       FOREIGN KEY (location_id) REFERENCES locations (location_id),
       INDEX idx_budget_location (location_id, year, quarter)
       );

-- create the tournament table
create table tournament (
       tournament_id      INT AUTO_INCREMENT,
       location_id        INT NOT NULL,
       name              VARCHAR(255) NOT NULL,
       date_of_tournament DATETIME NOT NULL,
       tournament_type    VARCHAR(50) NOT NULL,
       entry_fee         DECIMAL(10, 2) DEFAULT 0,
       max_participants   INT,
       PRIMARY KEY (tournament_id),
       FOREIGN KEY (location_id) REFERENCES locations (location_id),
       INDEX idx_tournament_date (date_of_tournament)
       );

-- create the participant table
create table participant (
       participant_id     INT AUTO_INCREMENT,
       tournament_id     INT NOT NULL,
       customer_id       INT NOT NULL,
       registration_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
       final_ranking     INT,
       prizes_won        VARCHAR(255),
       PRIMARY KEY (participant_id),
       FOREIGN KEY (tournament_id) REFERENCES tournament (tournament_id),
       FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
       INDEX idx_participant_tournament (tournament_id)
       );

-- create the inventorymanagement table
create table inventory (
       inventory_id       INT AUTO_INCREMENT,
       location_id        INT NOT NULL,
       product_id         INT NOT NULL,
       quantity           INT NOT NULL DEFAULT 0,
       restock_threshold  INT NOT NULL DEFAULT 5,
       last_stocked_date  DATE,
       PRIMARY KEY (inventory_id),
       FOREIGN KEY (product_id) REFERENCES product (product_id),
       FOREIGN KEY (location_id) REFERENCES locations (location_id),
       INDEX idx_inventory_product (product_id)
       );

-- create the budgetproduct
create table product_budget (
       budget_id          INT NOT NULL,
       product_id         INT NOT NULL,
       amount_spent       DECIMAL(10, 2) NOT NULL,
       quantity_purchased INT NOT NULL,
       PRIMARY KEY (budget_id, product_id),
       FOREIGN KEY (budget_id) REFERENCES budget (budget_id),
       FOREIGN KEY (product_id) REFERENCES product (product_id)
       );
