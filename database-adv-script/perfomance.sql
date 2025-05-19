SELECT
    'Initial Query' AS query_type,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    g_user.user_id AS guest_id,
    g_user.first_name AS guest_first_name,
    g_user.email AS guest_email,
    prop.property_id,
    prop.name AS property_name,
    prop.location AS property_location,
    prop.price_per_night AS property_price_per_night,
    h_user.user_id AS host_id,
    h_user.first_name AS host_first_name,
    h_user.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM
    Booking b
INNER JOIN
    "User" g_user ON b.user_id = g_user.user_id
INNER JOIN
    Property prop ON b.property_id = prop.property_id
INNER JOIN
    "User" h_user ON prop.host_id = h_user.user_id
LEFT JOIN
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY
    b.created_at DESC
LIMIT 100;

SELECT
    'Refactored Query' AS query_type,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_total_price,
    b.status AS booking_status,
    g_user.user_id AS guest_id,
    g_user.first_name AS guest_first_name,
    g_user.email AS guest_email,
    prop.property_id,
    prop.name AS property_name,
    prop.location AS property_location,
    prop.price_per_night AS property_price_per_night,
    h_user.user_id AS host_id,
    h_user.first_name AS host_first_name,
    h_user.email AS host_email,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM
    Booking b
INNER JOIN
    "User" g_user ON b.user_id = g_user.user_id
INNER JOIN
    Property prop ON b.property_id = prop.property_id
INNER JOIN
    "User" h_user ON prop.host_id = h_user.user_id
LEFT JOIN
    Payment pay ON b.booking_id = pay.booking_id
ORDER BY
    b.created_at DESC
LIMIT 100;