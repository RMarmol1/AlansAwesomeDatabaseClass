-- #1 order number and total dollars of all orders
SELECT ordnum, totalUSD
FROM orders;

--  #2 name and city of agents named smith
SELECT name, city
FROM agents
WHERE name = 'Smith';

-- #3 id, name, and price of products greater than 208000
SELECT pid, name, priceUSD
FROM products
WHERE quantity > 208000;

--- #4 name and city of customers in dallas
SELECT name, city
FROM customers
WHERE city = 'Dallas';

-- #5 names of agents not in new york and not in tokyo
SELECT name
FROM agents
WHERE city != 'New York'
OR city != 'Tokyo';

-- #6 all data for products not in dallas or duluth that costs 1 dollar or more
SELECT *
FROM products
WHERE city != 'Dallas'
AND city != 'Duluth'
AND priceUSD >= 1.00;

-- #7 all data in jan or march
SELECT *
FROM orders
WHERE mon IN ('jan', 'mar');


-- #8 all data for orders in feb less than $500
SELECT *
FROM orders
WHERE mon = 'feb'
AND totalUSD < 500;

-- #9 all orders from customer whose cid is c005
SELECT *
FROM orders
WHERE cid = 'C005';


