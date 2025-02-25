-- LAB 4 AGGREGATE FUNCTIONS
-- Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 6; your query for question 1B should go on line 8...

--  1 
-- A
SELECT MIN(price) AS "lowest_price" FROM stock_item;
-- B
SELECT MAX(inventory) AS "greatest_quantity" FROM stock_item;
-- C
SELECT AVG(price) AS "average_price" FROM stock_item;
-- D
SELECT SUM(inventory) AS "total_inventory" FROM stock_item;

--  2
-- A
SELECT role, COUNT(*) AS "employees_count" FROM employee GROUP BY role; 
-- B
SELECT category AS "mammals", COUNT(item) AS "item_count" FROM stock_item GROUP BY category HAVING category <> "piscine";
-- C
SELECT category, AVG(price) AS "average_price_($)" FROM stock_item GROUP BY category HAVING sum(inventory > 0);

--  3
-- A
SELECT category AS "species", SUM(inventory) AS "in_Stock" FROM stock_item GROUP BY category ORDER BY inventory ASC;
-- B
SELECT SUM(inventory) AS "total_stock", AVG(price) AS "average_price", category FROM stock_item GROUP BY category HAVING SUM(inventory) < 100 and AVG(price) < 100;

--  4
-- A
SELECT item AS "product", CONCAT("$", FORMAT(price, 2)) AS "price", inventory AS "stock_remaining", category AS "species", CONCAT("$", FORMAT(price * inventory, 2)) AS "potential_earnings"
FROM stock_item ORDER BY price * inventory DESC LIMIT 20;