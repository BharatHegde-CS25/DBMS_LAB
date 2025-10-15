show databases;
use newdatabase;
create table person(driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
desc person;
create table car(reg_num varchar(10),
model varchar(10),
year int,
 primary key(reg_num));
desc car;
create table accident(report_num int,
accident_date date,
location varchar(20),
primary key(report_num));
desc accident;
create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
desc owns;
create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int,
damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc participated;
insert into person(driver_id,name,address)values('A01','Richard','srinivasnagar');
insert into person(driver_id,name,address)values('A02','pradeep','rajajinagar');
insert into person(driver_id,name,address)values('A03','smith','ashoknagar');
insert into person(driver_id,name,address)values('A04','venu','nrcolony');
insert into person(driver_id,name,address)values('A05','jhon','hanumanthnagara');
select * from person;
insert into car(reg_num,model,year)values('KA020120','INDICA','1990');
insert into car(reg_num,model,year)values('KA254565','LANCER','1985');
insert into car(reg_num,model,year)values('KA857436','TOYATA','1952');
insert into car(reg_num,model,year)values('KA875654','HONDA','2005');
insert into car(reg_num,model,year)values('KA857452','AUDI','2010');
select * from car;
insert into owns(driver_id,reg_num)values('A01','KA020120');
insert into owns(driver_id,reg_num)values('A02','KA254565');
insert into owns(driver_id,reg_num)values('A03','KA857436');
insert into owns(driver_id,reg_num)values('A04','KA875654');
insert into owns(driver_id,reg_num)values('A05','KA857452');
SELECT * FROM OWNS;

insert into accident values('11','2022-01-03','mysore road');
insert into accident values('12','2022-02-21','south end circle');
insert into accident values('13','2022-05-12','bull temple road');
insert into accident values('14','2022-06-09','mysore road');
insert into accident values('15','2022-09-03','kanakpura road');
SELECT * FROM accident;
insert into participated values('A01','KA020120','11','100000');
insert into participated values('A02','KA254565','12','200000');
insert into participated values('A03','KA857436','13','300000');
insert into participated values('A04','KA875654','14','400000');
insert into participated values('A05','KA857452','15','500000');
select * from participated;
insert into person values('&driver_id','&name','&address');
SELECT * FROM PERSON;
commit;
SELECT * FROM PERSON;
insert into accident values(16,'15-2-08','Domlur');
select * from accident;
select accident_date, location 
from accident;
select driver_id from participated
where damage_amount >=400000;
 
select * from car order by year asc;
select count(report_num) as accident_count from participated where reg_num in (select reg_num from car where model="HONDA");

select count(driver_id) as total_people from owns where reg_num in(select reg_num from participated where report_num in (select report_num from accident where year(accident_date)='2022-09-03'));
select * from  participated order by damage_amount desc;
select * from accident;
select avg(damage_amount) as avarage_damage from participated;
select* from participated;
delete from participated where damage_amount<(select avg(damage_amount) from accident);
SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID AND DAMAGE_AMOUNT > (SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATED);
select max(damage_amount) as max_damage from participated;