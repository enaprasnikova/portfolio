Создание и добавление данных в таблицу Customers:

CREATE TABLE Customers (
    CustomerID CHAR(5) PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL
);

INSERT INTO Customers (CustomerID, CompanyName, Address, City, Country)
VALUES 
    ('ALFKI', 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin', 'Germany'),
    ('ANATR', 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', 'Mexico'),
    ('ANTON', 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', 'Mexico'),
    ('AROUT', 'Around the Horn', '120 Hanover Sq.', 'London', 'UK'),
    ('BERGS', 'Berglunds snabbköp', 'Berguvsvägen  8', 'Luleå', 'Sweden'),
    ('BLAUS', 'Blauer See Delikatessen', 'Forsterstr. 57', 'MannheimCity', 'Germany'),
    ('BLONP', 'Blondesddsl père et fils', '24, place Kléber', 'StrasbourgCity', 'France'),
    ('BOLID', 'Bólido Comidas preparadas', 'C/ Araquil, 67', 'MadridCity', 'Spain')

Создание и добавление данных в таблицу Orders:

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID CHAR(5),
    OrderDate VARCHAR(255) NOT NULL,
    OrderSum INT NOT NULL
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderSum)
VALUES
	(10355, 'AROUT', '15.11.1996', 10000),
	(10365, 'ANTON', '27.11.1996', 15000),
	(10381, 'LILAS', '12.12.1996', 20000),
	(10436, 'BLONP', '05.02.1997', 17500),
	(10442, 'ERNSH', '11.02.1997', 20000),
	(10449, 'BLONP', '18.02.1997', 10000),
	(10453, 'AROUT', '21.02.1997', 15000)


1. Вывести названия всех компаний, которые не выполнили заказ с 15.11.1996 – 18.02.1997;
SELECT c.CompanyName, o.OrderDate FROM Customers c 
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE STR_TO_DATE(o.OrderDate, '%d.%m.%Y') 
NOT BETWEEN STR_TO_DATE('15.11.1996', '%d.%m.%Y') AND STR_TO_DATE('18.02.1997', '%d.%m.%Y')

2. Вывести названия компаний поставщиков, которые находятся в México D.F.;
SELECT CompanyName FROM Customers
WHERE City = 'México D.F.'

3. Вывести только те заказы, которые были оформлены с 12.12.1996 по 18.02.1997;
SELECT * FROM Orders 
WHERE STR_TO_DATE(OrderDate, '%d.%m.%Y') 
BETWEEN STR_TO_DATE('12.12.1996', '%d.%m.%Y') AND STR_TO_DATE('18.02.1997', '%d.%m.%Y')

4. Вывести только тех заказчиков,  название компании которых начинаются с ‘An’;
SELECT * FROM Customers
WHERE CompanyName LIKE 'An%'

5. Вывести названия компаний и заказы, которые они оформили, с суммой заказа более 17000. Использовать соединение таблиц;
SELECT c.CompanyName, o.*  FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE OrderSum > 17000

6. Вывести следующие колонки: имя поставщика, сумма заказа. Результаты отсортировать по поставщикам в порядке убывания;
SELECT c.CompanyName, o.OrderSum  FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
ORDER BY c.CompanyName DESC

7. Вывести следующие колонки: имя поставщика, дата заказа. Вывести  таким образом, чтобы все заказчики из таблицы 1 были показаны в таблице результатов;
SELECT c.CompanyName, o.OrderDate 
FROM 
Customers c LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

