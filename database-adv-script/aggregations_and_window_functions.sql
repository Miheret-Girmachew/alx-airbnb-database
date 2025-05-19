SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings_made
FROM
    "User" u
LEFT JOIN
    Booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY
    total_bookings_made DESC, u.last_name ASC;

WITH PropertyBookingCounts AS (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings_received
    FROM
        Property p
    LEFT JOIN
        Booking b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
)
SELECT
    pbc.property_id,
    pbc.property_name,
    pbc.total_bookings_received,
    RANK() OVER (ORDER BY pbc.total_bookings_received DESC) AS property_true_rank,
    ROW_NUMBER() OVER (ORDER BY pbc.total_bookings_received DESC, pbc.property_name ASC) AS property_row_sequence_number
FROM
    PropertyBookingCounts pbc
ORDER BY
    property_true_rank ASC, pbc.property_name ASC;