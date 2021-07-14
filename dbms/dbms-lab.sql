CREATE DATABASE DB;
use db;

DROP TABLE Employee;
DROP TABLE Department;
DROP TABLE Dependent;
DROP TABLE Project;
CREATE TABLE Employee(
    FNAME varchar(20),
    MINIT varchar(1),
    LNAME varchar(20),
    SSN int,
    BDATE varchar(15),
    ADDRESS varchar(50),
    SEX varchar(1),
    SALARY int,
    SUPERSSN int,
    DNO int
);
CREATE TABLE Department(
    DNAME varchar(30),
    DNumber int,
    MGRSSN int,
    SUPERSSN int,
    MGRSTARTDATE varchar(15)
);
CREATE TABLE Dependent(
    ESSN int,
    DEPENDENTNAME varchar(30),
    SEX varchar(1),
    BDATE varchar(15),
    RELATIONSHIP varchar(20)
);
CREATE TABLE Project(
    PNAME varchar(30) DEFAULT 'CSE',
    PNUMBER int DEFAULT 1,
    PLOCATION varchar(50) DEFAULT 'Patna',
    DNO int DEFAULT 0
);
CREATE TABLE Teachers AS SELECT FNAME, LNAME, BDATE, SALARY, SSN FROM Employee;
show tables;

DROP TABLE Teachers;

desc Employee;
ALTER TABLE Employee DROP COLUMN DNO;
desc Employee;

ALTER TABLE Employee ADD COLUMN Department varchar(30);
desc Employee;
ALTER TABLE Employee MODIFY COLUMN Department varchar(20);
desc Employee;

desc Project;

INSERT INTO Project VALUES('DBMS',302,'B.I.T',7);
SELECT * FROM Project;

INSERT INTO Project(PNAME,PNUMBER) VALUES('ML',237);
SELECT * FROM Project;
 
INSERT INTO Project values (DEFAULT,DEFAULT,DEFAULT,DEFAULT);
SELECT * FROM Project;

INSERT INTO Employee VALUES('Rosy','S','Sanders',424,'5 Jan 1996','Vietnam','F',80000,424,424);



UPDATE Employee SET FNAME='ABC', LNAME='CDE' WHERE SUPERSSN=420;
UPDATE Employee SET BDATE='20 Oct 1972',SALARY=20000  WHERE SUPERSSN=422;

UPDATE Employee SET SALARY=40000  WHERE SEX='F' AND SALARY=35000;


UPDATE Employee SET salary= salary + (salary * 10 / 100) WHERE salary > 35000 AND SEX='M';
UPDATE Employee SET salary= salary + (salary * 20 / 100) WHERE salary <= 35000 AND SEX='M';

CREATE TABLE CSE(     ENAME varchar(30),     SUPERSSN int,     SALARY INT ,     BDATE varchar(50));
INSERT INTO CSE(SELECT FNAME,SUPERSSN,SALARY,BDATE FROM Employee WHERE SUPERSSN IN (SELECT SUPERSSN FROM Department WHERE DNAME='CSE'));

CREATE TABLE CSEDEPT SELECT FNAME,SUPERSSN,SALARY,BDATE FROM Employee WHERE SUPERSSN IN (SELECT SUPERSSN FROM Department WHERE DNAME='CSE')
CREATE TABLE CSESALFIFTYGRTR SELECT FNAME,SUPERSSN,SALARY,BDATE FROM CSEDEPT WHERE SALARY>50000;

SELECT * FROM Employee;
DELETE FROM Employee WHERE SUPERSSN=420;

INSERT INTO Department VALUES('Management',2,2,425,'6 JAN');
INSERT INTO Department VALUES('Management',2,3,426,'7 JAN');
INSERT INTO Employee VALUES('Harry','J','Potter',425,'6 Jan 1996','London','M',80000,425,425);
INSERT INTO Employee VALUES('Ron','L','Whisley',426,'7 Jan 1996','London','M',76000,426,426);
SELECT FNAME,LNAME,SUPERSSN FROM Employee WHERE SUPERSSN IN (SELECT SUPERSSN FROM Department WHERE DNAME='Management');



DROP TABLE Project;

