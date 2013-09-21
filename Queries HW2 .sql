--Richard Liao.
--Database Management
--Alan Labouseur  
--Queries Homework 2
--Question #1: Get  the cities of agents booking an order for customer c002
SELECT 
	agents.city
FROM
	public.agents
WHERE
	 agents.aid in (
		SELECT
			orders.aid
		FROM 
			public.orders
		WHERE
			orders.cid = 'c002')

--Question 2 pids of all agent that makes at least 1 order where a customers.city = kyoto.
SELECT distinct
	orders.pid
FROM
	public.orders
WHERE
	orders.aid in (
	SELECT
		orders.aid--gets the aid of any agent that made a order to kyoto 
	FROM
		public.orders
	WHERE
		orders.cid in (
		SELECT --Gets the CID of customers in city Kyoto
			customers.cid
		FROM
			public.customers
		WHERE
			customers.city = 'Kyoto')
)
--Question 3 Find the cids and names of customers who never place an order through agent a03
SELECT 
	customers.cid, --gets cid and name of customers not in the subquery
	customers.name
FROM
	public.customers
WHERE
	customers.cid in (
		SELECT --Gets all the cids that a03 did not order
			orders.cid
		FROM 
			public.orders
		WHERE
			orders.aid != 'a03'
)
--Question 4: cids and names of customers who ordered both p01 and p07
SELECT
	customers.cid, --cid and name of cids that have pid of p01 and p07
	customers.name
FROM
	public.customers
WHERE
	customers.cid in(
	SELECT 	-- Gets cid where order pid is p07 and the cid has pid of p01
		orders.cid
	FROM
		public.orders
	WHERE                         
		orders.pid = 'p07' and  orders.cid in (

		SELECT --Gets the cid of all orders pid =p01
			orders.cid
		FROM
			public.orders
		WHERE
			orders.pid = 'p01'
	)
)
--Question 5: Get the pids of products ordered by customers through agent a03
SELECT distinct
	orders.pid--gets the pid of any agent that made a order to kyoto 
FROM
	public.orders
WHERE
	orders.cid in (
	SELECT --Gets the CID of customers who have ordered from a03(c002,c003,c001,c006
		orders.cid
	FROM
		public.orders
		
	WHERE
		orders.aid = 'a03'
		)
--Question 6:Get customers.name, customers.discount of all customers who placed orders through agents.city
--is Dallas or Duluth
SELECT
	customers.name,--gets name and discount where the cid in the subquery
	customers.discount
FROM
	public.customers
WHERE
	customers.cid in (
	SELECT distinct--Gets cid of all orders with aid in dallas or duluth
		orders.cid
	FROM
		public.orders
	WHERE
		orders.aid in (

		SELECT --Gets the aid where agents.city = 'Dallas' or 'Duluth'
			agents.aid
		FROM
			public.agents
		WHERE
			agents.city = 'Dallas' or agents.city = 'Duluth')
			)
--Question 7: Find all customers where customers.discount as the customers.city = dallas or kyoto
SELECT
	customers.*
FROM
	customers
WHERE
     customers.city in (SELECT distinct customers.city --checks to see if the city is Dallas or kyoto
			FROM customers 
			WHERE customers.city != 'Dallas' and customers.city != 'Kyoto')
     and 
     customers.discount in (--checks to see if the discount is the same as the ones from Dallas or Kyoto
			SELECT 
				customers.discount
			FROM
				customers
			WHERE
				customers.city = 'Dallas' or customers.city = 'Kyoto')

