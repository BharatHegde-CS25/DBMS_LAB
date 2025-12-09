CREATE DATABASE SupplierDB;
 use SupplierDb;
 
 CREATE TABLE Supplier(
 Sid  INT PRIMARY KEY ,
Sname VARCHAR(50),
City VARCHAR(50)
);

CREATE TABLE Parts(
Pid INT PRIMARY KEY,
Pname VARCHAR(50),
Color VARCHAR(50)
);

CREATE TABLE Catalog(
Sid INT,
Pid INT,
Cost DECIMAL(10,2),
PRIMARY KEY(Sid,Pid),
FOREIGN KEY (Sid) REFERENCES Supplier(Sid),
 FOREIGN KEY (Pid) REFERENCES Parts(Pid)
);

INSERT INTO Supplier values
(10001, 'Acme Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');
select * from Supplier;

INSERT INTO Parts VALUES
(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');
select * from Parts;

INSERT INTO Catalog VALUES
(10001, 20001, 10),
(10001, 20002, 10),
(10001, 20003, 30),
(10001, 20004, 10),
(10001, 20005, 10),
(10002, 20001, 10),
(10002, 20002, 20),
(10003, 20003, 30),
(10004, 20003, 40);
SELECT * FROM Catalog;

SELECT DISTINCT P.pname
FROM Parts P
JOIN Catalog C ON P.pid = C.pid;

SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE P.pid NOT IN (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid
    )
);

SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE P.color = 'Red'
    AND P.pid NOT IN (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid
    )
);


SELECT P.pname
FROM Parts P
JOIN Catalog C ON P.pid = C.pid
JOIN Supplier S ON S.sid = C.sid
WHERE S.sname = 'Acme Widget'
AND P.pid NOT IN (
    SELECT C2.pid
    FROM Catalog C2
    JOIN Supplier S2 ON C2.sid = S2.sid
    WHERE S2.sname <> 'Acme Widget'
);

SELECT C.sid
FROM Catalog C
JOIN (
    SELECT pid, AVG(cost) AS avg_cost
    FROM Catalog
    GROUP BY pid
) AS A ON C.pid = A.pid
WHERE C.cost > A.avg_cost;

SELECT P.pname, S.sname
FROM Catalog C
JOIN Supplier S ON C.sid = S.sid
JOIN Parts P ON C.pid = P.pid
WHERE C.cost = (
    SELECT MAX(C2.cost)
    FROM Catalog C2
    WHERE C2.pid = C.pid
);