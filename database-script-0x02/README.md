# Database Seeding Script for ALX Airbnb Project

## Objective

This directory contains the SQL script (`seed.sql`) used to populate the ALX Airbnb database with sample data. This data is intended to simulate real-world usage, allowing for testing of queries, application functionality, and database performance.

## Files

*   **`seed.sql`**: Contains `INSERT` statements to add sample records to all tables defined in the `schema.sql` (User, Property, Booking, Payment, Review, Message).

## Sample Data Overview

The `seed.sql` script populates the database with:

*   Multiple **Users**, including guests, hosts, and an admin.
*   Several **Properties** listed by host users, with varying details.
*   A number of **Bookings** made by guest users for different properties, showcasing various statuses (pending, confirmed, canceled).
*   **Payments** associated with confirmed bookings.
*   **Reviews** submitted by users for properties they have stayed at.
*   **Messages** exchanged between users.

## Key Considerations for Seed Data

*   **Realistic Scenarios**: The data attempts to reflect plausible interactions within an Airbnb-like platform.
*   **UUIDs for Primary Keys**: Specific UUIDs are used for primary keys to ensure consistency and allow for explicit linking between records via foreign keys within this script. In a production seeding or application environment, these would typically be generated dynamically.
*   **Foreign Key Integrity**: The insertion order and UUIDs are managed to respect foreign key constraints.
*   **Data Variety**: Different values are used for names, descriptions, dates, and statuses to provide a diverse dataset.
*   **Password Hashing**: Placeholder strings are used for `password_hash` for simplicity in this seed script. In a real application, these would be securely hashed passwords.

## How to Use

1.  Ensure the database schema has been created using `database-script-0x01/schema.sql`.
2.  Connect to your PostgreSQL instance and the ALX Airbnb database.
3.  Execute the `seed.sql` script.
