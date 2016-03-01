--1 show cities og agents booking order for customer whose is is c002
SELECT city
FROM agents a INNER JOIN orders o ON a.aid = o.aid
WHERE cid = 'c002'

--2 show ids of products ordered thru any agent who makes at least one order for a customer in dallas sorted DESC
SELECT p.pid
FROM orders o INNER JOIN products p ON o.pid = p.pid
		INNER JOIN agents a ON o.aid = a.aid
WHERE a.city = 'Dallas'
ORDER BY p.pid DESC

--3 show names of customers who never placed an order
SELECT name
FROM customers
WHERE cid NOT IN (SELECT cid
		  FROM orders);

--4 show names of customers who never placed an order
SELECT c.name
FROM customers c LEFT OUTER JOIN orders o ON c.cid = o.cid
WHERE o.ordnum IS NULL


--5 show names of customers and agents living in the same city along with name of shared city regard
SELECT c.name, a.name
FROM orders o INNER JOIN customers c ON o.cid = c.cid
	      INNER JOIN agents a ON o.aid = a.aid
WHERE c.city = a.city

--6 show names of customer anf agents living in the same city along with the name of shared city regardless  of whether or nor the customer ever placed an ored with that agent
SELECT c.name, c.city, a.name, a.city
FROM customers c INNER JOIN agents a ON c.city = a.city
	    	    

--7 show name and city of customers  who live in the city that makes the fewest different kinds of products
SELECT DISTINCT c.name, c.city
FROM customers c INNER JOIN products p ON c.city = p.city
WHERE p.city IN (SELECT city
		FROM products
		GROUP BY city
		ORDER BY count(city) ASC
		Limit 1)




		  
