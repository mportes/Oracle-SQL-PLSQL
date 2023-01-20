/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 29/09/2022
-- Tópico: 3
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT last_name,
         salary
  FROM   employees
  WHERE  salary > 12000

--b)

  SELECT last_name,
         department_id
  FROM   employees
  WHERE  employee_id = 176;

--c)

  SELECT last_name,
         salary
  FROM   employees
  WHERE  salary NOT BETWEEN 5000 AND 12000;

--d)

  SELECT last_name,
         job_id,
         hire_date
  FROM   employees
  WHERE  last_name IN ('Matos', 'Taylor')
  ORDER  BY hire_date;

--e)

  SELECT last_name,
         department_id
  FROM   employees
  WHERE  department_id IN (20, 50)
  ORDER  BY last_name;

--f)

  SELECT last_name "Employee",
         salary    "Monthly Salary"
  FROM   employees
  WHERE  salary BETWEEN 5000 AND 12000
  AND    department_id IN (20, 50);

--g)

  SELECT last_name,
         hire_date
  FROM   employees
  WHERE  hire_date LIKE '%06';

--h)

  SELECT last_name,
         job_id
  FROM   employees
  WHERE  manager_id IS NULL;

--i)

  SELECT last_name,
         salary,
         commission_pct
  FROM   employees
  WHERE  commission_pct IS NOT NULL
  ORDER  BY 2 DESC,
            3 DESC;

--j)

  SELECT last_name,
         salary
  FROM   employees
  WHERE  salary > &min_salary;

--k)

  SELECT employee_id,
         last_name,
         salary,
         department_id
  FROM   employees
  WHERE  manager_id = &manager_id
  ORDER  BY &order_column;

--l)

SELECT last_name
FROM   employees
WHERE  last_name LIKE '__a%';

--m)

  SELECT last_name
  FROM   employees
  WHERE  last_name LIKE '%a%e%';

--n)

  SELECT last_name,
         job_id,
         salary
  FROM   employees
  WHERE  job_id IN ('SA_REP', 'ST_CLERK')
  AND    salary NOT IN (2500, 3500, 7000);

--o)

  SELECT last_name      "Employee",
         salary         "Monthly Salary",
         commission_pct
  FROM   employees
  WHERE  commission_pct = 0.2;
