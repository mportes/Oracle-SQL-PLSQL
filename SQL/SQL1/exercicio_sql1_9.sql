/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 06/10/2022
-- Tópico: 9
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT department_id
  FROM   departments
  MINUS
  SELECT department_id
  FROM   employees
  WHERE  job_id = 'ST_CLERK';

--b)

  SELECT country_id,
         country_name
  FROM   countries
  MINUS
  SELECT DISTINCT country_id,
                  c.country_name
  FROM   departments
  JOIN   locations
  USING  (location_id)
  JOIN   countries c
  USING  (country_id);

--c)

  SELECT job_id,
         department_id
  FROM   (SELECT DISTINCT job_id,
                          department_id,
                          1 rows_order
          FROM   employees
          WHERE  department_id = 10
          UNION
          SELECT DISTINCT job_id,
                          department_id,
                          2 rows_order
          FROM   employees
          WHERE  department_id = 50
          UNION
          SELECT DISTINCT job_id,
                          department_id,
                          3 rows_order
          FROM   employees
          WHERE  department_id = 20)
  ORDER  BY rows_order;
 
  -------------------------------------------------------
 
  SELECT DISTINCT job_id, department_id
  FROM employees
  WHERE department_id = 10
  UNION ALL
  SELECT DISTINCT job_id, department_id
  FROM employees
  WHERE department_id = 50
  UNION ALL
  SELECT DISTINCT job_id, department_id
  FROM employees
  WHERE department_id = 20;

--d)

  SELECT employee_id,
         job_id
  FROM   employees
  INTERSECT
  SELECT employee_id,
         job_id
  FROM   job_history;

--e)

  SELECT last_name,
         department_id,
         TO_CHAR(NULL) dept_name
  FROM   employees
  UNION
  SELECT TO_CHAR(NULL),
         department_id,
         department_name
  FROM   departments;

  SELECT *
  FROM   employees;
  SELECT *
  FROM   departments;
