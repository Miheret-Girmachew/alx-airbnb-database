# Database Normalization Analysis for ALX Airbnb

## 1. Objective

The objective of this document is to analyze the provided database schema for the ALX Airbnb project and ensure it adheres to the principles of database normalization, specifically up to the Third Normal Form (3NF). We will review each entity and its attributes, identify any potential violations of normalization rules, and suggest adjustments if necessary.

## 2. Understanding Normal Forms

*   **First Normal Form (1NF):**
    *   Each table cell should contain a single, atomic value.
    *   Each record needs to be unique (typically ensured by a primary key).
    *   There are no repeating groups of columns.
*   **Second Normal Form (2NF):**
    *   The table must be in 1NF.
    *   All non-key attributes must be fully functionally dependent on the entire primary key. This means there should be no partial dependencies (where a non-key attribute depends on only part of a composite primary key).
*   **Third Normal Form (3NF):**
    *   The table must be in 2NF.
    *   There should be no transitive dependencies. A transitive dependency exists when a non-key attribute depends on another non-key attribute, rather than directly on the primary key. (i.e., if A -> B and B -> C, then A -> C is a transitive dependency, where A is the PK).

## 3. Schema Review and Normalization Steps

Let's review each table from the provided "Database Specification - AirBnB":

### User Table
*   **Attributes:** `user_id` (PK), `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`.
*   **1NF:**
    *   All attributes appear atomic (e.g., `first_name` is a single value, `email` is a single value). `role` is an ENUM, which is considered atomic.
    *   `user_id` is the primary key, ensuring record uniqueness.
    *   No repeating groups.
    *   **Conclusion: User table is in 1NF.**
*   **2NF:**
    *   The primary key `user_id` is a single column (not composite).
    *   Therefore, all non-key attributes (`first_name`, `last_name`, `email`, etc.) are fully functionally dependent on the entire primary key `user_id`. There cannot be any partial dependencies.
    *   **Conclusion: User table is in 2NF.**
*   **3NF:**
    *   We need to check for transitive dependencies (non-key attributes depending on other non-key attributes).
    *   `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at` all directly describe the user identified by `user_id`. None of these non-key attributes appear to be dependent on another non-key attribute. For example, `first_name` does not determine `role`.
    *   **Conclusion: User table is in 3NF.**

### Property Table
*   **Attributes:** `property_id` (PK), `host_id` (FK), `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`.
*   **1NF:**
    *   All attributes are atomic. `location` is a VARCHAR and treated as a single descriptive string.
    *   `property_id` is the primary key.
    *   No repeating groups.
    *   **Conclusion: Property table is in 1NF.**
*   **2NF:**
    *   The primary key `property_id` is a single column.
    *   All non-key attributes (including `host_id`, `name`, etc.) are fully functionally dependent on `property_id`.
    *   **Conclusion: Property table is in 2NF.**
