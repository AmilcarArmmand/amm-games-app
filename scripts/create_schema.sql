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
drop table if exists locations;
drop table if exists manager;
drop table if exists admin;
drop table if exists employees;
drop table if exists person;

-- create the user table
create table person (
       user_id           int auto_increment,
       email              varchar(255),
       username          varchar(255) not null,
       password      varchar(255) not null,
       first_name       varchar(50) not null,
       last_name        varchar(50) not null,
       phone_number     varchar(15),
       date_registered  datetime not null,
       is_active        boolean not null default 1,
       primary key (user_id)
       );

-- create the table employee
create table employees (
       user_id          int,
       employee_id      int auto_increment,
       primary key (employee_id),
       foreign key (user_id) references person (user_id)
       );

-- create the admin table
create table admin (
       admin_id          int auto_increment,
       employee_id       int,
       primary key (admin_id, employee_id),
       foreign key (employee_id) references employees (employee_id)
       );

-- create the manager table
create table manager (
       manager_id        int auto_increment,
       employee_id       int,
       user_id           int,
       salary            numeric(10, 2),
       primary key (manager_id),
       foreign key (employee_id) references employees (employee_id),
       foreign key (user_id) references person (user_id)
       );

create table locations (
       location_id         int auto_increment,
       phone_number        int(12),
       primary key (location_id)
       );

create table manages (
       manager_id       int auto_increment,
       location_id         int,
       primary key (manager_id, location_id),
       foreign key (manager_id) references manager (manager_id),
       foreign key (location_id) references locations (location_id)
       );

-- create the staff table
create table location_staff (
       employee_id        int,
       location_id        int,
       primary key (employee_id, location_id),
       foreign key (employee_id) references employees (employee_id),
       foreign key (location_id) references locations (location_id)
       );

-- create the customer table
create table customer (
       customer_id       int auto_increment,
       user_id           int,
       date_of_birth     date,
       primary key (customer_id),
       foreign key (user_id) references person (user_id)
       );

-- create the category table
create table category (
       category_id    int auto_increment,
       category_description     varchar(255),
       primary key (category_id)
       );

-- create the game genre table
create table genre (
       genre_id         int auto_increment,
       game_genre       varchar(255),
       primary key (genre_id)
       );

-- create the product table
create table product (
       product_id        int auto_increment,
       upc_code          int,
       product_name      varchar(255),
       description       varchar(255),
       platform          varchar(50),
       genre_id           int,
       release_date      date,
       product_type      varchar(255),
       msrp              decimal(10, 2),
       age_rating        int,
       is_digital        boolean,
       photo_url         varchar(255),
       category_id       int,
       primary key (product_id),
       foreign key (genre_id) references genre (genre_id),
       foreign key (category_id) references category (category_id)
       );

-- create subscription table
create table subscription (
       subscription_id    int auto_increment,
       subscription_type  varchar(255),
       primary key (subscription_id)
      );

-- create the membership-subscription table
create table membership (
       subscription_id   int,
       customer_id       int,
       start_date        date,
       end_date          date,
       auto_renew        boolean,
       rewards_points    int,
       primary key (subscription_id, customer_id),
       foreign key (subscription_id) references subscription (subscription_id),
       foreign key (customer_id) references customer (customer_id)
       );

-- create the digital_key table
--        unique_digital_key varchar(255),
--        primary key()
--          );

-- create the order table
create table orders (
       order_id         int auto_increment,
       customer_id      int,
       order_date       datetime,
       total_amount     decimal(10, 2),
       status           varchar(50),
       shipment_method  varchar(50),
       is_preorder      boolean,
       primary key (order_id),
       foreign key (customer_id) references customer (customer_id)
       );

-- create the ordereditem table
create table ordered_item (
       order_id          int,
       product_id        int,
       quantity          int,
       price_sold        decimal(10, 2),
       primary key (order_id, product_id),
       foreign key (order_id) references orders (order_id),
       foreign key (product_id) references product (product_id)
       );

-- create the shipment table
create table shipment (
       shipment_id      int auto_increment,
       order_id         int,
       carrier          varchar(50),
       tracking_number  varchar(50),
       shipped_date     datetime,
       estimated_delivery datetime,
       actual_delivery    datetime,
       primary key (shipment_id),
       foreign key (order_id) references orders (order_id)
       );

-- create the product_inventory table
create table product_inventory (
       product_id              int,
       current_quantity        int,
       location_id                int,
       total_sold              int,
       primary key (product_id, location_id),
       foreign key (product_id) references product (product_id),
       foreign key (location_id) references locations (location_id)
       );

-- create the distributor table
create table distributor (
       distributor_id int auto_increment primary key,
       name varchar(255),
       contact_email varchar(255),
       contract_details text
       );

-- create the restocking table
create table restocking (
       reorder_id               int auto_increment,
       product_id               int,
       location_id              int,
       distributor_id           int,
       quantity                 int,
       order_date               date,
       expected_delivery        date,
       primary key (reorder_id),
       foreign key (location_id) references locations (location_id),
       foreign key (product_id) references product (product_id),
       foreign key (distributor_id) references distributor (distributor_id)
       );

-- create the budget table
create table budget (
       budget_id        int auto_increment,
       category         varchar(50),
       amount_allocated decimal(10, 2),
       amount_spent     decimal(10, 2),
       profit           decimal(10, 2),
       year             int,
       location_id      int,
       primary key (budget_id),
       foreign key (location_id) references locations (location_id)
       );

-- create the tournament table
create table tournament (
       tournament_id    int auto_increment,
       location_id      int,
       date_of_tournament date,
       tournament_type    varchar(50),
       primary key (tournament_id),
       foreign key (location_id) references locations (location_id)
       );

-- create the participant table
create table participant (
       participant_id    int auto_increment,
       tournament_id     int,
       customer_id       int,
       primary key (participant_id),
       foreign key (tournament_id) references tournament (tournament_id),
       foreign key (customer_id) references customer (customer_id)
       );

-- create the inventorymanagement table
create table inventory (
       inventory_id    int auto_increment,
       location_id     int,
       product_id      int,
       quantity        int,
       restock_threshold int,
       last_stocked_date date,
       primary key (inventory_id),
       foreign key (product_id) references product (product_id),
       foreign key (location_id) references locations (location_id)
       );

-- create the budgetproduct junction table
create table product_budget (
       budget_id int,
       product_id int,
       amount_spent decimal(10, 2),
       primary key (budget_id, product_id),
       foreign key (budget_id) references budget (budget_id),
       foreign key (product_id) references product (product_id)
       );
