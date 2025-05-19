CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email);

CREATE INDEX IF NOT EXISTS idx_user_role ON "User"(role);

CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);

CREATE INDEX IF NOT EXISTS idx_property_location ON Property(location);

CREATE INDEX IF NOT EXISTS idx_property_price_per_night ON Property(price_per_night);

CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);

CREATE INDEX IF NOT EXISTS idx_booking_start_date ON Booking(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_end_date ON Booking(end_date);

CREATE INDEX IF NOT EXISTS idx_booking_status ON Booking(status);

CREATE INDEX IF NOT EXISTS idx_review_property_id ON Review(property_id);

CREATE INDEX IF NOT EXISTS idx_review_user_id ON Review(user_id);

CREATE INDEX IF NOT EXISTS idx_message_sender_id ON Message(sender_id);

CREATE INDEX IF NOT EXISTS idx_message_recipient_id ON Message(recipient_id);

CREATE INDEX IF NOT EXISTS idx_message_sent_at ON Message(sent_at);