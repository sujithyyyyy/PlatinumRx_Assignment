--B(1). Revenue from each sales channel in a given year

SELECT sales_channel,SUM(Amount) AS Revenue From Clinic_sales Where strftime("%Y",Datetime)='2021' Group By sales_channel;

--B(2). Find top 10 the most valuable customers for a given year 
SELECT 
    c.name,
    SUM(cs.amount) AS total_spend --Each valuable can be found by total_spend amount only
FROM Customer c
JOIN Clinic_sales cs ON c.uid = cs.uid
WHERE strftime('%Y', cs.datetime) = '2021'
GROUP BY c.uid, c.name
ORDER BY total_spend DESC
LIMIT 10;

--B(3).Find month wise revenue, expense, profit , status (profitable / not-profitable) for a given year

WITH revenue AS (
    SELECT 
        CAST(strftime('%m', datetime) AS INTEGER) AS month_no,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month_no
),
expense AS (
    SELECT 
        CAST(strftime('%m', datetime) AS INTEGER) AS month_no,
        SUM(amount) AS expense
    FROM expenses
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month_no
)

SELECT
    m.month_no,
    COALESCE(r.revenue, 0) AS revenue,
    COALESCE(e.expense, 0) AS expense,
    COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit,
    CASE 
        WHEN COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) >= 0 
            THEN 'profitable'
        ELSE 'not-profitable'
    END AS status
FROM (
    SELECT month_no FROM revenue
    UNION 
    SELECT month_no FROM expense
) m
LEFT JOIN revenue r ON m.month_no = r.month_no
LEFT JOIN expense e ON m.month_no = e.month_no
ORDER BY m.month_no;

--B(4)For each city find the most profitable clinic for a given month
WITH revenue AS (
    SELECT 
        cid,
        CAST(strftime('%Y', datetime) AS INTEGER) AS yr,
        CAST(strftime('%m', datetime) AS INTEGER) AS mon,
        SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY cid, yr, mon
),
expense AS (
    SELECT 
        cid,
        CAST(strftime('%Y', datetime) AS INTEGER) AS yr,
        CAST(strftime('%m', datetime) AS INTEGER) AS mon,
        SUM(amount) AS expense
    FROM expenses
    GROUP BY cid, yr, mon
),
clinic_month_profit AS (
    SELECT 
        r.cid,
        r.yr,
        r.mon,
        r.revenue,
        COALESCE(e.expense, 0) AS expense,
        r.revenue - COALESCE(e.expense, 0) AS profit
    FROM revenue r
    LEFT JOIN expense e
      ON r.cid = e.cid
     AND r.yr = e.yr
     AND r.mon = e.mon
)
SELECT city, clinic_name, cid, profit
FROM (
    SELECT
        cl.city,
        cl.clinic_name,
        cmp.cid,
        cmp.profit,
        RANK() OVER (PARTITION BY cl.city ORDER BY cmp.profit DESC) AS rnk
    FROM clinic_month_profit cmp
    JOIN clinics cl ON cl.cid = cmp.cid
    WHERE cmp.yr = 2021
      AND cmp.mon = 5   
) t
WHERE rnk = 1;

--B(5)For each state find the second least profitable clinic for a given month
WITH revenue AS (
    SELECT 
        cid,
        CAST(strftime('%Y', datetime) AS INTEGER) AS yr,
        CAST(strftime('%m', datetime) AS INTEGER) AS mon,
        SUM(amount) AS revenue
    FROM clinic_sales
    GROUP BY cid, yr, mon
),
expense AS (
    SELECT 
        cid,
        CAST(strftime('%Y', datetime) AS INTEGER) AS yr,
        CAST(strftime('%m', datetime) AS INTEGER) AS mon,
        SUM(amount) AS expense
    FROM expenses
    GROUP BY cid, yr, mon
),
clinic_month_profit AS (
    SELECT 
        r.cid,
        r.yr,
        r.mon,
        r.revenue,
        COALESCE(e.expense, 0) AS expense,
        r.revenue - COALESCE(e.expense, 0) AS profit
    FROM revenue r
    LEFT JOIN expense e
      ON r.cid = e.cid
     AND r.yr = e.yr
     AND r.mon = e.mon
)

SELECT 
    cl.state,
    cl.clinic_name,
    cmp.cid,
    cmp.profit
FROM clinic_month_profit cmp
JOIN clinics cl ON cl.cid = cmp.cid
WHERE cmp.yr = 2021
  AND cmp.mon = 5
  AND cmp.profit = (
      SELECT profit
      FROM (
          SELECT DISTINCT cmp2.profit
          FROM clinic_month_profit cmp2
          JOIN clinics cl2 ON cl2.cid = cmp2.cid
          WHERE cmp2.yr = 2021
            AND cmp2.mon = 5
            AND cl2.state = cl.state
          ORDER BY cmp2.profit ASC
          LIMIT 1 OFFSET 1       -- second least
      )
  );