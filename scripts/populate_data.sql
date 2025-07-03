-- set mariadb to use database amm_games_db
use amm_games_db;

-- make sure that tables are empty
delete from person;
delete from user_type;
delete from product_budget;
delete from inventory;
delete from participant;
delete from tournament;
delete from budget;
delete from restocking;
delete from distributor;
delete from product_inventory;
delete from shipment;
delete from ordered_item;
delete from orders;
delete from membership;
delete from subscription;
delete from product;
delete from genre;
delete from category;
delete from customer;
delete from location_staff;
delete from manages;
delete from locations;
delete from manager;
delete from admin;
delete from employees;


-- Insert into person table
insert into person (email, username, password, first_name, last_name, phone_number, date_registered, is_active)
values ('admin1@example.com', 'admin1', 'adminpass1', 'John', 'Doe', '1234567890', NOW(), 1),
       ('admin2@example.com', 'admin2', 'adminpass2', 'Alice', 'Johnson', '2345678901', NOW(), 1),
       ('manager1@example.com', 'manager1', 'managerpass1', 'Jane', 'Smith', '3456789012', NOW(), 1),
       ('manager2@example.com', 'manager2', 'managerpass2', 'Robert', 'Brown', '4567890123', NOW(), 1),
       ('staff1@example.com', 'staff1', 'staffpass1', 'Mike', 'Williams', '5678901234', NOW(), 1),
       ('staff2@example.com', 'staff2', 'staffpass2', 'Emily', 'Davis', '6789012345', NOW(), 1),
       ('customer1@example.com', 'customer1', 'customerpass1', 'Sarah', 'Wilson', '7890123456', NOW(), 1),
       ('customer2@example.com', 'customer2', 'customerpass2', 'David', 'Taylor', '8901234567', NOW(), 1);


insert into user_type (user_type)
values ('customer'),
       ('clerk'),
       ('sysadmin'),
       ('manager');


-- Insert into employees
insert into employees (user_id)
values (1),
       (2),
       (3),
       (4),
       (5),
       (6);

-- Insert into admin
insert into admin (employee_id)
values (1),
       (2);

-- Insert into manager
insert into manager (employee_id, hire_date)
values (3, NOW()),
       (4, NOW());

-- Insert into locations
insert into locations (address, storage_capacity)
values ('221B Baker Street', 40000),
       ('123 Mockingbird Lane', 40000);

-- Insert into manages
insert into manages (manager_id, location_id)
values (1, 1),
       (2, 2);

-- Insert into location_staff
insert into location_staff (employee_id, location_id)
values (5, 1),
       (6, 2);

-- Insert into customer
insert into customer (user_id, date_of_birth)
values (7, '1990-05-15'),
       (8, '1985-11-22');

-- Insert into category
insert into category (category_description)
values ('Video Games'),
       ('Gaming Accessories');

-- Insert into genre
insert into genre (game_genre)
values ('Action-Adventure'),
       ('Role-Playing Game');

-- Insert into product
insert into product (upc_code, product_name, description, platform, genre_id, release_date, product_type, msrp, age_rating, is_digital, photo_url, category_id)
values ('2345678901', 'Epic Adventure Game', 'An amazing action-adventure game', 'PC', 1, '2023-01-15', 'Game', 59.99, 16, 0, 'http://example.com/game1.jpg', 1),
       ('8765432109', 'Fantasy RPG', 'Immersive role-playing experience', 'PlayStation 5', 2, '2023-03-20', 'Game', 69.99, 18, 0, 'http://example.com/game2.jpg', 1);

-- Insert into subscription
insert into subscription (subscription_type)
values ('Premium'),
       ('Basic');

-- Insert into membership
insert into membership (subscription_id, customer_id, start_date, end_date, auto_renew, rewards_points)
values (1, 1, '2023-01-01', '2024-01-01', 1, 1000),
       (2, 2, '2023-02-01', '2023-08-01', 0, 500);

-- Insert into orders
insert into orders (customer_id, order_date, total_amount, status, shipment_method, is_preorder)
values (1, NOW(), 59.99, 'Completed', 'Standard Shipping', 0),
       (2, NOW(), 129.98, 'Processing', 'Express Shipping', 1);

-- Insert into ordered_item
insert into ordered_item (order_id, product_id, quantity, price_sold)
values (1, 1, 1, 59.99),
       (2, 1, 1, 59.99),
       (2, 2, 1, 69.99);

-- Insert into shipment
insert into shipment (order_id, carrier, tracking_number, shipped_date, estimated_delivery, actual_delivery)
values (1, 'UPS', '1Z1234567890123456', NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), DATE_ADD(NOW(), INTERVAL 2 DAY)),
       (2, 'FedEx', '9876543210987654', NULL, NULL, NULL);

-- Insert into distributor
insert into distributor (name, contact_email, contract_details)
values ('Game Distributors Inc', 'sales@gamedistributors.com', 'Standard contract terms apply'),
       ('Digital Games Supply', 'orders@digitalgames.com', 'Exclusive digital distribution agreement');

-- Insert into product_inventory
insert into product_inventory (product_id, current_quantity, location_id, total_sold)
values (1, 50, 1, 10),
       (1, 30, 2, 5),
       (2, 25, 1, 8),
       (2, 40, 2, 12);

-- Insert into restocking
insert into restocking (product_id, location_id, distributor_id, quantity, order_date, expected_delivery)
values (1, 1, 1, 100, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
       (2, 2, 2, 50, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY));

-- Insert into budget
insert into budget (category, amount_allocated, amount_spent, profit, year, location_id)
values ('Inventory', 50000.00, 25000.00, 10000.00, 2023, 1),
       ('Marketing', 20000.00, 15000.00, 5000.00, 2023, 2);

-- Insert into tournament
insert into tournament (location_id, date_of_tournament, tournament_type)
values (1, DATE_ADD(NOW(), INTERVAL 7 DAY), 'Fighting Game Tournament'),
       (2, DATE_ADD(NOW(), INTERVAL 14 DAY), 'RPG Challenge');

-- Insert into participant
insert into participant (tournament_id, customer_id)
values (1, 1),
       (1, 2),
       (2, 1),
       (2, 2);

-- Insert into inventory
insert into inventory (location_id, product_id, quantity, restock_threshold, last_stocked_date)
values (1, 1, 50, 10, NOW()),
       (1, 2, 25, 5, NOW()),
       (2, 1, 30, 10, NOW()),
       (2, 2, 40, 8, NOW());

-- Insert into product_budget
insert into product_budget (budget_id, product_id, amount_spent)
values (1, 1, 2500.00),
       (2, 2, 1800.00);
