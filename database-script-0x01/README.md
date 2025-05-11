# Database Schema for ALX Airbnb Project (DDL)

## Objective

This directory contains the SQL Data Definition Language (DDL) script (`schema.sql`) used to create the database schema for the ALX Airbnb project. The schema is designed based on the provided "Database Specification - AirBnB" document and follows normalization principles (up to 3NF).

## Files

*   **`schema.sql`**: Contains all the `CREATE TABLE` statements, along with definitions for primary keys, foreign keys, constraints (NOT NULL, UNIQUE, CHECK, ENUMs), and indexes.

## Schema Overview

The database consists of the following tables:

1.  **User**: Stores information about users (guests, hosts, admins).
2.  **Property**: Stores details about properties listed on the platform.
3.  **Booking**: Manages bookings made by users for properties.
4.  **Payment**: Records payment transactions associated with bookings.
5.  **Review**: Stores user reviews and ratings for properties.
6.  **Message**: Facilitates communication between users.

## Key Design Features

*   **UUIDs for Primary Keys**: All primary keys are UUIDs to ensure global uniqueness, which is beneficial for distributed systems or merging datasets.
*   **Foreign Key Constraints**: Enforce referential integrity between related tables.
*   **Data Types**: Appropriate data types are used for each attribute (e.g., VARCHAR, TEXT, DECIMAL, TIMESTAMP, DATE, ENUM).
*   **Constraints**:
    *   `NOT NULL` constraints for mandatory fields.
    *   `UNIQUE` constraint for `User.email`.
    *   `CHECK` constraint for `Review.rating`.
    *   `ENUM` types for predefined sets of values (e.g., `User.role`, `Booking.status`, `Payment.payment_method`).
*   **Indexing**:
    *   Primary keys are automatically indexed.
    *   Additional indexes are created on frequently queried foreign keys and other critical columns (e.g., `User.email`) to optimize query performance.
*   **Timestamps**: `created_at` and `updated_at` (where applicable) fields to track record creation and modification times.

## How to Use

1.  Ensure you have a PostgreSQL server running.
2.  Connect to your PostgreSQL instance using a client like `psql` or a GUI tool.
3.  Create a new database (e.g., `alx_airbnb_db`).
4.  Execute the `schema.sql` script against the newly created database.

