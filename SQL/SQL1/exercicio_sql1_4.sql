/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 29/09/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a) 

  SELECT SYSDATE "Date"
  FROM   dual;

--b, c)

  SELECT employee_id,
         last_name,
         salary,
         ROUND(salary * 1.155) "New Salary"
  FROM   employees;

--d)

  SELECT employee_id,
         last_name,
         salary,
         ROUND(salary * 1.155) "New Salary",
         ROUND(salary * 1.155) - salary "Increase"
  FROM   employees;

--e)

  --i)
  
    SELECT INITCAP(last_name) "Name",
           LENGTH(last_name) "Length"
    FROM   employees
    WHERE  SUBSTR(last_name, 1, 1) IN ('M', 'A', 'J')
    ORDER BY last_name;

  --ii)
  
    SELECT INITCAP(last_name) "Name",
           LENGTH(last_name) "Length"
    FROM   employees
    WHERE  SUBSTR(last_name, 1, 1) = '&first_letter'
    ORDER BY last_name;

  --iii)
  
    SELECT INITCAP(last_name) "Name",
           LENGTH(last_name) "Length"
    FROM   employees
    WHERE  UPPER(SUBSTR(last_name, 1, 1)) = UPPER('&first_letter')
    ORDER BY last_name;

--f)

  SELECT last_name,
         ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) months_worked
  FROM   employees
  ORDER  BY months_worked;

--g)

  SELECT last_name,
         LPAD(salary, 15, '$') SALARY
  FROM   employees;

--h)

  SELECT RPAD(RPAD(SUBSTR(last_name, 1, 8), 9, ' '),
              TRUNC(salary / 1000) + 9,
              '*') employees_and_their_salaries
  FROM   employees
  ORDER  BY salary DESC;

--i)

  SELECT last_name,
         TRUNC((SYSDATE - hire_date) / 7) tenure
  FROM   employees
  WHERE department_id = 90
  ORDER  BY tenure DESC;
