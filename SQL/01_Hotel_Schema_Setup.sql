-- users table
CREATE TABLE users (
    user_id         TEXT PRIMARY KEY,
    name            TEXT NOT NULL,
    phone_number    TEXT,
    mail_id         TEXT,
    billing_address TEXT
);

Sample data
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '9754896454', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('98abchyu-12kloj', 'Alice Smith', '9845671230', 'alice@example.com', '12, Lake Road, DEF City'),
('55pqrsop-88tyui', 'Rahul Kumar', '9876501234', 'rahul@example.com', '45, Park View, GHI City');

-- bookings table
CREATE TABLE bookings (
    booking_id   TEXT PRIMARY KEY,
    booking_date TEXT NOT NULL,      -- store as ISO string 'YYYY-MM-DD HH:MM:SS'
    room_no      TEXT NOT NULL,
    user_id      TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

Sample data
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-11aa2-bb33', '2021-10-10 14:15:00', 'rm-202-ocean', '98abchyu-12kloj'),
('bk-22cc3-dd44', '2021-11-05 19:30:00', 'rm-305-suite', '55pqrsop-88tyui'),
('bk-33ee4-ff55', '2021-11-20 09:45:00', 'rm-108-delx', '21wrcxuy-67erfn');

-- items table
CREATE TABLE items (
    item_id   TEXT PRIMARY KEY,
    item_name TEXT NOT NULL,
    item_rate REAL NOT NULL          -- per unit price
);

Sample data
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu',  'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg',      89),
('itm-w978-23u4',  'Paneer Tikka', 220),
('itm-11xx-22yy',  'Coffee',       60),
('itm-33zz-44ww',  'Breakfast Combo', 350);

--booking_commercials table
CREATE TABLE booking_commercials (
    id            TEXT PRIMARY KEY,
    booking_id    TEXT NOT NULL,
    bill_id       TEXT NOT NULL,
    bill_date     TEXT NOT NULL,      -- 'YYYY-MM-DD HH:MM:SS'
    item_id       TEXT NOT NULL,
    item_quantity REAL NOT NULL,      -- allows 0.5, etc.
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);

Sample data (including Oct & Nov 2021 bills)
INSERT INTO booking_commercials
(id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES

('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340',
 '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340',
 '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),

('oct-1-line-1', 'bk-11aa2-bb33', 'bl-oct-1001',
 '2021-10-10 15:00:00', 'itm-w978-23u4', 2),
('oct-1-line-2', 'bk-11aa2-bb33', 'bl-oct-1001',
 '2021-10-10 15:00:00', 'itm-11xx-22yy', 3),

('oct-2-line-1', 'bk-11aa2-bb33', 'bl-oct-1002',
 '2021-10-28 20:10:00', 'itm-a9e8-q8fu', 4),


('nov-1-line-1', 'bk-22cc3-dd44', 'bl-nov-2001',
 '2021-11-05 20:00:00', 'itm-33zz-44ww', 2),
('nov-1-line-2', 'bk-22cc3-dd44', 'bl-nov-2001',
 '2021-11-05 20:00:00', 'itm-11xx-22yy', 2),

('nov-2-line-1', 'bk-33ee4-ff55', 'bl-nov-2002',
 '2021-11-20 10:15:00', 'itm-w978-23u4', 1.5),
('nov-2-line-2', 'bk-33ee4-ff55', 'bl-nov-2002',
 '2021-11-20 10:15:00', 'itm-a07vh-aer8', 2);