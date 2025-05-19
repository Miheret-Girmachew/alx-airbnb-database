CREATE TABLE IF NOT EXISTS Booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_booking_dates CHECK (end_date >= start_date)
) PARTITION BY RANGE (start_date);

CREATE TABLE IF NOT EXISTS booking_y2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE IF NOT EXISTS booking_y2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE IF NOT EXISTS booking_y2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

ALTER TABLE booking_y2024 ADD CONSTRAINT pk_booking_y2024 PRIMARY KEY (booking_id);
ALTER TABLE booking_y2024 ADD CONSTRAINT fk_booking_y2024_property
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE;
ALTER TABLE booking_y2024 ADD CONSTRAINT fk_booking_y2024_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_booking_y2024_user_id ON booking_y2024(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_y2024_property_id ON booking_y2024(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_y2024_status ON booking_y2024(status);
CREATE INDEX IF NOT EXISTS idx_booking_y2024_end_date ON booking_y2024(end_date);

ALTER TABLE booking_y2023 ADD CONSTRAINT pk_booking_y2023 PRIMARY KEY (booking_id);
ALTER TABLE booking_y2023 ADD CONSTRAINT fk_booking_y2023_property
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE;
ALTER TABLE booking_y2023 ADD CONSTRAINT fk_booking_y2023_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_booking_y2023_user_id ON booking_y2023(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_y2023_property_id ON booking_y2023(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_y2023_status ON booking_y2023(status);
CREATE INDEX IF NOT EXISTS idx_booking_y2023_end_date ON booking_y2023(end_date);

ALTER TABLE booking_y2025 ADD CONSTRAINT pk_booking_y2025 PRIMARY KEY (booking_id);
ALTER TABLE booking_y2025 ADD CONSTRAINT fk_booking_y2025_property
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE;
ALTER TABLE booking_y2025 ADD CONSTRAINT fk_booking_y2025_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_booking_y2025_user_id ON booking_y2025(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_y2025_property_id ON booking_y2025(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_y2025_status ON booking_y2025(status);
CREATE INDEX IF NOT EXISTS idx_booking_y2025_end_date ON booking_y2025(end_date);