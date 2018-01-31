CREATE TABLE COURSE 
(course_number int NOT NULL,
title varchar(20),
credits SMALLINT NOT NULL WITH DEFAULT 3,
price decimal(6,2) NOT null,
cstart date NOT NULL,
cend date NOT NULL,
period business_time(cstart,cend),
PRIMARY key(course_number, business_time WITHOUT overlaps));

INSERT INTO COURSE (course_number, title, credits, price, cstart, cend ) values (1, 'BD', 5, 300, '2017-01-01', '2017-06-01');
INSERT INTO COURSE (course_number, title, credits, price, cstart, cend ) values (2, 'BDA', 8, 800, '2017-06-01', '2017-12-01');
INSERT INTO COURSE (course_number, title, credits, price, cstart, cend ) values (3, 'C++', 6, 550, '2018-01-01', '2018-06-01');
INSERT INTO COURSE (course_number, title, credits, price, cstart, cend ) values (4, 'Meta Programming', 4, 380, '2018-03-01', '2018-06-01');



SELECT * FROM class FOR business_time AS OF '2017-05-01';

SELECT * FROM class FROM business_time FROM '2017-01-01' TO '2017-12-31';

UPDATE class FOR portion OF business_time FROM '2018-04-01' TO '2018-05-01' SET price = 200-00 WHERE course_number = 4;





-- SYSTEM TIME


CREATE TABLE course_sys
(course_number int PRIMARY KEY NOT NULL,
TITLE VARCHAR(20) NOT NULL,
CREDITS SMALLINT NOT NULL WITH DEFAULT 3,
PRICE DECIMAL(7,2) NOT NULL,
SYS_START TIMESTAMP(12) GENERATED ALWAYS AS ROW BEGIN NOT NULL,
SYS_END TIMESTAMP(12) GENERATED ALWAYS AS ROW END NOT NULL,
TRANS_START TIMESTAMP(12) GENERATED ALWAYS AS TRANSACTION START,
PERIOD SYSTEM_TIME(SYS_START, SYS_END));



CREATE TABLE COURSE_SYS_HISTORY LIKE course_sys


ALTER TABLE COURSE_SYS ADD versioning use HISTORY TABLE course_sys_history

INSERT INTO course_sys (COURSE_NUMBER, TITLE, CREDITS, PRICE)
VALUES (500, 'intro to sql', 2, 200.00)
INSERT INTO course_sys (COURSE_NUMBER, TITLE, CREDITS, PRICE)
VALUES (600, 'intro to ruby', 2, 250.00)
INSERT INTO course_sys (COURSE_NUMBER, TITLE, CREDITS, PRICE)
VALUES (650, 'advanced ruby', 3, 400.00)


