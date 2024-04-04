Создание таблицы Deposits:
CREATE TABLE Deposits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ClientID INT NOT NULL,
    AccountID BIGINT NOT NULL,
    Currency varchar(255) NOT NULL,
    Saldo decimal(38,2),
    StatusID INT NOT NULL
);

INSERT INTO Deposits (ClientID, AccountID, Currency, Saldo, StatusID)
VALUES
	(65743, 1354686498, 'RUB', 0, 11255),
	(63522, 7319797999, 'EUR', 14.5, 11255),
	(43532, 165489952, 'USD', 2164.89, 11255),
	(65674, 4687954697, 'USD', 114.0, 11258),
	(63522, 1133547879, 'RUB', 0, 11255),
	(56889, 265985499, 'EUR', 447.54, 11255),
	(65674, 3565659988, 'RUB', 0, 32565),
	(65743, 7489415891, 'USD', 57.4, 11255),
	(43532, 1564898811, 'RUB', 25574.84, 11255),
	(63522, 2645988554, 'USD', 0, 32565),
	(43532, 2123659887, 'RUB', 125484.89, 11255),
	(43532, 3125477787, 'EUR', 66.95, 11255)

Создание таблицы Status:
CREATE TABLE Status (
    StatusID INT NOT NULL,
    StatusName VARCHAR(255) NOT NULL,
    StatusCode INT NOT NULL
);

INSERT INTO Status (StatusID, StatusName, StatusCode)
VALUES
    (556, 'В ожидании', 'PENDING'),
    (11255, 'Работает', 'WORK'),
    (11258, 'Заблокирован', 'BLOCKED'),
    (30005, 'Арестован', 'ARREST'),
    (32565, 'Закрыт', 'CLOSED')

Создание таблицы Clients:
CREATE TABLE Clients (
    ClientID INT,
    ClientType VARCHAR(255),
    ClientName VARCHAR(255)
);

INSERT INTO Clients (ClientID, ClientType, ClientName)
VALUES
	(155, 'PRIV', 'Иванов Иван Иваныч'),
	(225, 'PRIV', 'Иванов Петр Сидорович'),
	(226, 'ORG', 'ООО "Иванов"'),
        (358, 'PRIV', 'Петров Иван Иваныч'),
	(598, 'ORG', 'ИП Сидоров И.П.'),
	(973, 'PRIV', 'Сидоров Иван Петрович')

Написать запрос, выводящий количество работающих счетов (депозитов) с остатком более 0 по каждому клиенту в виде такой таблицы:
ФИО клиента		Рубли	Доллары	Евро
Иванов Иван Иваныч	2	0	0
Петров Петр Петрович	1	1	1
...			...	...	...

WITH temp AS (SELECT c.ClientID, d.Currency, COUNT(*) as count FROM Clients c
JOIN Deposits d
ON c.ClientID = d.ClientID
JOIN Status s
ON d.StatusID = s.StatusID
WHERE d.Saldo > 0 AND s.StatusCode = 'WORK'
GROUP BY c.ClientID, d.Currency
)
SELECT DISTINCT (SELECT ClientName from Clients WHERE temp.ClientID = Clients.ClientID) AS 'ФИО клиента',
(select count from temp where temp.Currency = 'RUB') as 'Рубли',
(select count from temp where temp.Currency = 'USD') as 'Доллары',
(select count from temp where temp.Currency = 'EUR') as 'Евро'
FROM temp

