-- set mariadb to use database amm_games_db
use amm_games_db;

-- make sure that tables are empty
DELETE FROM product_budget;
DELETE FROM inventory;
DELETE FROM participant;
DELETE FROM tournament;
DELETE FROM budget;
DELETE FROM restocking;
DELETE FROM product_inventory;
DELETE FROM shipment;
DELETE FROM ordered_item;
DELETE FROM orders;
DELETE FROM membership;
DELETE FROM subscription;
DELETE FROM product;
DELETE FROM genre;
DELETE FROM category;
DELETE FROM customer;
DELETE FROM location_staffing;
DELETE FROM manages;
DELETE FROM manager;
DELETE FROM admin;
DELETE FROM employees;
DELETE FROM locations;
DELETE FROM person;


--delete from user_type;
--delete from product_budget;
--delete from distributor;

-- Insert into person table
INSERT INTO person (email, username, password, first_name, last_name, phone_number, date_registered, last_login, is_active)
VALUES
('admin1@example.com', 'admin1', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'John', 'Doe', '1234567890', NOW(), NOW(), 1),
('admin2@example.com', 'admin2', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'Alice', 'Johnson', '2345678901', NOW(), NOW(), 1),
('manager1@example.com', 'manager1', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'Jane', 'Smith', '3456789012', NOW(), NOW(), 1),
('manager2@example.com', 'manager2', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'Robert', 'Brown', '4567890123', NOW(), NOW(), 1),
('staff1@example.com', 'staff1', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'Mike', 'Williams', '5678901234', NOW(), NOW(), 1),
('staff2@example.com', 'staff2', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'Emily', 'Davis', '6789012345', NOW(), NOW(), 1),
('customer1@example.com', 'customer1', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'Sarah', 'Wilson', '7890123456', NOW(), NOW(), 1),
('customer2@example.com', 'customer2', '$2y$10$NlqkTcZx7XZ2XZ2XZ2XZ2eXZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2XZ2', 'David', 'Taylor', '8901234567', NOW(), NOW(), 1);


-- Insert into locations
insert into locations (address, storage_capacity)
values
('221B Baker Street, London', 50000),
('123 Mockingbird Lane, Springfield', 45000),
('742 Evergreen Terrace, Springfield', 60000);


-- Insert into employees
INSERT INTO employees (user_id, user_type, salary, hire_date)
VALUES
(1, 'sysadmin', 85000.00, '2020-01-15'),
(2, 'sysadmin', 82000.00, '2020-03-20'),
(3, 'manager', 75000.00, '2021-05-10'),
(4, 'manager', 72000.00, '2021-06-15'),
(5, 'clerk', 45000.00, '2022-02-01'),
(6, 'clerk', 42000.00, '2022-03-15');


-- Insert into admin
INSERT INTO admin (employee_id)
VALUES (1), (2);

-- Insert into manager
INSERT INTO manager (employee_id)
VALUES
(3),
(4);


-- Insert into manages
INSERT INTO manages (manager_id, location_id)
VALUES
(1, 1),
(2, 2);


-- Insert into location_staff
INSERT INTO location_staffing (employee_id, location_id)
VALUES
(5, 1),
(5, 3),
(6, 2),
(6, 3);

-- Insert into customer
INSERT INTO customer (user_id, date_of_birth, join_date)
VALUES
(7, '1990-05-15', '2022-01-10'),
(8, '1985-11-22', '2022-02-15');


-- Insert into category
INSERT INTO category (category_description)
VALUES
('Video Games'),
('Gaming Accessories'),
('Consoles'),
('Merchandise');


-- Insert into genre
INSERT INTO genre (game_genre)
VALUES
('Action-Adventure'),
('Role-Playing Game'),
('First-Person Shooter'),
('Sports'),
('Strategy');


-- Insert into product
INSERT INTO product (upc_code, product_name, description, platform, genre_id, release_date, product_type, msrp, age_rating, is_digital, photo_url, category_id)
VALUES
('123456789012', 'Epic Adventure Game', 'An amazing action-adventure game with stunning visuals', 'PC', 1, '2023-01-15', 'Game', 59.99, 16, 0, 'https://example.com/game1.jpg', 1),
('987654321098', 'Fantasy RPG', 'Immersive role-playing experience with deep story', 'PlayStation 5', 2, '2023-03-20', 'Game', 69.99, 18, 0, 'https://example.com/game2.jpg', 1),
('567890123456', 'Pro Controller', 'High-performance wireless controller', 'Nintendo Switch', 1, '2022-10-15', 'Accessory', 69.99, 8, 0, 'https://example.com/controller.jpg', 2),
('345678901234', 'Next-Gen Console', 'Latest gaming console with 4K resolution', 'Xbox Series X', 1, '2022-11-10', 'Console', 499.99, 8, 0, 'https://example.com/console.jpg', 3);


-- Insert into subscription
INSERT INTO subscription (subscription_type, price, duration_days)
VALUES
('Premium', 9.99, 30),
('Gold', 14.99, 30),
('Basic', 4.99, 30),
('Annual', 99.99, 365);


