# ALX Airbnb Database Schema

### 2. `database-script-0x01/schema.sql`

```sql
-- ALX Airbnb Database Schema
-- PostgreSQL Flavor

-- Ensure UUID extension is available
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Define ENUM types first
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');

-- Table: User
CREATE TABLE IF NOT EXISTS "User" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    role user_role NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Table: Property
CREATE TABLE IF NOT EXISTS Property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    -- Consider a trigger for updated_at if automatic update on row change is needed
    -- For now, relying on application logic or manual update for updated_at
);

-- Table: Booking
CREATE TABLE IF NOT EXISTS Booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dates CHECK (end_date >= start_date) -- Ensure end_date is not before start_date
);

-- Table: Payment
CREATE TABLE IF NOT EXISTS Payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES Booking(booking_id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_enum NOT NULL
);

-- Table: Review
CREATE TABLE IF NOT EXISTS Review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_rating CHECK (rating >= 1 AND rating <= 5)
);

-- Table: Message
CREATE TABLE IF NOT EXISTS Message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    recipient_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_sender_recipient CHECK (sender_id <> recipient_id) -- User cannot send message to themselves
);

-- Indexes for performance optimization
-- Primary Keys are automatically indexed.

-- User Table
CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email);

-- Property Table
CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);
-- property_id is PK, so already indexed.

-- Booking Table
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
-- booking_id is PK, so already indexed.

-- Payment Table
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);

-- Review Table
CREATE INDEX IF NOT EXISTS idx_review_property_id ON Review(property_id);
CREATE INDEX IF NOT EXISTS idx_review_user_id ON Review(user_id);

-- Message Table
CREATE INDEX IF NOT EXISTS idx_message_sender_id ON Message(sender_id);
CREATE INDEX IF NOT EXISTS idx_message_recipient_id ON Message(recipient_id);

-- Note on Property.updated_at:
-- PostgreSQL does not have a direct ON UPDATE CURRENT_TIMESTAMP like MySQL for a column.
-- This typically requires a trigger. For simplicity in this DDL,
-- it's assumed the application layer will handle updating this field or a trigger
-- would be added separately if strict DB-level enforcement is needed.
-- Example trigger function for updated_at:
/*
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_property_updated_at
BEFORE UPDATE ON Property
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();
*/
