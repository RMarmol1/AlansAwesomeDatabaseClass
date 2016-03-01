--1 display the name and city of customers who live in any city that makes the most different kinds of products
SELECT DISTINCT c.name, c.city
FROM customers c INNER JOIN products p ON c.city = p.city
WHERE p.city IN (SELECT city
		FROM products
		GROUP BY city
		ORDER BY count(city) DESC
		Limit 1)

--2 display the names of products whose priceUSD is strictly above the average price USD in reverse alphabaetical order
SELECT name
FROM products
WHERE priceUSD > (SELECT avg(priceUSD)
		  FROM products)
ORDER BY name DESC

--3 display customer name, pid ordered, and total for all orders, sorted by total from high to low
SELECT c.name, p.pid, o.totalUSD
FROM orders o INNER JOIN customers c ON o.cid = c.cid
	      INNER JOIN products p  ON o.pid = p.pid
GROUP BY c.name, p.pid, o.totalUSD
ORDER BY o.totalUSD DESC

--4 display all customer names in alphabetical order and their total entered and nothing more.
SELECT c.name, COALESCE(o.totalUSD, 0.00)
FROM orders o RIGHT OUTER JOIN customers c ON o.cid = c.cid
ORDER BY c.name ASC	

--5 display the names of all customers who bought products from agents based in tokyo along with names of products they ordered and the names of the agents who sold them
SELECT c.name, p.name, a.name
FROM orders o INNER JOIN customers c ON o.cid = c.cid
              INNER JOIN products p ON o.pid = p.pid
              INNER JOIN agents a ON o.aid = a.aid
WHERE a.city = 'Tokyo'

--6 check the accuracy of dollars column in orders table
SELECT o.totalUSD
FROM orders o INNER JOIN products p ON o.pid = p.pid
              INNER JOIN customers c ON o.cid = c.cid
WHERE o.totalUSD != (o.qty * p.priceUSD - ((o.qty * p.priceUSD) * (c.discount/100)))

-- 7 What's the difference between LEFT and RIGHT OUTER JOIN's?
-- LEFT OUTER JOIN takes all rows from the left table
-- RIGHT OUTER JOIN takes all rows from right table
-- This can be shown with the english and chinese numbers table where
-- English name: one, two, three numeric: 1, 2, 3
-- Chinese name: er, san, si numeric: 2, 3, 4
--ex: SELECT *
--    FROM english e LEFT OUTER JOIN chinese c ON e.numeric = c.numeric
-- which shows:  one    1 NULL NULL
--		 two    2 er   2
--               three  3 san  3
-- In this example, it only shows the left table's (english) rows compared to right table's (chinese) rows and since chinese doesnt have a 1 numeric it row comes up as null. Also, chinese's 4 isnt showing up because that row doesn't exist for english so it doesnt show up since LEFT OUTER JOIN only shows the left table's rows
--ex: SELECT *
--    FROM english e RIGHT OUTER JOIN chinese c ON e.numeric = c.numeric
--which shows:	 two    2    er   2
--               three  3    san  3
--		 NULL   NULL si   4
-- In this example, it only shows the right table's (chinese) rows compared to left table's (english) rows and since english doesnt have a 4 numeric row it comes up as null. Also, english's 1 isnt showing up because that row doesn't exist for chinese so it doesnt show up since RIGHT OUTER JOIN only shows the right table's rows
		  
