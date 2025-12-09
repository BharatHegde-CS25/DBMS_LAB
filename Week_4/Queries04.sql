create database bankdatabase;
use bankdatabase;

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets int
);


CREATE TABLE BankAccount1 (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance int,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(100) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);


CREATE TABLE Depositer (
    customer_name VARCHAR(100),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (accno) REFERENCES BankAccount1(accno)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount int,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

insert into Branch values('SBI_Chamrajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParliamentRoad','Delhi',10000);
insert into Branch values('SBI_Jantarmantar','Delhi',20000);
select * from Branch;

insert into BankAccount1 values(1,'SBI_Chamrajpet',2000);
insert into BankAccount1 values(2,'SBI_ResidencyRoad',5000);
insert into BankAccount1 values(3,'SBI_ShivajiRoad',6000);
insert into BankAccount1 values(4,'SBI_ParliamentRoad',9000);
insert into BankAccount1 values(5,'SBI_Jantarmantar',8000);
insert into BankAccount1 values(6,'SBI_ShivajiRoad',4000);
insert into BankAccount1 values(8,'SBI_ResidencyRoad',4000);
insert into BankAccount1 values(9,'SBI_ParliamentRoad',3000);
insert into BankAccount1 values(10,'SBI_ResidencyRoad',5000);
insert into BankAccount1 values(11,'SBI_Jantarmantar',2000);
select * from BankAccount1;


insert into BankCustomer values('Avinash','Bull_Temple_Road','Bangalore');
insert into BankCustomer values('Dinesh','Bannergatta_Road','Bangalore');
insert into BankCustomer values('Mohan','NationalCollege_Road','Bangalore');
insert into BankCustomer values('Nikil','Akbar_Road','Delhi');
insert into BankCustomer values('Ravi','Prithviraj_Road','Delhi');
select * from BankCustomer;


insert into Loan values(1,'SBI_Chamrajpet',1000);
insert into Loan values(2,'SBI_ResidencyRoad',2000);
insert into Loan values(3,'SBI_ShivajiRoad',3000);
insert into Loan values(4,'SBI_ParliamentRoad',4000);
insert into Loan values(5,'SBI_Jantarmantar',5000);
select * from Loan;

insert into Depositer values('Avinash',1);
insert into Depositer values('Dinesh',2);
insert into Depositer values('Nikil',4);
insert into Depositer values('Ravi',5);
insert into Depositer values('Avinash',8);
insert into Depositer values('Nikil',9);
insert into Depositer values('Dinesh',10);
insert into Depositer values('Nikil',11);
select * from Depositer;


SELECT d.customer_name
FROM Depositer d
JOIN BankAccount1 b ON d.accno = b.accno
JOIN Branch br ON b.branch_name = br.branch_name
WHERE br.branch_city = 'Delhi'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT br.branch_name) =
      (SELECT COUNT(*) FROM Branch WHERE branch_city = 'Delhi');
      
      
      SELECT DISTINCT bc.customer_name
FROM BankCustomer bc
JOIN Loan l ON bc.customer_city = bc.customer_city   -- Not needed for relation
WHERE bc.customer_name NOT IN (SELECT customer_name FROM Depositer);


SELECT DISTINCT bc.customer_name
FROM BankCustomer bc
JOIN Depositer d ON bc.customer_name = d.customer_name
JOIN BankAccount1 ba ON d.accno = ba.accno
JOIN Loan l ON l.branch_name = ba.branch_name
WHERE ba.branch_name IN (
    SELECT branch_name FROM Branch WHERE branch_city = 'Bangalore'
);


SELECT branch_name
FROM Branch
WHERE assets > ALL (
        SELECT assets
        FROM Branch
        WHERE branch_city = 'Bangalore'
    );
    
DELETE FROM BankAccount1
WHERE branch_name IN (
    SELECT branch_name
    FROM Branch
    WHERE branch_city = 'Bombay'
);

UPDATE BankAccount1
SET balance = balance * 1.05;
