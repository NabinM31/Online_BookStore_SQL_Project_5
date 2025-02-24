# 📚 Online Bookstore SQL Project 🚀

<p align="center">
  <img src="logo.png" width="200" alt="Project Logo">
</p>

## 📢 About This Project

This repository contains an SQL-based Online Bookstore Data Analysis project. It involves analyzing book sales, customer data, and revenue insights using SQL queries. The dataset includes details about books, customers, and orders.

---

## 🎯 Objectives

✅ Perform data cleaning and transformation.

✅ Analyze book sales and customer purchasing trends.

✅ Extract insights about revenue generation and stock management.

✅ Practice SQL queries for data-driven decision-making.

---
## 📂 Dataset Overview

The dataset consists of three main tables:

📖 Books (Book details, Genre, Price, Stock)

👤 Customers (Customer information, Location, Contact)

🛒 Orders (Purchase history, Quantity, Total amount)

---
## 🏛 Database Schema

The following schema represents the structure of the Online Bookstore dataset:
```sql
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
```

## 📝 Queries Included

📌 Key SQL Queries Covered:

📊 Retrieve all books in the 'Fiction' genre.

📅 Find books published after 1950.

📍 List customers from Canada.

🛒 Show orders placed in November 2023.

📚 Retrieve total stock of books available.

💰 Find the most expensive book.

🏆 Show customers who ordered more than one book.

📈 Calculate total revenue generated from all orders.

🔝 Retrieve the most frequently ordered book.

🏅 Find the customer who spent the most.

📉 Calculate stock remaining after fulfilling all orders.

----------------------------------------------------------------
## BASIC Questions
---------------------------------------------------------------

1. Retrieve all books in the "Fiction" genre:
```sql
SELECT * FROM Books
WHERE genre='Fiction';
```
---------------------------------------------------------------
2. Find books published after the year 1950:
```sql
SELECT * FROM Books
WHERE published_year>1950;
```
--------------------------------------------------------------
3. List all customers from the Canada:
```sql
SELECT * FROM Customers
WHERE country='Canada';
```
--------------------------------------------------------------
4. Show orders placed in November 2023:
```sql
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
```
---------------------------------------------
5. Retrieve the total stock of books available:
```sql
SELECT SUM(stock)AS total_stocks_0f_books
FROM Books;
```
----------------------------------------------------
6. Find the details of the most expensive book:
```sql
SELECT title,
       price
FROM books ORDER BY price DESC
LIMIT 1;
```
----------------------------
7. Show all customers who ordered more than 1 quantity of a book:
```sql
SELECT * FROM orders
WHERE quantity>1;
```
--------
8. Retrieve all orders where the total amount exceeds $20:
```sql
SELECT * FROM orders
where total_amount>20;
```
-------
9. List all genres available in the Books table:
```sql
SELECT DISTINCT genre FROM books;
```
----
10. Find the book with the lowest stock:
```sql
SELECT * FROM books
ORDER BY stock ASC
LIMIT 1;
```
----
11. Calculate the total revenue generated from all orders:
```sql
SELECT SUM(total_amount)AS Total_Revenue
FROM Orders;
```
---------------------------------------------------------------
## Advance Questions : 
----------------------------------------------------------------

1. Retrieve the total number of books sold for each genre
```sql
SELECT b.genre,
       SUM(o.quantity)AS Total_books_sold
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.genre;
```
-----
2. Find the average price of books in the "Fantasy" genre:
```sql
SELECT AVG(price) AS Average_price FROM books
WHERE genre='Fantasy';
```
----
3. List customers who have placed at least 2 orders:
```sql
SELECT customer_id,
       COUNT (order_id) AS Total_order_count
FROM orders
GROUP BY customer_id
HAVING COUNT (order_id)>=2;

-- using JOIN
SELECT o.customer_id,
       c.name, COUNT (o.order_id) AS Total_order_count
FROM orders o
JOIN customers c 
ON c.customer_id = o.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT (o.order_id)>=2;
```
-----
4. Find the most frequently ordered book:
```sql
SELECT book_id,
       COUNT(order_id)AS Order_table
FROM orders
GROUP BY book_id
ORDER BY order_table DESC
LIMIT 1;

--using join
SELECT o.book_id,
       b.title, COUNT(o.order_id)AS Order_table 
FROM orders o
JOIN books b
ON b.book_id = o.book_id
GROUP BY o.book_id, b.title
ORDER BY order_table DESC
LIMIT 1;
```
----
5. Show the top 3 most expensive books of 'Fantasy' Genre :
```sql
SELECT * FROM books
WHERE genre='Fantasy'
ORDER BY price DESC 
LIMIT 5;
```
-----
6. Retrieve the total quantity of books sold by each author:
```sql
SELECT b.author,
       SUM(o.quantity)AS total_books_sold 
FROM orders o
JOIN books b
ON o.book_id = b.book_id
GROUP BY b.author;
```
----
7. List the cities where customers who spent over $30 are located:
```sql
SELECT DISTINCT c.city,
                o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.total_amount>=30;
```
----
8. Find the customer who spent the most on orders:
```sql
SELECT c.customer_id,
       c.name,
       SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name,c.customer_id
ORDER BY total_spent DESC
LIMIT 1;
```
-----
9. Calculate the stock remaining after fulfilling all orders:
```sql
SELECT b.book_id,
       b.title,
       b.stock,
       COALESCE (SUM(o.quantity),0) as order_quantity,
       b.stock - COALESCE (SUM(o.quantity),0) as Remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.order_id
GROUP BY b.book_id
ORDER BY b.book_id;
```





