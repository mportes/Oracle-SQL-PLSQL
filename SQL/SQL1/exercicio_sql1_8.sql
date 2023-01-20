/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 06/10/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a)

    SELECT e.last_name,
           e.hire_date
    FROM   employees e
    WHERE  LOWER(e.last_name) <> LOWER('&enter_name')
    AND    e.department_id =
           (SELECT department_id
             FROM   employees c
             WHERE  LOWER(c.last_name) = LOWER('&enter_name'));

  --b)

    SELECT employee_id,
           last_name,
           salary
    FROM   employees e
    WHERE  salary > (SELECT AVG(salary)
                     FROM   employees)
    ORDER  BY salary;

  --c)

    SELECT employee_id,
           last_name
    FROM   employees
    WHERE  department_id IN (SELECT department_id
                             FROM   employees
                             WHERE  last_name LIKE '%u%');

  --d)

    SELECT last_name,
           department_id,
           job_id
    FROM   employees
    WHERE  department_id IN (SELECT department_id
                             FROM   departments d
                             WHERE  location_id = 1700);
                             
    ---------------------------------------------------------
    
    SELECT last_name,
           department_id,
           job_id
    FROM   employees
    WHERE  department_id IN (SELECT department_id
                             FROM   departments d
                             WHERE  location_id = &location_id);

  --e)

    SELECT last_name,
           salary
    FROM   employees
    WHERE  manager_id IN (SELECT employee_id
                          FROM   employees
                          WHERE  last_name = 'King');

  --f) 

    SELECT department_id,
           last_name,
           job_id
    FROM   employees
    WHERE  department_id =
           (SELECT department_id
            FROM   departments
            WHERE  department_name = 'Executive');

  --g)

    SELECT last_name
    FROM   employees
    WHERE  salary > ANY (SELECT salary
            FROM   employees
            WHERE  department_id = 60);

  --h)

    SELECT employee_id,
           last_name,
           salary
    FROM   employees
    WHERE  salary > (SELECT AVG(salary)
                     FROM   employees)
    AND    department_id IN (SELECT department_id
                             FROM   employees
                             WHERE  last_name LIKE '%u%');