-- Insert into membership
INSERT INTO membership (subscription_id, customer_id, start_date, end_date, auto_renew, rewards_points)
VALUES
(1, 1, '2023-01-01', '2023-02-01', 1, 1000),
(4, 2, '2023-01-15', '2024-01-15', 1, 1500);


-- Insert into orders
INSERT INTO orders (customer_id, order_date, total_amount, status, payment_method, is_preorder)
VALUES
(1, '2023-01-05 10:30:00', 129.98, 'delivered', 'credit', 0),
(2, '2023-01-20 14:45:00', 69.99, 'processing', 'paypal', 0),
(1, '2023-02-01 09:15:00', 499.99, 'shipped', 'debit', 1);


-- Insert into ordered_item
INSERT INTO ordered_item (order_id, product_id, quantity, price_sold, discount_applied)
VALUES
(1, 1, 1, 59.99, 0),
(1, 2, 1, 69.99, 0),
(2, 3, 1, 59.99, 10.00),
(3, 4, 1, 449.99, 50.00);


-- Insert into shipment
INSERT INTO shipment (order_id, carrier, tracking_number, shipped_date, estimated_delivery, actual_delivery, shipping_cost)
VALUES
(1, 'UPS', '1Z1234567890123456', '2023-01-05 16:00:00', '2023-01-08 23:59:59', '2023-01-07 14:30:00', 5.99),
(3, 'FedEx', '9876543210987654', '2023-02-01 12:00:00', '2023-02-03 23:59:59', NULL, 8.99);


-- Insert into distributor
INSERT INTO distributor (name, contact_email, phone, contract_start, contract_end)
VALUES
('Game Distributors Inc', 'sales@gamedistributors.com', '8005551001', '2022-01-01', '2024-12-31'),
('Digital Games Supply', 'orders@digitalgames.com', '8005551002', '2022-03-15', '2023-12-31'),
('Console World', 'support@consoleworld.com', '8005551003', '2021-11-01', '2023-11-01');


-- Insert into product_inventory
INSERT INTO product_inventory (product_id, location_id, current_quantity, total_sold, last_restocked)
VALUES
(1, 1, 50, 25, '2025-01-10'),
(1, 2, 30, 15, '2025-01-12'),
(2, 1, 40, 20, '2025-01-15'),
(2, 2, 35, 18, '2025-01-18'),
(3, 1, 20, 10, '2025-01-05'),
(3, 2, 25, 12, '2025-01-08'),
(4, 1, 15, 8, '2025-01-20'),
(4, 2, 10, 5, '2025-01-22');


-- Insert into restocking with status
INSERT INTO restocking (product_id, location_id, distributor_id, quantity, order_date, expected_delivery, status, unit_cost)
VALUES
(1, 1, 1, 100, '2023-01-25', '2023-01-30', 'ordered', 25.00),
(2, 2, 2, 50, '2023-01-26', '2023-02-02', 'ordered', 30.00),
(4, 1, 3, 20, '2023-01-27', '2023-02-05', 'ordered', 350.00);



-- Insert into budget with quarterly data
INSERT INTO budget (category, amount_allocated, amount_spent, profit, year, quarter, location_id)
VALUES
('Inventory', 50000.00, 32500.00, 12000.00, 2023, 1, 1),
('Marketing', 20000.00, 15000.00, 5000.00, 2023, 1, 1),
('Inventory', 45000.00, 28000.00, 10000.00, 2023, 1, 2),
('Staff', 30000.00, 28000.00, 0.00, 2023, 1, 2);



-- Insert into tournament with complete details
INSERT INTO tournament (location_id, name, date_of_tournament, tournament_type, entry_fee, max_participants)
VALUES
(1, 'Winter Gaming Championship', '2023-02-15 10:00:00', 'Fighting Game Tournament', 20.00, 32),
(2, 'Spring RPG Challenge', '2023-03-20 11:00:00', 'RPG Challenge', 15.00, 24),
(1, 'Summer Esports Open', '2023-06-10 09:00:00', 'Multi-Game Tournament', 25.00, 50);



-- Insert into participant
INSERT INTO participant (tournament_id, customer_id, registration_date)
VALUES
(1, 1, '2023-01-20'),
(1, 2, '2023-01-22'),
(2, 1, '2023-02-10'),
(2, 2, '2023-02-12'),
(3, 1, '2023-04-15');



-- Insert into inventory
INSERT INTO inventory (location_id, product_id, quantity, restock_threshold, last_stocked_date)
VALUES
(1, 1, 50, 10, '2023-01-10'),
(1, 2, 40, 10, '2023-01-15'),
(1, 3, 20, 5, '2023-01-05'),
(1, 4, 15, 3, '2023-01-20'),
(2, 1, 30, 10, '2023-01-12'),
(2, 2, 35, 10, '2023-01-18'),
(2, 3, 25, 5, '2023-01-08'),
(2, 4, 10, 3, '2023-01-22');



-- Insert into product_budget with quantity purchased
INSERT INTO product_budget (budget_id, product_id, amount_spent, quantity_purchased)
VALUES
(1, 1, 12500.00, 500),
(1, 2, 15000.00, 400),
(1, 3, 5000.00, 100),
(3, 1, 11200.00, 400),
(3, 2, 12000.00, 300),
(3, 4, 4800.00, 12);
