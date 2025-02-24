# 📚 Online Bookstore SQL Project 🚀

<p align="center">
  <img src="logo.png" width="200" alt="Project Logo">
</p>

# 📢 About This Project

This repository contains an SQL-based Online Bookstore Data Analysis project. It involves analyzing book sales, customer data, and revenue insights using SQL queries. The dataset includes details about books, customers, and orders.

---

# 🎯 Objectives

✅ Perform data cleaning and transformation.
✅ Analyze book sales and customer purchasing trends.
✅ Extract insights about revenue generation and stock management.
✅ Practice SQL queries for data-driven decision-making.

---
# 📂 Dataset Overview

The dataset consists of three main tables:

📖 Books (Book details, Genre, Price, Stock)

👤 Customers (Customer information, Location, Contact)

🛒 Orders (Purchase history, Quantity, Total amount)

---
# 🏛 Database Schema

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