CREATE TABLE Project(
    PNAME varchar(30) DEFAULT 'CSE',
    PNUMBER int DEFAULT 1,
    PLOCATION varchar(50) DEFAULT 'Patna',
    DNO int DEFAULT 0
);
INSERT INTO Project VALUES('ML',27,'Patna',1);
INSERT INTO Project VALUES('DBMS',28,'Ranchi',1);
INSERT INTO Project VALUES('PM',27,'Patna',2);
INSERT INTO Project VALUES('BUSINESS COMM.',27,'Patna',2);

SELECT * FROM Project;

COMMIT;
START TRANSACTION;
INSERT INTO Project VALUES('FLT',27,'Patna',1);
SAVEPOINT A;
UPDATE Project SET PNAME='French' WHERE PNUMBER=30;
SAVEPOINT B;
UPDATE Project SET PNAME='COI' WHERE PNUMBER=29;
SAVEPOINT C;
SELECT * FROM Project;
ROLLBACK TO C;
SELECT * FROM Project;
ROLLBACK TO B;
SELECT * FROM Project;
ROLLBACK TO A;
SELECT * FROM Project;
COMMIT;
ROLLBACK TO C;

mysql> UPDATE Department SET DNumber=3 WHERE DNAME='ECE';
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE Department SET DNumber=4 WHERE DNAME='EEE';
Query OK, 1 row affected (0.13 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Department;
+------------+---------+--------+----------+--------------+
| DNAME      | DNumber | MGRSSN | SUPERSSN | MGRSTARTDATE |
+------------+---------+--------+----------+--------------+
| ECE        |       3 |      1 |      421 | 2 JAN        |
| EEE        |       4 |      1 |      422 | 3 JAN        |
| CSE        |       1 |      1 |      423 | 4 JAN        |
| CSE        |       1 |      1 |      424 | 5 JAN        |
| Management |       2 |      2 |      425 | 6 JAN        |
| Management |       2 |      3 |      426 | 7 JAN        |
+------------+---------+--------+----------+--------------+
6 rows in set (0.00 sec)

mysql> UPDATE Department SET MGRSSN=1 WHERE SUPERSSN=421;
Query OK, 0 rows affected (0.04 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql> UPDATE Department SET MGRSSN=2 WHERE SUPERSSN=422;
Query OK, 1 row affected (0.32 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE Department SET MGRSSN=3 WHERE SUPERSSN=423;
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE Department SET MGRSSN=4 WHERE SUPERSSN=424;
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE Department SET MGRSSN=5 WHERE SUPERSSN=425;
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE Department SET MGRSSN=6 WHERE SUPERSSN=426;
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Department;
+------------+---------+--------+----------+--------------+
| DNAME      | DNumber | MGRSSN | SUPERSSN | MGRSTARTDATE |
+------------+---------+--------+----------+--------------+
| ECE        |       3 |      1 |      421 | 2 JAN        |
| EEE        |       4 |      2 |      422 | 3 JAN        |
| CSE        |       1 |      3 |      423 | 4 JAN        |
| CSE        |       1 |      4 |      424 | 5 JAN        |
| Management |       2 |      5 |      425 | 6 JAN        |
| Management |       2 |      6 |      426 | 7 JAN        |
+------------+---------+--------+----------+--------------+
6 rows in set (0.00 sec)

mysql> INSERT INTO Project VALUES('MICROCONTROLLERS',31,'Patna',3);
Query OK, 1 row affected (0.12 sec)

mysql> INSERT INTO Project VALUES('CT',32,'Patna',4);
Query OK, 1 row affected (0.21 sec)

mysql> SELECT * FROM Project;
+------------------+---------+-----------+------+
| PNAME            | PNUMBER | PLOCATION | DNO  |
+------------------+---------+-----------+------+
| ML               |      27 | Patna     |    1 |
| DBMS             |      28 | Patna     |    1 |
| PM               |      29 | Patna     |    2 |
| BUSINESS COMM.   |      30 | Patna     |    2 |
| FLT              |      27 | Patna     |    1 |
| MICROCONTROLLERS |      31 | Patna     |    3 |
| CT               |      32 | Patna     |    4 |
+------------------+---------+-----------+------+
7 rows in set (0.00 sec)

mysql> UPDATE Project SET PNUMBER=33 WHERE PNAME='FLT';
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Project;
+------------------+---------+-----------+------+
| PNAME            | PNUMBER | PLOCATION | DNO  |
+------------------+---------+-----------+------+
| ML               |      27 | Patna     |    1 |
| DBMS             |      28 | Patna     |    1 |
| PM               |      29 | Patna     |    2 |
| BUSINESS COMM.   |      30 | Patna     |    2 |
| FLT              |      33 | Patna     |    1 |
| MICROCONTROLLERS |      31 | Patna     |    3 |
| CT               |      32 | Patna     |    4 |
+------------------+---------+-----------+------+
7 rows in set (0.00 sec)


                                    --1JUNE2021-

-- grant and revoke 
CREATE ROLE user1 WITH
    LOGIN
    SUPERUSER
    CREATEDB
    CREATEROLE
    INHERIT
    NOREPLICATION
    CONNECTION LIMIT -1;
    
ALTER DEFAULT PRIVILEGES
GRANT ALL ON TABLES TO user1;

ALTER DEFAULT PRIVILEGES
    REVOKE ALL ON TABLES FROM user1;

ALTER ROLE user1
    NOLOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE;

DROP USER user1;

--query1
SELECT * FROM Department
SELECT * FROM employee
SELECT COUNT(*) FROM employee WHERE DEPARTMENT = 'CSE';

--query2
SELECT department, AVG(salary), MAX(salary), MIN(salary)
FROM employee 
WHERE department = 'CSE' 
GROUP BY department;

SELECT department, AVG(salary), MAX(salary), MIN(salary)
FROM employee 
WHERE department = 'MANAGEMENT' 
GROUP BY department;

INSERT INTO Employee VALUES('try2','L','lki',426,'7 Jan 1996','London','M',10000,426,'CSE');
--query3
SELECT fname FROM Employee WHERE SALARY>9000 AND SALARY<15000;

--04-june-2021

SELECT * FROM employee
--q1
SELECT fname FROM Employee WHERE address LIKE 'L%' AND department = 'CSE';
--q2
SELECT fname FROM Employee WHERE FNAME LIKE '%v' AND department = 'MANAGEMENT';                          --SUPERSSN IN (SELECT SUPERSSN FROM Department WHERE DNAME='Management');

SELECT * FROM department

SELECT * FROM project
--q3
SELECT * FROM project WHERE NOT pnumber='1';

--q4
DO $$
DECLARE  
   myVar INT := 10000;   
BEGIN  
   UPDATE Employee SET Salary = (myVar) + Salary;
END $$;
SELECT * FROM employee
--q5
INSERT INTO Employee VALUES('JOHN','M','Carter',426,'7 Jan 1996','London','M',76000,426,426);
SELECT * FROM Employee WHERE FNAME LIKE '__HN%';

--q6


----------------------------08/06/2021------------------------------
--08/06/2021
                            
--q1
SELECT * FROM Employee WHERE FNAME LIKE '__HN%'ORDER BY fname desc;

--q2
DO $$
DECLARE  
   Var INT := 10000;   
BEGIN
SELECT fname AS NAME,salary, Salary = (Var) + Salary;
FROM employee GROUP BY salary; 
END $$;
SELECT * FROM employee

--q3
SELECT fname FROM Employee ORDER BY ssn desc;

--q4
SELECT * FROM employee
SELECT * FROM department
SELECT * FROM project

SELECT employee.fname , employee.ssn, project.name
FROM employee
INNER JOIN department ON employee.dno = department.dnumber
INNER JOIN project ON employee.dno = project.dno WHERE department.name = 'cse';

--q5

SELECT fname from employee WHERE address = 'London';



----------------------------11/06/2021------------------------------
SELECT * FROM employee
CREATE TABLE Empsal(
    FNAME varchar(20),
    MINIT varchar(1),
    LNAME varchar(20),
    SSN int,
    Eid int,
    SEX varchar(1),
    SALARY int,
    DNO int
);
INSERT INTO Empsal VALUES('hema','k','kislay',1,1,'M',80000,7);
INSERT INTO Empsal VALUES('anish','k','kislay',2,2,'M',80000,7);
INSERT INTO Empsal VALUES('shubho','k','kislay',4,4,'M',80000,7);

--q1
SELECT
    empsal.Fname,
    empsal.Eid
FROM
    empsal
INNER JOIN employee 
    ON employee.ssn = empsal.eid;
    
--q2
SELECT * FROM empsal
SELECT
    employee.Fname,
    employee.ssn
FROM
    employee
INNER JOIN empsal 
    ON NOT employee.ssn = empsal.eid;
    
--q3
CREATE TABLE student(NAME varchar(20), ID int, BOOK_ID varchar(10), PRICE int, FINE int);
INSERT INTO student VALUES('hema',1,101,400,500);
INSERT INTO student VALUES('anish',2,102,400,300);
INSERT INTO student VALUES('shubho',3,103,400,700); 

select * from student where fine > price;

--q4
SELECT fname,salary FROM Employee WHERE SALARY<50000 AND ADDRESS='London';

--q5

SELECT * FROM project
alter table project
add pcost int,ssn int;
INSERT INTO Project VALUES('try1',1,'Patna',1,100000,1);
INSERT INTO Project VALUES('try2',2,'Patna',7,40000,2);
INSERT INTO Project VALUES('try3',4,'Patna',1,500000,4);

SELECT
    *
FROM
    employee
INNER JOIN project 
    ON  employee.ssn = project.ssn
where pcost>100000;




-----------------------------------------------15-june-2021---------------------
--division dbms lap ppt eg.

create table COURSE_TAKEN(
Student_name VARCHAR(255),
Course VARCHAR(255)
);

create table COURSE_REQUIRED(
Course VARCHAR(255)
);

select * from COURSE_TAKEN

INSERT INTO COURSE_TAKEN VALUES('ROBERT','db');
INSERT INTO COURSE_TAKEN VALUES('ROBERT','plang');
INSERT INTO COURSE_TAKEN VALUES('david','db');
INSERT INTO COURSE_TAKEN VALUES('david','os');
INSERT INTO COURSE_TAKEN VALUES('hannah','plang');
INSERT INTO COURSE_TAKEN VALUES('hannah','ml');
INSERT INTO COURSE_TAKEN VALUES('tom','os');

select * from COURSE_REQUIRED

INSERT INTO COURSE_REQUIRED VALUES('db');
INSERT INTO COURSE_REQUIRED VALUES('PLANG');

CREATE TABLE AllStudents AS SELECT DISTINCT Student_name FROM COURSE_TAKEN;

select * from AllStudents

CREATE table StudentsAndRequired AS SELECT AllStudents.Student_name, COURSE_REQUIRED.Course FROM AllStudents, COURSE_REQUIRED;
select * from StudentsAndRequired


CREATE table StudentsAndNotTaken AS SELECT * FROM StudentsAndRequired WHERE NOT EXISTS (Select * FROM COURSE_TAKEN WHERE StudentsAndRequired.Student_name = COURSE_TAKEN.Student_name AND StudentsAndRequired.Course = COURSE_TAKEN.Course);
select * from StudentsAndNotTaken


CREATE table CannotGraduate AS SELECT DISTINCT Student_name FROM StudentsAndNotTaken;
select * from CannotGraduate;


CREATE Table CanGraduate AS SELECT * FROM AllStudents WHERE NOT EXISTS (SELECT * FROM CannotGraduate WHERE CannotGraduate.Student_name = AllStudents.Student_name);
select * from CanGraduate;

--SELECT DISTINCT x.Student_Name FROM Course_Taken AS x WHERE NOT EXISTS(SELECT * FROM Course_Required AS y WHERE NOT EXISTS(SELECT * FROM Course_Taken AS z WHERE z.Student_name = x.Student_name AND z.Course = y.Course ));



SELECT * FROM employee
SELECT * FROM empsal

SELECT DISTINCT Salary FROM employee ORDER BY Salary DESC LIMIT 1 OFFSET 3;

SELECT *
FROM employee Emp1
WHERE (4) = (
SELECT COUNT( DISTINCT ( Emp2.salary ) )
FROM employee Emp2
WHERE Emp2.salary >= Emp1.salary
)


------------------------------------18-june-2021----------------------------------------------------
create table salesman(eid int,name varchar(240),city varchar(240),commision int);

INSERT INTO salesman VALUES(1,'Thomas','Birmingham',3000);
INSERT INTO salesman VALUES(2,'John','Birmingham',3000);
INSERT INTO salesman VALUES(3,'Arthur','London',3000);
INSERT INTO salesman VALUES(4,'Polly','Paris',3000);
INSERT INTO salesman VALUES(5,'Michael','Texas',3000);
--q1
SELECT * FROM salesman;
--q2
SELECT 'This is SQL Exercise, Practice and Solution';
--q3
SELECT name,commision FROM salesman;
--q4
create table orders( ono int, amt int ,odate date, customer_id int,eid int);
 
INSERT INTO orders VALUES(1,25000,'2021-07-18',1,1);
INSERT INTO orders VALUES(2,25000,'2021-07-16',2,2);
INSERT INTO orders VALUES(3,25000,'2021-07-14',3,3);
INSERT INTO orders VALUES(4,25000,'2021-07-11',4,4);
INSERT INTO orders VALUES(5,25000,'2021-07-10',5,5);

SELECT  * FROM orders ORDER BY odate;
SELECT  * FROM orders ORDER BY eid;
SELECT  * FROM orders ORDER BY amt;
--q5
select eid,name,city,commision from salesman where eid in( select eid from orders);
--q6
SELECT name FROM salesman WHERE city='Paris';
--q7
create table customers( customer_id int, cname varchar(100),city varchar(100),grade varchar(50),eid int); 
INSERT INTO customers VALUES(1,'Billy Kimber','Birmingham','196',1);
INSERT INTO customers VALUES(2,'Mr.Batten','Texas','200',2);
INSERT INTO customers VALUES(3,'Charles','London','196',3);
INSERT INTO customers VALUES(4,'Changretta','Liverpool','200',4);
INSERT INTO customers VALUES(5,'ALfie Solomons','Texas','196',5);

SELECT * FROM customers WHERE grade='200';

--q8
SELECT ono, odate, amt FROM orders WHERE eid=1;







-- 30 june

CREATE TABLE empinfo(
    eid int not null,
    FNAME varchar(90),
    LNAME varchar(90),
    DEPT varchar(90),
    project varchar(90),
    ADDRESS varchar(90),
    dob varchar(90),
    gender varchar(10)
);

INSERT INTO empinfo VALUES(101,'tommy','shelby','Dev','p1','patna','20-05-2000','m');
INSERT INTO empinfo VALUES(102,'arthur','shelby','Dev','p2','patna','20-11-2000','m');
INSERT INTO empinfo VALUES(101,'john','shelby','Mng','p3','patna','12-05-2000','m');
INSERT INTO empinfo VALUES(101,'ada','shelby','Mng','p4','patna','12-05-2000','f');

CREATE TABLE emppos(
    eid int not null,
    emp_pos varchar(90),
    emp_join varchar(90),
    dofj varchar(90),
    salary int
);
select* from empinfo;
alter table emppos drop dofj;

INSERT INTO emppos VALUES(101,'sde','12-05-2000',10000);
INSERT INTO emppos VALUES(102,'sde','31-05-2000',20000);
INSERT INTO emppos VALUES(101,'gm','12-02-2000',40000);
INSERT INTO emppos VALUES(101,'cm','12-06-2000',60000);

--q1
select * from (select *, ntile(2) over(order by eid ) nt from empinfo) as T where nt=1);

--q2
SELECT  Salary FROM emppos ORDER BY Salary DESC LIMIT 1 OFFSET 2;

--q3
SELECT  * FROM empinfo  LIMIT 3 OFFSET 2;

--q4
SELECT *
FROM emppos Emp1
WHERE (4) = (
SELECT COUNT( DISTINCT ( Emp2.salary ) )
FROM emppos Emp2
WHERE Emp2.salary >= Emp1.salary
)

--q5
select distinct salary from emppos order by salary desc limit 2;

select distinct salary from emppos order by salary asc limit 2;


