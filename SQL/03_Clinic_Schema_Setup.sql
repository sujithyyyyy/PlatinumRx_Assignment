--B clinic management system
--clinics TABLE CREATION
CREATE TABLE clinics (
  cid VARCHAR(20) PRIMARY KEY,
  clinic_name VARCHAR(100) NOT NULL,
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50)
);

-- VALUE INSERTION
INSERT INTO
  clinics (cid, clinic_name, city, state, country)
VALUES
  (
    'cnc-0100001',
    'XYZ Clinic',
    'Chennai',
    'Tamil Nadu',
    'India'
  ),
  (
    'cnc-0100002',
    'Alpha Health',
    'Chennai',
    'Tamil Nadu',
    'India'
  ),
  (
    'cnc-0100003',
    'CarePlus Clinic',
    'Bengaluru',
    'Karnataka',
    'India'
  ),
  (
    'cnc-0100004',
    'Wellness Point',
    'Hyderabad',
    'Telangana',
    'India'
  );

--customer TABLE CREATION
CREATE TABLE customer (
  uid VARCHAR(20) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  mobile VARCHAR(15)
);

--VALUE INSERTION
INSERT INTO
  customer (uid, name, mobile)
VALUES
  ('bk-09f3e-95hj', 'Jon Doe', '9711111111'),
  ('bk-12ab3-45cd', 'Alice Kumar', '9722222222'),
  ('bk-67xy9-88zz', 'Rahul Iyer', '9733333333'),
  ('bk-77lm0-11nn', 'Meera Das', '9744444444'),
  ('bk-55pp9-22qq', 'Arun Singh', '9755555555'),
  ('bk-33rr4-66ss', 'Fatima Noor', '9766666666');

--clinic_sales TABLE CREATION
CREATE TABLE clinic_sales (
  oid VARCHAR(20) PRIMARY KEY,
  uid VARCHAR(20) NOT NULL,
  cid VARCHAR(20) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  datetime TIMESTAMP NOT NULL,
  sales_channel VARCHAR(30) NOT NULL,
  FOREIGN KEY (uid) REFERENCES customer(uid),
  FOREIGN KEY (cid) REFERENCES clinics(cid)
);

--VALUE INSERTION
INSERT INTO
  clinic_sales (oid, uid, cid, amount, datetime, sales_channel)
VALUES
  (
    'ord-001',
    'bk-09f3e-95hj',
    'cnc-0100001',
    24999,
    '2021-01-15 10:12:00',
    'walk_in'
  ),
  (
    'ord-002',
    'bk-12ab3-45cd',
    'cnc-0100001',
    18000,
    '2021-01-28 16:45:00',
    'online'
  ),
  (
    'ord-003',
    'bk-67xy9-88zz',
    'cnc-0100002',
    12000,
    '2021-02-10 11:20:00',
    'aggregator'
  ),
  (
    'ord-004',
    'bk-77lm0-11nn',
    'cnc-0100003',
    15500,
    '2021-02-25 09:30:00',
    'walk_in'
  ),
  (
    'ord-005',
    'bk-55pp9-22qq',
    'cnc-0100004',
    22000,
    '2021-03-05 18:05:00',
    'corporate'
  ),
  (
    'ord-006',
    'bk-33rr4-66ss',
    'cnc-0100002',
    9000,
    '2021-03-19 14:10:00',
    'online'
  ),
  (
    'ord-007',
    'bk-09f3e-95hj',
    'cnc-0100003',
    30000,
    '2021-04-01 12:00:00',
    'walk_in'
  ),
  (
    'ord-008',
    'bk-12ab3-45cd',
    'cnc-0100004',
    17000,
    '2021-04-17 15:40:00',
    'aggregator'
  ),
  (
    'ord-009',
    'bk-67xy9-88zz',
    'cnc-0100001',
    26000,
    '2021-05-22 13:25:00',
    'corporate'
  ),
  (
    'ord-010',
    'bk-77lm0-11nn',
    'cnc-0100003',
    14000,
    '2021-05-30 19:50:00',
    'online'
  ),
  (
    'ord-011',
    'bk-55pp9-22qq',
    'cnc-0100002',
    11000,
    '2021-06-12 08:15:00',
    'walk_in'
  ),
  (
    'ord-012',
    'bk-33rr4-66ss',
    'cnc-0100004',
    19500,
    '2021-06-27 17:30:00',
    'online'
  );

--expenses TABLE CREATION
CREATE TABLE expenses (
  eid VARCHAR(20) PRIMARY KEY,
  cid VARCHAR(20) NOT NULL,
  description VARCHAR(255),
  amount DECIMAL(10, 2) NOT NULL,
  datetime TIMESTAMP NOT NULL,
  FOREIGN KEY (cid) REFERENCES clinics(cid)
);

--Value INSERTION
INSERT INTO
  expenses (eid, cid, description, amount, datetime)
VALUES
  (
    'exp-001',
    'cnc-0100001',
    'Rent',
    8000,
    '2021-01-05 08:00:00'
  ),
  (
    'exp-002',
    'cnc-0100001',
    'Supplies',
    3000,
    '2021-01-20 08:00:00'
  ),
  (
    'exp-003',
    'cnc-0100002',
    'Rent',
    7000,
    '2021-02-03 08:00:00'
  ),
  (
    'exp-004',
    'cnc-0100003',
    'Staff salaries',
    9000,
    '2021-02-18 08:00:00'
  ),
  (
    'exp-005',
    'cnc-0100004',
    'Equipment lease',
    6000,
    '2021-03-02 08:00:00'
  ),
  (
    'exp-006',
    'cnc-0100002',
    'Supplies',
    2500,
    '2021-03-10 08:00:00'
  ),
  (
    'exp-007',
    'cnc-0100003',
    'Utilities',
    4000,
    '2021-04-05 08:00:00'
  ),
  (
    'exp-008',
    'cnc-0100004',
    'Marketing',
    3500,
    '2021-04-22 08:00:00'
  ),
  (
    'exp-009',
    'cnc-0100001',
    'Staff salaries',
    9000,
    '2021-05-10 08:00:00'
  ),
  (
    'exp-010',
    'cnc-0100003',
    'Rent',
    8000,
    '2021-05-18 08:00:00'
  ),
  (
    'exp-011',
    'cnc-0100002',
    'Utilities',
    3000,
    '2021-06-01 08:00:00'
  ),
  (
    'exp-012',
    'cnc-0100004',
    'Supplies',
    3200,
    '2021-06-15 08:00:00'
  );