# Homework SQL

Problem: Create Restaurant database using sqlite3. Use `SELECT` and `WITH` (or subqueries)

```
-- customers table
CREATE TABLE IF NOT EXISTS customers(id int, name text, city text); 

INSERT INTO customers (id, name, city)
VALUES 
(1, "Moana", "Hawaii"),
(2, "Snow White","Wild"),
(3, "Pinocchio","Whale"),
(4, "Aladdin","Magic Lamp");

-- menu table
CREATE TABLE if not exists menus (menu_id int, menu_name text, price real);

INSERT INTO menus (menu_id, menu_name, price) 
VALUES
(1, "Pineapple Fried Rice", 35.7),
(2, "Apple Fritters", 28.3),
(3, "Shrimp Chilli Stir-fry", 17.9),
(4, "Risotto", 33.4),
(5, "Pad Thai", 42.7),
(6, "Vegie Green Curry", 29.5);

-- transaction table
CREATE TABLE if not exists transactions (id int, customer_id int, menu_id int, qty int);

INSERT INTO transactions VALUES
(1, 1, 3, 1),
(2, 1, 5, 1),
(3, 1, 1, 1),
(4, 3, 2, 2),
(5, 3, 3, 1),
(6, 4, 6, 1);

-- get customer table
SELECT *
FROM customers;

-- get menus table
SELECT *
FROM menus;

-- get trx table
SELECT *
FROM transactions;
```

```
-- get price per customer and location
SELECT 
name,
city,
ROUND(SUM(total_price),1)
FROM (
  select 
  cust.name,
  cust.city,
  menus.menu_name,
  menus.price,
  trx.qty,
  menus.price*trx.qty AS total_price
  from transactions AS trx
  JOIN customers AS cust
  on trx.customer_id = cust.id
  JOIN menus 
  ON trx.menu_id = menus.menu_id
  GROUP BY 
  cust.name,
  cust.city,
  menus.menu_name,
  menus.price,
  trx.qty
)
GROUP BY 
name,
city;
```