*   **3NF:**
    *   `host_id`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at` all directly describe the property identified by `property_id`.
    *   There are no apparent transitive dependencies. For example, `location` doesn't depend on `name`; both depend on `property_id`.
    *   **Conclusion: Property table is in 3NF.**
    *   *Note:* If `location` were a complex attribute (e.g., street, city, postal_code, country), we might consider breaking it down. However, as a single `VARCHAR`, it's considered atomic.

### Booking Table
*   **Attributes:** `booking_id` (PK), `property_id` (FK), `user_id` (FK), `start_date`, `end_date`, `total_price`, `status`, `created_at`.
*   **1NF:**
    *   All attributes are atomic. `status` is an ENUM.
    *   `booking_id` is the primary key.
    *   No repeating groups.
    *   **Conclusion: Booking table is in 1NF.**
*   **2NF:**
    *   The primary key `booking_id` is a single column.
    *   All non-key attributes are fully functionally dependent on `booking_id`.
    *   **Conclusion: Booking table is in 2NF.**
*   **3NF:**
    *   `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at` all directly describe the booking identified by `booking_id`.
    *   **Consideration for `total_price`**: `total_price` could be calculated from `Property.pricepernight` and the duration (`end_date` - `start_date`). If so, storing it here would be a form of denormalization (to capture the price at the time of booking or for performance). However, for 3NF analysis, we assess if `total_price` depends on another *non-key attribute within the Booking table*. It depends on `start_date`, `end_date` (which are non-key attributes of Booking) and `Property.pricepernight` (from another table, linked via `property_id`).
    *   Assuming `total_price` is stored to reflect the agreed-upon price at the moment of booking (which might differ from current property prices or calculations), it's treated as an attribute of the booking event itself. There isn't a non-key attribute *within the Booking table* that determines `total_price` transitively through another non-key attribute of the Booking table. For example, `status` doesn't determine `total_price`.
    *   **Conclusion: Booking table is in 3NF.** (with the understanding that `total_price` is intentionally stored).

### Payment Table
*   **Attributes:** `payment_id` (PK), `booking_id` (FK), `amount`, `payment_date`, `payment_method`.
*   **1NF:**
    *   Attributes are atomic. `payment_method` is an ENUM.
    *   `payment_id` is the primary key.
    *   No repeating groups.
    *   **Conclusion: Payment table is in 1NF.**
*   **2NF:**
    *   The primary key `payment_id` is a single column.
    *   All non-key attributes are fully functionally dependent on `payment_id`.
    *   **Conclusion: Payment table is in 2NF.**
*   **3NF:**
    *   `booking_id`, `amount`, `payment_date`, `payment_method` all directly describe the payment identified by `payment_id`.
    *   No transitive dependencies are apparent. The `amount` paid is an attribute of this specific payment transaction, not determined by another non-key attribute in this table.
    *   **Conclusion: Payment table is in 3NF.**

### Review Table
*   **Attributes:** `review_id` (PK), `property_id` (FK), `user_id` (FK), `rating`, `comment`, `created_at`.
*   **1NF:** Atomic attributes, PK exists, no repeating groups. **Conclusion: 1NF.**
*   **2NF:** Single column PK, so all non-key attributes are fully dependent. **Conclusion: 2NF.**
*   **3NF:** `property_id`, `user_id`, `rating`, `comment`, `created_at` directly describe the review. No transitive dependencies. **Conclusion: 3NF.**

### Message Table
*   **Attributes:** `message_id` (PK), `sender_id` (FK), `recipient_id` (FK), `message_body`, `sent_at`.
*   **1NF:** Atomic attributes, PK exists, no repeating groups. **Conclusion: 1NF.**
*   **2NF:** Single column PK, so all non-key attributes are fully dependent. **Conclusion: 2NF.**
*   **3NF:** `sender_id`, `recipient_id`, `message_body`, `sent_at` directly describe the message. No transitive dependencies. **Conclusion: 3NF.**

## 4. Summary of Normalization Adjustments

Based on the review of the provided "Database Specification - AirBnB":

*   **The schema, as specified, already appears to be in 3NF.**
*   All tables satisfy 1NF criteria (atomic values, primary keys).
*   All tables satisfy 2NF criteria (no partial dependencies, as all primary keys are single-column UUIDs).
*   All tables satisfy 3NF criteria (no apparent transitive dependencies among non-key attributes).

The design effectively separates concerns into distinct entities:
*   Users are distinct from their properties.
*   Bookings link users and properties for a specific period and price.
*   Payments are related to bookings but are distinct events.
*   Reviews link users and properties for feedback.
*   Messages facilitate communication between users.

The use of UUIDs as primary keys and foreign keys to link related entities is a sound design choice. ENUM types for attributes like `role`, `status`, and `payment_method` are acceptable and maintain atomicity for those fields.

The attribute `Booking.total_price` is the most notable point. While it can be calculated, its explicit inclusion is a common and often acceptable denormalization strategy for:
1.  **Historical Accuracy:** Capturing the exact price agreed upon at the time of booking, which might change if property base prices or promotion rules evolve.
2.  **Performance:** Avoiding repeated calculations when retrieving booking information.
Given the project context, storing `total_price` is a practical choice and does not violate 3NF in the sense of a non-key attribute depending on another non-key attribute *within the same table* in a transitive manner that causes redundancy of *other data within that table*.

**No changes to the provided schema are deemed necessary to achieve 3NF based on this analysis.** The existing design is well-normalized.