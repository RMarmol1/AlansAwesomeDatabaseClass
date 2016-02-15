-- 1 cities of agents booking order whose cid = c02
SELECT city
FROM agents
WHERE aid in (SELECT aid
	FROM orders
	WHERE cid = 'c002');

-- 2 ids of products ordered through any agent who takes at least one order from a customer in dallas DESC
SELECT pid
FROM products
WHERE pid in (SElECT pid
	  FROM orders
	  WHERE cid in ( SELECT cid
		     FROM customers
		     WHERE city = 'Dallas')
		     )
ORDER BY pid DESC;



--3 ids and names of customers who did not order through a01
SELECT cid, name
FROM customers
WHERE cid in (SELECT cid
	      FROM orders
	      WHERE aid != 'a01');

--4 ids of customers who ordered both p01 and p07
SELECT cid
FROM customers
WHERE cid in (SELECT cid
	      FROM orders
	      WHERE pid = 'p01')
AND cid in ( SELECT cid
	  FROM orders
	      WHERE pid = 'p07');

--5 ids of products not ordered by any customers through a07 DESC
SELECT pid
FROM products
WHERE pid not in (SELECT pid
		  FROM orders
		  WHERE aid = 'a07')
ORDER BY pid DESC;

--6 name discounts and city for all customers placed order thru agents in new york or london
SELECT name, discount, city
FROM customers
WHERE cid in (SELECT cid
	      FROM orders
	      WHERE aid in (SELECT aid
			    FROM agents
			    WHERE city in ('London', 'New York'))
		);

--7 all customers who have the same discount of any customers in dallas or london
SELECT *
FROM customers
WHERE discount in (SELECT discount
	           FROM customers
	           WHERE city in ('Dallas', 'London'));

--8
--Check constraints check a value being entered and must meet the guidelines in order to be entered. They are good for keeping out unwanted/unecessary data and adding rules to the database. An advantage of this is to add guidelines to the database, add restrictions, and make the data fit for its implementation. A good example could be a table including customers who bought alcohol where age needs to be over 21.
--      CREATE TABLE CUSTOMERS(
--	ID INT NOT NULL,
--	NAME VARCHAR (20) NOT NULL,
--	AGE INT NOT NULL CHECK(AGE >=21)
--	);
--A bad example could be a table that using an english check constraint in a spanish speaking workplace because people would try to enter 'chico' or 'chica' and not be able to enter the data
-- CREATE TABLE WORKERS(
-- 	ID INT NOT NULL,
--      NAME VARCHAR(20),
--	GENDER TEXT NOT NULL CHECK (GENDER = 'Boy' OR GENDER = 'Girl')
--	);
--The differences between the examples is that the good is practical, relevant, and easy to implement to the database, while the bad one is not.