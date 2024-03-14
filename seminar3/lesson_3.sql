create database lesson_3;
use lesson_3
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(45),
    lastname VARCHAR(45),
    post VARCHAR(45),
    seniority INT,
    salary INT,
    age INT);
    
    
-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 19),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);


-- Выведите все записи, отсортированные по полю "age" по возрастанию
SELECT * FROM staff ORDER BY age;
SELECT * FROM staff ORDER BY id,post;

-- Выведите все записи, отсортированные по полю “firstname"
SELECT * FROM staff ORDER BY firstname;

-- Выведите записи полей "firstname ", “lastname", "age", 
-- отсортированные по полю "firstname " в алфавитном порядке по убыванию
SELECT firstname, lastname, age FROM staff ORDER BY firstname DESC;

-- Выполните сортировку по полям " firstname " и "age" по убыванию
SELECT * FROM staff ORDER BY firstname DESC, age DESC;

-- Выведите уникальные (неповторяющиеся) значения полей "firstname"
SELECT DISTINCT firstname FROM staff;

-- Отсортируйте записи по возрастанию значений поля "id". 
-- Выведите первые   две записи данной выборки
SELECT * FROM staff ORDER BY id LIMIT 2;


-- Отсортируйте записи по возрастанию значений поля "id". 
-- Пропустите первые 4 строки данной выборки и извлеките следующие 3
SELECT * FROM staff ORDER BY id LIMIT 4,3;
SELECT * FROM staff ORDER BY id LIMIT 3 OFFSET 4;

-- Отсортируйте записи по убыванию поля "id". 
-- Пропустите две строки данной выборки и извлеките следующие за ними 3 строки
SELECT * FROM staff ORDER BY id LIMIT 3 offset 2;

-- Найдите количество сотрудников с должностью «Рабочий» 
SELECT * FROM staff WHERE post LIKE 'Рабочий';

-- Посчитайте ежемесячную зарплату начальников
SELECT SUM(salary) FROM staff WHERE post LIKE 'Начальник';

-- Выведите средний возраст сотрудников, у которых заработная плата больше 30000
SELECT AVG(age) AS 'Средний возраст' FROM staff WHERE salary > 30000;
-- SELECT SUM(age) / COUNT(*) FROM staff WHERE salary > 30000;

-- Выведите максимальную и минимальную заработные платы
SELECT MAX(salary), MIN(salary) FROM staff;

-- Работа персонала
DROP TABLE IF EXISTS activity_staff;
CREATE TABLE activity_staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	staff_id INT NOT NULL,
	date_activity DATE,
	count_pages INT,
	FOREIGN KEY (staff_id) REFERENCES staff (id) ON DELETE CASCADE ON UPDATE CASCADE  
);

-- Наполнение данными
INSERT INTO activity_staff (staff_id, date_activity, count_pages)
VALUES
(1, '2022-01-01', 250),
(2, '2022-01-01', 220),
(3, '2022-01-01', 170),
(1, '2022-01-02', 100),
(2, '2022-01-02', 220),
(3, '2022-01-02', 300),
(7, '2022-01-02', 350),
(1, '2022-01-03', 168),
(2, '2022-01-03', 62),
(3, '2022-01-03', 84);

-- Выведите общее количество напечатанных страниц каждым сотрудником
SELECT staff_id, SUM(count_pages) FROM activity_staff GROUP BY staff_id;

-- Посчитайте количество страниц за каждый день
SELECT date_activity, staff_id, SUM(count_pages) FROM activity_staff GROUP BY date_activity, staff_id;

-- Найдите среднее арифметическое по количеству страниц, напечатанных сотрудниками за каждый день
SELECT staff_id, AVG(count_pages) FROM activity_staff GROUP BY staff_id;

-- Сгруппируйте данные о сотрудниках по возрасту: 
-- 1 группа – младше 20 лет
-- 2 группа – от 20 до 40 лет
-- 3 группа – старше  40 лет 
-- Для каждой группы  найдите суммарную зарплату

SELECT SUM(salary),  
CASE 
 WHEN age < 20 THEN '1 группа'
 WHEN age < 40 THEN '2 группа'
 WHEN age >= 40 THEN '3 группа'
 ELSE 'неопределено'
 END
 AS age_group
 FROM staff GROUP BY age_group;
 
 
 -- Выведите id сотрудников, которые напечатали более 500 страниц за все дни
 -- activity_staff (staff_id, date_activity, count_pages)
 SELECT staff_id, SUM(count_pages) as summ_pages FROM activity_staff GROUP BY staff_id HAVING summ_pages > 500;
 
 -- Выведите  дни, когда работало более 3 сотрудников 
 -- Также укажите кол-во сотрудников, которые работали в выбранные дни.
 SELECT date_activity, GROUP_CONCAT(staff_id) FROM activity_staff GROUP BY date_activity HAVING COUNT(*) > 3;
 
 -- Выведите должности, у которых средняя заработная плата составляет более 30000
 SELECT post, GROUP_CONCAT(lastname) FROM staff GROUP BY post HAVING AVG(salary) > 30000;

SELECT id, firstname, lastname, salary FROM staff ORDER BY salary;

SELECT COUNT(*)
FROM staff
WHERE post = 'Рабочий' AND (age BETWEEN 24 AND 49);