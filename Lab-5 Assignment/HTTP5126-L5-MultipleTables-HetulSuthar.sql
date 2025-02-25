--  LAB 5 MULTIPLE TABLES

--  Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...

--  1 
-- A 
SELECT * FROM sale WHERE stock_item_id = 1014;

-- B 
SELECT sale.date, stock_item.stock_item_id 
FROM sale
JOIN stock_item
ON sale.stock_item_id = stock_item.stock_item_id
WHERE stock_item.stock_item_id = 1014;

--  2
-- A 
SELECT * FROM sale WHERE employee_id = 111;

-- B
SELECT sale.date, employee.first_name, employee.last_name, employee.employee_id, sale.stock_item_id
FROM sale
INNER JOIN employee
ON sale.employee_id = employee.employee_id
WHERE employee.employee_id = 111; 

--  3
-- A
SELECT sale.date, stock_item.name
FROM sale
JOIN stock_item ON sale.stock_item_id = stock_item.stock_item_id
ORDER BY sale.date DESC
LIMIT 5;

-- B
SELECT employee.first_name, employee.last_name, sale.date,
stock_item.name, stock_item.price
FROM sale
JOIN employee ON sale.employee_id = employee.employee_id 
JOIN stock_item ON sale.stock_item_id = stock_item.stock_item_id 
ORDER BY sale.date DESC
LIMIT 5;

--  4
-- A
SELECT sale.date, stock_item.name AS item_sold, employee.first_name
FROM sale
JOIN stock_item ON sale.stock_item_id = stock_item.stock_item_id
JOIN employee ON sale.employee_id = employee.employee_id
WHERE sale.date BETWEEN '2025-01-12' AND '2025-01-18'
ORDER BY sale.date;

-- B
SELECT employee.first_name, employee.last_name, COUNT(sale.sale_id) AS total_sales
FROM sale
JOIN employee ON sale.employee_id = employee.employee_id
GROUP BY employee.first_name, employee.last_name
ORDER BY total_sales DESC;  


--  5
-- A
SELECT sale.date, stock_item.name AS item_name, stock_item.price, stock_item.category, employee.first_name
FROM sale
JOIN stock_item ON sale.stock_item_id = stock_item.stock_item_id
JOIN employee ON sale.employee_id = employee.employee_id
WHERE employee.employee_id = (
                       SELECT sale.employee_id
                       FROM sale
                       GROUP BY sale.employee_id
                       ORDER BY COUNT(sale.sale_id) DESC
                       LIMIT 1)
                       ORDER BY sale.date;

-- B
SELECT stock_item.stock_item_id AS item_id, stock_item.name AS item_name, stock_item.price, stock_item.category, 
COUNT(sale.stock_item_id) AS times_sold
FROM stock_item
LEFT JOIN sale ON stock_item.stock_item_id = sale.stock_item_id
GROUP BY stock_item.stock_item_id, stock_item.name, stock_item.price, stock_item.category
ORDER BY stock_item.stock_item_id;

--  6
-- A : A store manager, I want to know which employees made the most sales during the week of January 12th to 18th, 2025, so I can recognize their hard work by their sell report. 

-- B
SELECT employee.first_name, COUNT(sale.sale_id) AS total_sales, stock_item.name AS item_name
FROM sale
JOIN employee ON sale.employee_id = employee.employee_id
JOIN stock_item ON sale.stock_item_id = stock_item.stock_item_id
WHERE sale.date BETWEEN '2025-01-12' AND '2025-01-18'
GROUP BY employee.first_name
ORDER BY total_sales DESC;
