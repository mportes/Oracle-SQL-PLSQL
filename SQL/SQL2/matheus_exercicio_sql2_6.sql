/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL2
-- Data: 17/10/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT last_name,
         department_id,
         salary
  FROM   employees
  WHERE  (department_id, salary) IN
         (SELECT department_id,
                 salary
          FROM   employees
          WHERE  commission_pct IS NOT NULL);

--b)

  SELECT e.last_name,
         d.department_name,
         e.salary
  FROM   employees e
  JOIN   departments d
  ON     e.department_id = d.department_id
  WHERE  (salary, job_id) IN
         (SELECT e.salary,
                 e.job_id
          FROM   employees e
          JOIN   departments d
          ON     e.department_id = d.department_id
          AND    d.location_id = 1700);

--c)

  SELECT last_name,
         hire_date,
         salary
  FROM   employees
  WHERE  (salary, manager_id) IN
         (SELECT salary,
                 manager_id
          FROM   employees
          WHERE  last_name = 'Kochhar')
  AND    last_name <> 'Kochhar';

--d)

  SELECT last_name,
         job_id,
         salary
  FROM   employees
  WHERE  salary > (SELECT MAX(salary)
                   FROM   employees
                   WHERE  job_id = 'SA_MAN')
  ORDER  BY salary DESC;

--e)

  SELECT employee_id,
         last_name,
         department_id
  FROM   employees
  WHERE  department_id IN (SELECT d.department_id
                           FROM   departments d
                           JOIN   locations l
                           ON     d.location_id = l.location_id
                           AND    INITCAP(l.city) LIKE 'T%');

--f)

  SELECT e.last_name ename,
         e.salary,
         s.department_id deptno,
         TO_CHAR(AVG(s.salary), 'fm999999D00') dept_avg
  FROM   employees e
  JOIN   employees s
  ON     e.department_id = s.department_id
  GROUP  BY s.department_id,
            e.last_name,
            e.salary
  HAVING e.salary > AVG(s.salary)
  ORDER  BY AVG(s.salary);

-- Usando subquery e WITH:

  WITH dept_avg_salary AS
   (SELECT AVG(salary) dept_avg,
           department_id
    FROM   employees
    GROUP  BY department_id)
  SELECT e.last_name     ename,
         e.salary,
         e.department_id deptno,
         d.dept_avg
  FROM   employees       e,
         dept_avg_salary d
  WHERE  e.salary > d.dept_avg
  AND    d.department_id = e.department_id;

--g)

  --i)

    SELECT e.last_name
    FROM   employees e
    WHERE  NOT EXISTS (SELECT 'X'
            FROM   employees s
            WHERE  s.manager_id = e.employee_id);

  --ii)

    SELECT last_name
    FROM   employees
    WHERE  employee_id NOT IN
           (SELECT DISTINCT manager_id
            FROM   employees
            WHERE  manager_id IS NOT NULL);
            
    /* 
      Basta excluir as tuplas com o manager_id nulo, visto que elas não são 
      importantes para a consulta e que o NOT IN "quebra" quando o encontra
      por não saber lidar corretamente com este tipo de dado.
    */

--h)

  SELECT e.last_name
  FROM   employees e
  WHERE  e.salary < (SELECT AVG(s.salary)
                     FROM   employees s
                     WHERE  e.department_id = s.department_id);

--i)

  SELECT e.last_name
  FROM   employees e
  WHERE  EXISTS (SELECT s.employee_id
          FROM   employees s
          WHERE  e.department_id = s.department_id
          AND    e.hire_date < s.hire_date
          AND    e.salary < s.salary);

--j)

  SELECT e.employee_id,
         e.last_name,
         (SELECT department_name
          FROM   departments
          WHERE  department_id = e.department_id) department
  FROM   employees E
  ORDER  BY department;

--k)

  WITH summary AS
   (SELECT SUM(salary) dept_total,
           department_id
    FROM   employees
    GROUP  BY department_id)
  SELECT d.department_name,
         s.dept_total
  FROM   departments d,
         summary     s
  WHERE  d.department_id = s.department_id
  AND    s.dept_total > (SELECT SUM(salary) / 8
                         FROM   employees)
  ORDER  BY department_name;
