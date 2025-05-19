SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email AS user_email
FROM
    Booking b
INNER JOIN
    "User" u ON b.user_id = u.user_id;

SELECT
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    r.review_id,
    r.rating AS review_rating,
    r.comment AS review_comment,
    u.first_name AS reviewer_first_name,
    u.last_name AS reviewer_last_name
FROM
    Property p
LEFT JOIN
    Review r ON p.property_id = r.property_id
LEFT JOIN
    "User" u ON r.user_id = u.user_id
ORDER BY
    p.property_id ASC, r.review_id ASC;

SELECT
    u.user_id,
    u.email AS user_email,
    u.first_name AS user_first_name,
    b.booking_id,
    b.property_id AS booked_property_id,
    b.start_date AS booking_start_date,
    b.status AS booking_status
FROM
    "User" u
FULL OUTER JOIN
    Booking b ON u.user_id = b.user_id;