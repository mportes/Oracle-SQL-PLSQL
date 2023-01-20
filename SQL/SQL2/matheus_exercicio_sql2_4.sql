/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL2
-- Data: 13/10/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

CREATE VIEW employees_vu AS
SELECT employee_id,
       last_name employee,
       department_id
FROM   employees;

--b)

SELECT *
FROM   employees_vu;

--c)

SELECT employee,
       department_id
FROM   employees_vu;

--d)

CREATE VIEW dept50 AS
  SELECT employee_id   empno,
         last_name     employee,
         department_id deptno
  FROM   employees
  WHERE  department_id = 50 WITH CHECK OPTION CONSTRAINT dept50vu_ck;

--e)

DESC dept50;

SELECT *
FROM   dept50;

--f)

UPDATE dept50
SET    deptno = 80
WHERE  LOWER(employee) = 'mikkilineni';

--g)

SELECT view_name,
       text
FROM   user_views;

--h)

DROP VIEW employees_vu;
DROP VIEW dept50;
