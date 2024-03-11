create database lesson_1;
use lesson_1;
create table students(
	id int auto_increment not null primary key,
    name_student varchar(45) not null,
    email varchar(45) not null,
    phone bigint unsigned);
create table teachers(
	id int auto_increment not null primary key,
    name_teacher varchar(45) not null,
    post varchar(45) not null);
create table courses{
	id int auto_increment not null primary key,
    name_courses varchar(45) not null,
    id_student int not null,
    id_teacher int not null,
    foreign key (id_student) references students (id),
    foreign key (id_teacher) references teachers (id)};
INSERT INTO students (name_student, email, phone)
VALUES 
('Миша', 'misha@mail.ru', 9876543221),
('Антон', 'anton@mail.ru', 9876543222),
('Маша', 'masha@mail.ru', 9876543223),
('Паша', 'pasha@mail.ru', 9876543224);	
INSERT INTO teachers (name_teacher, post)
VALUES 
('Иванов И.И.', 'Профессор'),
('Петров П.П.', 'Преподаватель'),
('Сидоров С.С.', 'Доцент');
SELECT * FROM students;
SELECT * FROM teachers;
drop table workers;
create table workers(
	id int auto_increment not null primary key,
    name_worker varchar(45) not null,
    dept varchar(45) not null,
    salary int not null);
INSERT INTO workers (id, name_worker, dept, salary)
VALUES 
(100, 'AndreyEx', 'Sales', 5000),
(200, 'Boris', 'IT', 5500),
(300, 'Anna', 'IT', 7000),
(400, 'Anton', 'Marketing', 9500),
(500, 'Dima', 'IT', 6000),
(501, 'Maxs', 'Accounting', 6543);
alter table courses 
add foreign key (id_student) references students (id);
alter table courses
add foreign key (id_teacher) references teachers (id);
SELECT name_worker, salary FROM workers WHERE salary > 6000;
SELECT name_worker, dept
FROM workers
WHERE dept NOT LIKE 'IT'
