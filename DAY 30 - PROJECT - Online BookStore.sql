--Create Tables.1
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

----Create Tables.2
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

--Create Tables.3
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM orders;

-- Import Data into Books Table by directly import 
-- Import Data into Customer Table by directly import 
-- Import Data into Orders Table by directly import 

--BASIC Questions
-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE published_year>1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE country='Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(stock)AS total_stocks_0f_books
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT title,price FROM books ORDER BY price DESC LIMIT 1;
-(Or)
SELECT * FROM books 
ORDER BY price DESC 
LIMIT 1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders
where total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM books;

-- 10) Find the book with the lowest stock:
SELECT * FROM books ORDER BY stock ASC  LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount)AS Total_Revenue
FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
--(here asking from two tables,therefore JOIN function)

SELECT b.genre, SUM(o.quantity)AS Total_books_sold
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.genre;

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Average_price FROM books
WHERE genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT customer_id,COUNT (order_id) AS Total_order_count
FROM orders
GROUP BY customer_id
HAVING COUNT (order_id)>=2;
-- using JOIN
SELECT o.customer_id,c.name, COUNT (o.order_id) AS Total_order_count
FROM orders o
JOIN customers c 
ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT (o.order_id)>=2;


-- 4) Find the most frequently ordered book:
SELECT book_id, COUNT(order_id)AS Order_table
FROM orders
GROUP BY book_id
ORDER BY order_table DESC
LIMIT 1;

--using join
SELECT o.book_id,b.title, COUNT(o.order_id)AS Order_table 
FROM orders o
JOIN books b
ON b.book_id = o.book_id
GROUP BY o.book_id, b.title
ORDER BY order_table DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre='Fantasy'
ORDER BY price DESC 
LIMIT 5;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author, SUM(o.quantity)AS total_books_sold 
FROM orders o
JOIN books b
ON o.book_id = b.book_id
GROUP BY b.author;


-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city,o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
 WHERE o.total_amount>=30;

 -- 8) Find the customer who spent the most on orders:
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name,c.customer_id
ORDER BY total_spent DESC;

SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name,c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

SELECT * FROM orders;
SELECT * FROM books;

--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE (SUM(o.quantity),0) as order_quantity,
       b.stock- COALESCE (SUM(o.quantity),0) as Remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.order_id
GROUP BY b.book_id
ORDER BY b.book_id; 


