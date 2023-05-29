-- Drop column "picture" from the "staff" table

ALTER TABLE staff
DROP COLUMN picture;
-- Add a new person named Tammy Sanders as a customer in the database

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (1, 'TAMMY', 'SANDERS', 'tammy@example.com', 1, 1, CURRENT_TIMESTAMP);
SELECT *
FROM customer;


-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.

-- Get customer_id for Charlotte Hunter
SELECT customer_id
FROM customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

-- Get inventory_id for the movie "Academy Dinosaur"
SELECT inventory_id
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Academy Dinosaur'
) AND store_id = 1
LIMIT 1;

-- Get staff_id for Mike Hillyer
SELECT staff_id
FROM staff
WHERE first_name = 'MIKE' AND last_name = 'HILLYER';

-- Insert the rental
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (CURRENT_TIMESTAMP, 1, 130, 1);

-- To verify the rental date
SELECT *
FROM rental;

-- Create a backup table called "deleted_users" and insert non-active users into it
DESCRIBE customer;

CREATE TABLE deleted_users (
    customer_id INT,
    email VARCHAR(255),
    deletion_date DATE
);
-- Insert non-active users into the backup table
INSERT INTO deleted_users (customer_id, email, deletion_date)
SELECT customer_id, email, CURRENT_DATE
FROM customer
WHERE active = 0;

SELECT *
FROM customer;

SELECT *
FROM deleted_users;

DELETE FROM customer
WHERE active = 0;