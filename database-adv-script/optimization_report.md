# ALX Airbnb Database: Query Optimization Report

## 1. Objective

This report details the process of writing an initial complex query to retrieve comprehensive booking information, analyzing its potential performance inefficiencies, and then refactoring it for better performance. The goal is to demonstrate techniques for optimizing SQL queries by reducing unnecessary operations, utilizing indexes effectively, and improving join strategies.

The initial and refactored SQL queries are provided in the `perfomance.sql` file.

## 2. Initial Complex Query (Conceptual)

**Objective:** Retrieve all bookings along with detailed information about the user who made the booking, the property that was booked, and any associated payment details.

**Tables Involved:** `Booking`, `User` (for guest details), `Property`, `User` (again, for host details, requiring careful aliasing), `Payment`.

**Initial Approach (Illustrative - see `perfomance.sql` for actual query):**
A straightforward approach might involve joining all these tables directly.

```sql
-- Conceptual representation of the initial query's structure
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    guest.user_id AS guest_id,
    guest.first_name AS guest_first_name,
    guest.email AS guest_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    host.user_id AS host_id,
    host.first_name AS host_first_name, -- Host details
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM
    Booking b
JOIN
    "User" guest ON b.user_id = guest.user_id
JOIN
    Property p ON b.property_id = p.property_id
JOIN
    "User" host ON p.host_id = host.user_id -- Join for host details
LEFT JOIN -- A booking might not have a payment yet (e.g., pending)
    Payment pay ON b.booking_id = pay.booking_id;