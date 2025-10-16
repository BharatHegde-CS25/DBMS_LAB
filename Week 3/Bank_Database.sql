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

select branch_name, (assets/100000) as "assets_in_lakhs" from branch;

select d.customer_name,b.branch_name,count(*) as no_of_account
from depositer d
join bankaccount1 b on d.accno=b.accno
group by d.customer_name,b.branch_name
having count(*)>=2;

create view branchloan as
select branch_name, sum(amount) as total_loan_amount
from loan
group by branch_name;
select * from branchloan;