# ERD Requirements for ALX Airbnb Database

## 1. Objective

The primary objective is to create a comprehensive Entity-Relationship Diagram (ERD) that visually represents the structure of the ALX Airbnb database. This ERD will serve as a blueprint for the database schema, clearly defining all entities, their attributes, and the relationships between them.

## 2. Scope

The ERD must include all entities, attributes, and relationships as specified in the "Database Specification - AirBnB" document.

## 3. Tools

*   **Primary Tool:** [dbDiagram.io](https://dbdiagram.io/) is recommended for creating the ERD.
*   **Alternatives:** Other ERD modeling tools like Draw.io (app.diagrams.net), Lucidchart, or any similar software capable of producing clear ERDs are acceptable.

## 4. Entities and Attributes

The ERD must accurately depict the following entities along with their specified attributes (including data types, primary keys, foreign keys, and constraints where visually representable or noted):

### a. User
    *   `user_id`: Primary Key, UUID
    *   `first_name`: VARCHAR, NOT NULL
    *   `last_name`: VARCHAR, NOT NULL
    *   `email`: VARCHAR, UNIQUE, NOT NULL
    *   `password_hash`: VARCHAR, NOT NULL
    *   `phone_number`: VARCHAR, NULL
    *   `role`: ENUM (guest, host, admin), NOT NULL
    *   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### b. Property
    *   `property_id`: Primary Key, UUID
    *   `host_id`: Foreign Key (references User.user_id)
    *   `name`: VARCHAR, NOT NULL
    *   `description`: TEXT, NOT NULL
    *   `location`: VARCHAR, NOT NULL
    *   `pricepernight`: DECIMAL, NOT NULL
    *   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    *   `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### c. Booking
    *   `booking_id`: Primary Key, UUID
    *   `property_id`: Foreign Key (references Property.property_id)
    *   `user_id`: Foreign Key (references User.user_id)
    *   `start_date`: DATE, NOT NULL
    *   `end_date`: DATE, NOT NULL
    *   `total_price`: DECIMAL, NOT NULL
    *   `status`: ENUM (pending, confirmed, canceled), NOT NULL
    *   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### d. Payment
    *   `payment_id`: Primary Key, UUID
    *   `booking_id`: Foreign Key (references Booking.booking_id)
    *   `amount`: DECIMAL, NOT NULL
    *   `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
    *   `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL

### e. Review
    *   `review_id`: Primary Key, UUID
    *   `property_id`: Foreign Key (references Property.property_id)
    *   `user_id`: Foreign Key (references User.user_id)
    *   `rating`: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
    *   `comment`: TEXT, NOT NULL
    *   `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### f. Message
    *   `message_id`: Primary Key, UUID
    *   `sender_id`: Foreign Key (references User.user_id)
    *   `recipient_id`: Foreign Key (references User.user_id)
    *   `message_body`: TEXT, NOT NULL
    *   `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## 5. Relationships and Cardinality

The ERD must clearly illustrate the relationships between entities, including their cardinality:

*   **User - Property:**
    *   A User (host) can have multiple Properties.
    *   A Property belongs to one User (host).
    *   Cardinality: One-to-Many (User to Property)
*   **User - Booking:**
    *   A User (guest) can make multiple Bookings.
    *   A Booking is made by one User.
    *   Cardinality: One-to-Many (User to Booking)
*   **Property - Booking:**
    *   A Property can have multiple Bookings.
    *   A Booking is for one Property.
    *   Cardinality: One-to-Many (Property to Booking)
*   **Booking - Payment:**
    *   A Booking can have one Payment.
    *   A Payment is associated with one Booking.
    *   Cardinality: One-to-One (Booking to Payment, as per current specification where `Payment.booking_id` is a direct FK and `payment_id` is PK)
*   **User - Review:**
    *   A User can write multiple Reviews.
    *   A Review is written by one User.
    *   Cardinality: One-to-Many (User to Review)
*   **Property - Review:**
    *   A Property can have multiple Reviews.
    *   A Review is for one Property.
    *   Cardinality: One-to-Many (Property to Review)
*   **User - Message (Sender/Recipient):**
    *   A Message is sent by one User (sender_id).
    *   A Message is received by one User (recipient_id).
    *   A User can send multiple Messages.
    *   A User can receive multiple Messages.
    *   Cardinality: Two One-to-Many relationships from User to Message (one for sender, one for recipient).

## 6. Key Conventions

*   Clearly distinguish Primary Keys (PKs).
*   Clearly indicate Foreign Keys (FKs) and the relationships they establish.
*   Use standard ERD notation for entities, attributes, and relationships (e.g., Crow's Foot notation for cardinality).

## 7. Deliverable

*   The final ERD should be saved as an image file (e.g., PNG, JPG, SVG) or a direct link to the live diagram on dbDiagram.io.
*   The ERD file/link should be placed in the `ERD/` directory of the `alx-airbnb-database` repository.
*   The diagram should be clean, readable, and accurately reflect all specifications.

## 8. Indexing Considerations (for notation if possible)

While not always visually represented in detail on all ERD styles, be mindful of the specified indexes:
*   Primary Keys are inherently indexed.
*   `User.email`
*   `Property.property_id` (already PK, but mentioned for its FK use)
*   `Booking.property_id`
*   `Booking.booking_id` (already PK)
*   `Payment.booking_id`

If the chosen tool allows, indicate indexed fields. Otherwise, this serves as a reminder for the schema definition phase.