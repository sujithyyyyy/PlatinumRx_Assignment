📘 PlatinumRx – Data Analyst Project

This repository contains my complete submission for the PlatinumRx Data Analyst Assessment, covering SQL, Spreadsheets, and Python tasks. The goal of this project is to demonstrate end-to-end analytical, data manipulation, and problem-solving skills across multiple tools.

🚀 1. Objective

This assignment showcases practical skills in:

SQL – Schema creation, data modeling, and analytical queries for Hotel and Clinic management systems.

Spreadsheets – Lookup operations, date/time extraction, and ticket analysis.

Python – Basic programming logic using loops, arithmetic operations, and string manipulation.

The structure and solutions simulate real-world data workflows used in support, operations, and analytics roles.

🧰 2. Tools & Requirements
✓ SQL

You may use:

MySQL Workbench

PostgreSQL

SQLite (SQLiteOnline recommended)

DB Fiddle / SQL Fiddle

Required SQL knowledge:

CREATE TABLE

INSERT

JOINs

GROUP BY

Aggregations (SUM, COUNT)

Window functions (ROW_NUMBER, RANK)

✓ Spreadsheets

Microsoft Excel or Google Sheets

VLOOKUP / INDEX-MATCH

Date & Time functions

COUNTIFS

Pivot Tables

✓ Python

Python 3.x

Any IDE: VS Code, PyCharm, Jupyter, Google Colab

Variables, loops, input, arithmetic, string operations

📂 3. Project Structure
PlatinumRx_Assignment/
│
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
│
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
│
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
│
└── README.md


Each folder contains the scripts relevant to its phase.

🏨 4. SQL Tasks Overview
Phase A – Hotel Management System

Latest booked room per user

Use MAX(booking_date) or ORDER BY + LIMIT.

Booking ID + total bill amount for Nov 2021

Join bookings, booking_commercials, items

bill = SUM(quantity × item_rate)

Bills > 1000 in Oct 2021

Use GROUP BY bill_id

HAVING SUM(…) > 1000

Most/least ordered item per month (2021)

Use GROUP BY item + month

RANK() or ROW_NUMBER() to pick top/bottom

Customers with 2nd highest bill per month (2021)

Rank bills month-wise

Filter where rank = 2

Phase B – Clinic Management System

Revenue per sales channel

Top 10 valuable customers

Month-wise revenue, expense, profit, status

Most profitable clinic per city

Second least profitable clinic per state

These solutions use strftime(), aggregations, CTEs, and window functions (or correlated subqueries for older SQLite versions).

📊 5. Spreadsheet Tasks Overview
Sheet Setup

Sheet 1: ticket

Sheet 2: feedbacks

Task 1 – Populate Created_Date

Use VLOOKUP/INDEX-MATCH to bring the created_at timestamp from ticket to feedbacks:

=VLOOKUP(A2, ticket!A:F, 3, FALSE)

Task 2 – Same Day / Same Hour Analysis

Add helper columns:

Same Day? → compare DATE(Created) vs DATE(Closed)

Same Hour? → compare HOUR(Created) vs HOUR(Closed)

Use COUNTIFS or Pivot Tables to compute results per outlet.

🐍 6. Python Tasks Overview
1) Convert Minutes to Human-Readable Format
minutes = int(input("Enter minutes: "))

hours = minutes // 60
remaining = minutes % 60

if hours == 0:
    print(f"{remaining} minutes")
elif remaining == 0:
    print(f"{hours} hrs")
else:
    print(f"{hours} hrs {remaining} minutes")

2) Remove Duplicates (using loop)

Case-insensitive version:

text = input("Enter a string: ")

result = ""
seen = ""

for char in text:
    if char.lower() not in seen:
        result += char
        seen += char.lower()

print(result)

📬 7. Submission Checklist

Before submitting, ensure:

SQL

✔ Schema setups execute without errors
✔ Queries return correct outputs
✔ Window-function queries work (or fallback logic used for SQLite)

Spreadsheets

✔ Lookup values populate correctly
✔ Date/time comparison logic is accurate
✔ Pivot table or COUNTIFS results match expected outputs

Python

✔ Both scripts run without errors
✔ Output matches expected format for duplicates/time conversion
✔ Edge cases handled (0 minutes, mixed-case strings, etc.)
