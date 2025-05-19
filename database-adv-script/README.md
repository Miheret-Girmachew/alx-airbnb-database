# ALX Airbnb Database: Complex Queries with Joins

## 1. Objective

This document accompanies the SQL script `joins_queries.sql`, which demonstrates the use of various SQL JOIN operations (INNER JOIN, LEFT JOIN, FULL OUTER JOIN) on the ALX Airbnb database schema. The purpose is to master SQL joins by writing complex queries to retrieve meaningful data from related tables.

## 2. About SQL Joins

SQL JOIN clauses are used to combine rows from two or more tables based on a related column between them. Understanding and correctly utilizing different types of joins is fundamental for effective relational database querying.

*   **INNER JOIN:** Returns records that have matching values in both tables.
*   **LEFT JOIN (or LEFT OUTER JOIN):** Returns all records from the left table, and the matched records from the right table. The result is NULL from the right side if there is no match.
*   **RIGHT JOIN (or RIGHT OUTER JOIN):** Returns all records from the right table, and the matched records from the left table. The result is NULL from the left side if there is no match. (Not explicitly required in this task, but good to know).
*   **FULL OUTER JOIN (or FULL JOIN):** Returns all records when there is a match in either left or right table. If there is no match, the result is NULL on the side that does not have a match.

## 3. Queries in `joins_queries.sql`

The `joins_queries.sql` file contains three distinct queries as per the task requirements:

### a. INNER JOIN: Bookings and Respective Users
*   **Objective:** Retrieve all bookings along with the first name, last name, and email of the user who made each booking.
*   **Tables Involved:** `Booking`, `User`
*   **Join Condition:** `Booking.user_id = User.user_id`

### b. LEFT JOIN: Properties and Their Reviews
*   **Objective:** Retrieve all properties and any reviews associated with them. This query ensures that properties with no reviews are also listed (with NULL values for review details).
*   **Tables Involved:** `Property`, `Review`
*   **Join Condition:** `Property.property_id = Review.property_id`

### c. FULL OUTER JOIN: Users and All Bookings
*   **Objective:** Retrieve a comprehensive list of all users and all bookings. This includes:
    *   Users who have made bookings (showing user and booking details).
    *   Users who have not made any bookings (showing user details and NULL for booking details).
    *   Bookings that might not be linked to a user (showing booking details and NULL for user details - though this scenario is unlikely with proper foreign key constraints, the FULL OUTER JOIN accounts for it).
*   **Tables Involved:** `User`, `Booking`
*   **Join Condition:** `User.user_id = Booking.user_id`

## 4. How to Use

1.  Ensure the ALX Airbnb database schema is created and populated with sample data (using scripts from `database-script-0x01/schema.sql` and `database-script-0x02/seed.sql`).
2.  Connect to your PostgreSQL instance and the ALX Airbnb database.
3.  Execute the queries in `joins_queries.sql` individually to observe their results.

Example using `psql`:
```bash
psql -U your_username -d your_alx_airbnb_database_name -f path/to/database-adv-script/joins_queries.sql