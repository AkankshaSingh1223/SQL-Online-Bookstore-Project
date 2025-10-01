DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
Book_ID	SERIAL PRIMARY KEY,
Title	VARCHAR(100),	
Author	VARCHAR(100),	
Genre	VARCHAR(50),	
Published_Year INT,
Price	NUMERIC(10, 2),	
Stock	INT	
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
Customer_ID	SERIAL PRIMARY KEY,
Name VARCHAR(100),	
Email	VARCHAR(100),
Phone	VARCHAR(15),
City	VARCHAR(50),
Country	VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT, 
Total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


--Import data into table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'C:/Program Files/PostgreSQL/17/Books.csv'
DELIMITER ','
CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'C:/Program Files/PostgreSQL/17/customer.csv'
DELIMITER ','
CSV HEADER;


SET datestyle = 'DMY';

copy Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'C:/Program Files/PostgreSQL/17/order.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM Books
WHERE Genre='Fiction';

SELECT * FROM Books
WHERE Published_year>1950;

SELECT * FROM Customers
WHERE country='canada';

SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

SELECT SUM(stock) AS Total_stock
FROM Books;

SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

SELECT * FROM Orders
WHERE quantity>1;

SELECT * FROM Orders
WHERE Total_amount>20;

SELECT DISTINCT genre FROM Books;

SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;

SELECT SUM(total_amount) As Revenue
FROM Orders;

--Advance question:
SELECT * FROM Orders;

SELECT b.Genre, SUM(o.Quantity) As total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id =b.book_id
GROUP By b.Genre;

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre ='Fantasy';

SELECT o.customer_id, c.name, COUNT(o.Order_id) As ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id)>=2;

SELECT o.Book_id,b.title, COUNT(o.Order_id) As ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC
LIMIT 1; 

SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;

SELECT b.author, SUM(o.quantity) AS Total_Bools_Sold
FROM Orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

SELECT DISTINCT c.city, total_amount
FROM Orders o
JOIN  customers c ON o.customer_id=c.customer_id
WHERE o.total_amount>300;

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM Orders o
JOIN  customers c ON o.customer_id=c.customer_id
GROUP By c.customer_id, c.name
ORDER BY Total_spent DESC;

SELECT b.book_id, b.title, COALESCE(SUM(quantity),0) AS Order_quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP By b.book_id;











