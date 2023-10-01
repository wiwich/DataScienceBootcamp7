# SQL

## CRUD Operation
- CREATE
- RETRIEVE
- UPDATE
- DELETE

**CREATE** 
```
CREATE TABLE customer (
	id int,
	name text,
	city text,
	avg_spending real
);
```

**RETRIEVE (SELECT)**
```
SELECT *
FROM customer; 
```

**UPDATE**
```
INSERT INTO customer VALUES
	(1, "Mr.Bean", "London", "bean@gmail.com", 500.25),
	(2, "Teddy", "BKK", "teddy@gmail.com", 125.5);
```

**DELETE**
```
DROP TABLE customer;
```

## Basic SQL Clauses
- SELECT
- FROM 
- WHERE
- GROUP BY + AGGREGATE FUNCTIONS()
- HAVING
- ORDER BY

**example: find top 5 countries that have the most customers**
```
SELECT 
	country,
	COUNT(*) AS count_customers --count row
FROM customers
GROUP BY country
ORDER BY 2 DESC
LIMIT 5
```

**example: concate 2 columns**
```
SELECT 
	firstname, 
    lastname, 
    firstname || " " || lastname AS fullname, --concat columns
    country
FROM customers;
```

**example: manipulate columns**
```
SELECT 
	name,
    ROUND(milliseconds/60000.0, 2) AS minutes,
    ROUND(bytes/(1024*1024.0), 4) AS MBs
FROM tracks;
```

**example: filter multiple values**
```
SELECT * FROM customers
WHERE UPPER(country) IN ("USA","BRAZIL","BELGIUM");
```

**example: pattern matching LIKE operator (case insensitive)**
```
SELECT firstname, lastname, country 
FROM customers
WHERE country LIKE 'U%'; -- country start with 'U

-- or

SELECT firstname, lastname, email
FROM customers
WHERE firstname LIKE 'J___' -- first name start with J and follow 3 characters

-- or

SELECT country, firstname, lastname
FROM customers
WHERE country <> 'USA' -- filter every country except 'USA'
```

**example: date**
```
-- extract year, month, day from invoicedate using STRFTIEM
SELECT 
	invoicedate,
	STRFTIME("%Y", invoicedate) AS year, -- string format time
  STRFTIME("%m", invoicedate) AS month,
  STRFTIME("%d", invoicedate) AS day,
  billingaddress
FROM invoices
WHERE year = "2010" AND month = "09"
```

**example: aggregate functions**
```
SELECT 
	COUNT(*) AS n_rows,
    COUNT(bytes) AS n_tracks,
    AVG(bytes) AS avg_bytes,
    SUM(bytes) AS sum_bytes,
    MIN(bytes) AS min_bytes, 
    MAX(bytes) AS max_bytes
FROM tracks;
```

**example: check NULL**
```
-- find company column is null
SELECT * FROM customers
WHERE company IS NULL

-- find company column is not null
SELECT * FROM customers
WHERE company IS NOT NULL
```

## Conditions
**example: case when**
```
SELECT
	firstname,
    company,
    COALESCE(company, "No information") AS clean_company,
    CASE
    	WHEN company IS NULL THEN 'B2C'
      WHEN company IS NOT NULL THEN 'B2B'
    END
FROM customers;
-- or
SELECT
	firstname,
    company,
    COALESCE(company, "No information") AS clean_company,
    CASE
    	WHEN company IS NULL THEN 'B2C'
      ELSE 'B2B'
    END
FROM customers;
```

## Join 
JOIN multiple table 
- inner join (default)
- left join
- right join
- full join
**example: inner join**
```
SELECT * FROM artists
JOIN albums 
ON artists.artistid;
```

## Virtual Table
```
-- create virtual table (only one time)
CREATE VIEW my_first_view AS
	.
	.
	.

-- create virtual table if not exists
CREATE VIEW IF NOT EXISTS my_first_view AS
	.
	.
	.

-- query virtual table
SELECT * FROM my_first_view

-- drop virtual table
DROP VIEW my_first_view
```

## Subquery
subquery run from inside to outside
**example subquery**
```
-- subquery inner + outer
SELECT * FROM (
	SELECT firstname, country FROM (
		SELECT * FROM customers
	)
)
WHERE country = 'Belgium'
;
```
**example: subquery + join vs. WITH clause**
```
-- select user who in 'USA' and invoicedate in 2009 
-- version1 - subquery
SELECT 
	sub1.firstname, 
	sub2.total
FROM 	(SELECT * FROM customers
		WHERE country = 'USA') AS sub1
JOIN	(SELECT * FROM invoices
		WHERE STRFTIME("%Y", invoicedate) = "2009") AS sub2
ON sub1.customerid = sub2.customerid;

-- version2 - common table expression => WITH
WITH sub1 AS (
	SELECT * FROM customers
	WHERE country = 'USA'
), sub2 AS (
	SELECT * FROM invoices
	WHERE STRFTIME("%Y", invoicedate) = "2009"
)
SELECT 
	sub1.firstname, 
	sub2.total
FROM sub1
JOIN sub2
ON sub1.customerid = sub2.customerid;

-- version3 - create views
CREATE VIEW usa_customers AS
	SELECT * FROM customers
	WHERE country = 'USA';

CREATE VIEW invoice_2009
	SELECT * FROM invoices
	WHERE STRFTIME("%Y", invoicedate) = "2009";

SELECT * FROM usa_customers AS a
JOIN invoice_2009 AS b
ON a.customerid = b.customerid;
```
```
-- WITH clause syntax / temp sub table
WITH table_name1 AS (), table_name2 AS ()
SELECT sub1 JOIN sub2 ON sub1.pk = sub2.fk;
```

