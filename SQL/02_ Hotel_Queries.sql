--A(1):For every user in the system, get the user_id and last booked room_no:

SELECT b.user_id,b.room_no FROM bookings b JOIN (SELECT user_id, MAX(Booking_date) AS last_booked_date FROM bookings GROUP BY user_id) 
AS t on b.user_id=t.user_id AND b.Booking_date=t.last_booked_date;

--A(2):2. Get booking_id and total billing amount of every booking created in November, 2021 


SELECT 
    b.booking_id,
    SUM(i.item_rate * b.item_quantity) AS total_bill
FROM booking_commercials b
JOIN items i ON b.item_id = i.item_id
WHERE strftime("%m",b.bill_date) = "11"
  AND strftime("%Y",b.bill_date) = "2021"
GROUP BY b.booking_id;


--A(3).Get bill_id and bill amount of all the bills raised in October, 2021 having bill amount >1000

select bc.bill_id ,SUM(i.item_rate*bc.item_quantity) AS Bill_Amount FROM items i JOIN booking_commercials bc 
ON i.item_id=bc.item_id
WHERE strftime("%m",bc.bill_date)='10'
AND strftime("%Y",bc.bill_date)='2021' 
Group By bc.bill_id
HAVING Bill_Amount>1000;

--A(4) Determine the most ordered and least ordered item of each month of year 2021 

WITH monthly_totals AS (
    SELECT
        strftime('%m', bc.bill_date) AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT
        mt.*,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS rn_max,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC)  AS rn_min
    FROM monthly_totals mt
)
SELECT 
    r.month,
    i.item_name,
    r.total_qty,
    CASE 
        WHEN rn_max = 1 THEN 'Most Ordered'
        WHEN rn_min = 1 THEN 'Least Ordered'
    END AS category
FROM ranked r
JOIN items i ON r.item_id = i.item_id
WHERE rn_max = 1 OR rn_min = 1
ORDER BY r.month, category;


--A(5)  Find the customers with the second highest bill value of each month of year 2021 

WITH monthly_bills AS (
    SELECT
        bc.bill_id,
        b.user_id,
        strftime('%m', bc.bill_date) AS month,
        SUM(i.item_rate * bc.item_quantity) AS total_bill
    FROM booking_commercials bc
    JOIN items i ON i.item_id = bc.item_id
    JOIN bookings b ON b.booking_id = bc.booking_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY bc.bill_id, month
),
ranked_bills AS (
    SELECT
        mb.*,
        DENSE_RANK() OVER (
            PARTITION BY month
            ORDER BY total_bill DESC
        ) AS bill_rank
    FROM monthly_bills mb
)
SELECT
    r.month,
    r.bill_id,
    r.total_bill,
    u.user_id,
    u.name AS customer_name
FROM ranked_bills r
JOIN users u ON u.user_id = r.user_id
WHERE bill_rank = 2
ORDER BY month;
 