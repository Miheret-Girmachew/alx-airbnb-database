SELECT
    p.property_id,
    p.name AS property_name,
    p.location
FROM
    Property p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            Review r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

SELECT
    p.property_id,
    p.name AS property_name,
    p.location,
    prop_avg_ratings.average_rating
FROM
    Property p
INNER JOIN (
    SELECT
        r.property_id,
        AVG(r.rating) AS average_rating
    FROM
        Review r
    GROUP BY
        r.property_id
) AS prop_avg_ratings ON p.property_id = prop_avg_ratings.property_id
WHERE
    prop_avg_ratings.average_rating > 4.0
ORDER BY
    prop_avg_ratings.average_rating DESC, p.name ASC;

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    "User" u
WHERE
    (
        SELECT
            COUNT(b.booking_id)
        FROM
            Booking b
        WHERE
            b.user_id = u.user_id
    ) > 3
ORDER BY
    u.last_name ASC, u.first_name ASC;