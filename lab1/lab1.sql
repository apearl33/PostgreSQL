-- LAB1A
-- 1. Create a new table named users.

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- 2. Create a new table named status.

CREATE TABLE status (
    id SERIAL PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- 3. Create a new table named inventory.

CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    status_id SERIAL REFERENCES status,
    description VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- 4. Create a new table named transactions.

CREATE TABLE transactions(
    id SERIAL PRIMARY KEY,
    user_id SERIAL REFERENCES users,
    inventory_id SERIAL REFERENCES inventory,
    checkout_time TIMESTAMP NOT NULL,
    scheduled_checkin_time TIMESTAMP,
    actual_checkin_time TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- 5. Insert 5 users into the users table. The fields are self-explanatory.

INSERT INTO users (first_name, last_name, email, password, created_at, updated_at)
VALUES ('Eunsik', 'Na', 'eunsik2@uis.edu', 'p@ssw0rd', current_timestamp, current_timestamp),
('Tulio', 'Llosa', 'tllos1@uis.edu', 'p@ssw0rd', current_timestamp, current_timestamp),
('Sunshin', 'Lee', 'slee675@uis.edu', 'p@ssw0rd', current_timestamp, current_timestamp),
('Liang', 'Kong', 'lkong9@uis.edu', 'p@ssw0rd', current_timestamp, current_timestamp),
('Yanhui', 'Guo', 'yguo56@uis.edu', 'p@ssw0rd', current_timestamp, current_timestamp);

-- 6. Insert 5 records into the status table.
-- The description field should be: Available, Checked out, Overdue, Unavailable, Under Repair.
-- The other fields are self-explanatory.

INSERT INTO status(description, created_at, updated_at)
VALUES ('Available', current_timestamp, current_timestamp),
('Checked out', current_timestamp, current_timestamp),
('Overdue', current_timestamp, current_timestamp),
('Unavailable', current_timestamp, current_timestamp),
('Under Repair', current_timestamp, current_timestamp);

-- 7. Insert 5 records into the inventory table.
-- The description field should be: Laptop1, Laptop2, Webcam1, TV1, Microphone1.
-- The other fields are self-explanatory.

INSERT INTO inventory(description, created_at, updated_at)
VALUES ('Laptop1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Laptop2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Webcam1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TV1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Microphone1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 8. Insert 3 records into the transactions table.
-- The fields are self-explanatory, keeping in mind the foreign key constraints.
-- Two of the transactions should be for the user in the users table with id = 1.
-- Two of the transactions should have a scheduled_checkin_time after May 31 2022.

INSERT INTO transactions
(user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at)
VALUES (1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Then update the status of these three inventory items in the inventory table to Checked out.
UPDATE inventory
SET status_id = 2
WHERE id IN (1, 2);

-- 9. Alter the users table to add a column for signed_agreement (Boolean column that defaults to false).

ALTER TABLE users
ADD COLUMN signed_agreement BOOLEAN DEFAULT FALSE;

-- 10. Write a query that returns a list of all the equipment and its scheduled_checkin_time that is checked out ordered by scheduled_checkin_time in descending order.

SELECT i.description, t.scheduled_checkin_time
FROM inventory i INNER JOIN transactions t on i.id = t.inventory_id
WHERE i.status_id = 2;

-- 11. Write a query that returns a list of all equipment due after May 31 2022.

SELECT i.description, t.scheduled_checkin_time
FROM inventory i JOIN transactions t on i.id = t.inventory_id
WHERE t.scheduled_checkin_time >= '05/31/2022';

-- 12. Write a query that returns a count of the number of items with a status of Checked out by user_id 1.

SELECT COUNT(*)
FROM transactions t JOIN inventory i on t.inventory_id = i.id
WHERE i.status_id = 2 AND t.user_id = 1;

-- LAB1B
-- 1a. Using the tables created in Lab 1 Part 1, insert 20 transactions.
-- Three of these transactions need to have the actual_checkin_time after the scheduled_checkin_time. This will allow you to test the view you will be creaing in the next steps.
-- For example, a transaction where the scheduled_checkin_time is 2018-08-01 14:39:53 and the actual_checkin_time is 2018-08-02 14:39:53.
-- Additionally, five of the transactions need to have a checkout_time after September 3 2018.

INSERT INTO transactions
(user_id, inventory_id, checkout_time, scheduled_checkin_time, actual_checkin_time, created_at, updated_at)
VALUES (1, 1, '2018-08-03 14:39:53', '2018-08-01 14:39:53', '2018-08-02 14:39:53', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 1, '2018-08-04 14:39:53', '2018-08-02 14:39:53', '2018-08-03 14:39:53', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 2, '2018-08-05 14:39:53', '2018-08-03 14:39:53', '2018-08-04 14:39:53', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 1, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 3, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 2, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 1, '2019-08-05 12:00:00', '2019-08-03 12:00:00', '2019-08-04 12:01:00', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 1b. Create a late checkins view of distinct items that were checked in late grouped by user_id, inventory_id, and description.
-- This view should display the total number of late checkins per device per user.
-- For example, if user1 checked in two items late, there should be two rows displayed for user1 and each row should include the total number of times that user returned that particular item late.

CREATE OR REPLACE VIEW checkins AS
SELECT user_id, inventory_id, COUNT(inventory_id)
FROM transactions
WHERE actual_checkin_time > scheduled_checkin_time
GROUP BY user_id, inventory_id;

-- 1c. Test the late checkins view by selecting and displaying all records from the view.

SELECT * FROM checkins;