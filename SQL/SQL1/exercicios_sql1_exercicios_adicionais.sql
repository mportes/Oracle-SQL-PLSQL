/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 10/10/2022
-- Tópico: Exercícios Adicionais
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  SELECT *
  FROM   employees
  WHERE  TO_CHAR(hire_date, 'YYYY') > 1997
  AND    UPPER(job_id) LIKE '%CLERK%';

--b)

  SELECT last_name,
         job_id,
         salary,
         commission_pct
  FROM   employees
  WHERE  commission_pct IS NOT NULL
  ORDER  BY salary DESC;

--c)

  SELECT 'The salary of ' || last_name || ' after a 10% raise is ' ||
         ROUND(salary * 1.1) "Newsalary"
  FROM   employees
  WHERE  commission_pct IS NULL;

--d)

  SELECT last_name,
         TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) years,
         TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hire_date), 12)) months
  FROM   employees
  --ORDER BY hire_date
  ORDER BY years DESC, months DESC;

--e)

  SELECT last_name
  FROM   employees
  WHERE  UPPER(SUBSTR(last_name, 1, 1)) IN ('J', 'K', 'L', 'M');

--f)

  SELECT last_name,
         salary,
         DECODE(commission_pct, NULL, 'No', 'Yes') commission
  FROM   employees;

--g)

  SELECT d.department_name,
         d.location_id,
         e.last_name,
         e.job_id,
         e.salary
  FROM   employees e
  JOIN   departments d
  USING  (department_id)
  WHERE  d.location_id = &location_id;

--h)

  SELECT COUNT(*)
  FROM   employees
  WHERE  LOWER(last_name) LIKE '%n';

  SELECT COUNT(*)
  FROM   employees
  WHERE  LOWER(SUBSTR(last_name, -1, 1)) = 'n';

--i)

  SELECT d.department_id,
         d.department_name,
         d.location_id,
         COUNT(e.employee_id)
  FROM   employees e
  RIGHT  OUTER JOIN departments d
  ON     d.department_id = e.department_id
  GROUP  BY d.department_id,
            d.department_name,
            d.location_id;

--j)

  SELECT DISTINCT job_id
  FROM   employees
  WHERE  department_id IN (10, 20);

--k)

  SELECT job_id,
         COUNT(*) frequency
  FROM   employees
  JOIN   departments
  USING  (department_id)
  WHERE  department_name IN ('Administration', 'Executive')
  GROUP  BY job_id
  ORDER  BY 2 DESC;

--l)

  SELECT last_name,
         hire_date
  FROM   employees
  WHERE  TO_CHAR(hire_date, 'DD') < 16;

--m)

  SELECT last_name,
         salary,
         TRUNC(salary / 1000)
  FROM   employees;

--n)

  SELECT e.last_name,
         m.last_name manager,
         m.salary,
         j.grade_level
  FROM   employees e
  JOIN   employees m
  ON     e.manager_id = m.employee_id
  JOIN   job_grades j
  ON     m.salary BETWEEN j.lowest_sal AND highest_sal
  WHERE  m.salary > 15000;

--o)
  
  SELECT d.department_id,
         d.department_name,
         COUNT(ee.employee_id) employees,
         NVL(TO_CHAR(AVG(ee.salary), 'fm999999D00'), 'No average') avg_sal,
         e.last_name,
         TO_CHAR(e.salary, 'fm999999') salary,
         e.job_id
  FROM   employees e
  LEFT   OUTER JOIN employees ee
  ON     e.department_id = ee.department_id
  LEFT  OUTER JOIN departments d
  ON     ee.department_id = d.department_id
  GROUP  BY d.department_id,
            d.department_name,
            e.last_name,
            e.salary,
            e.job_id
  ORDER  BY d.department_id;

--p) Não consegui com o JOIN

  SELECT department_id,
         MIN(e.salary)
  FROM   employees e
  HAVING AVG(salary) = (SELECT MAX(AVG(salary))
                        FROM   employees e
                        GROUP  BY department_id)
  GROUP  BY department_id;
  
--q)

  SELECT department_id,
         d.department_name,
         d.manager_id,
         d.location_id
  FROM   departments d
  MINUS
  SELECT DISTINCT department_id,
                  d.department_name,
                  d.manager_id,
                  d.location_id
  FROM   departments d
  JOIN   employees e
  USING  (department_id)
  WHERE  job_id = 'SA_REP';

--r)

  --i)

    SELECT department_id,
           d.department_name,
           COUNT(*)
    FROM   employees e
    JOIN   departments d
    USING  (department_id)
    HAVING COUNT(*) < 3
    GROUP  BY department_id,
              department_name;

  --ii) Não consegui com o JOIN

    SELECT department_id,
           d.department_name,
           COUNT(*)
    FROM   employees e
    JOIN   departments d
    USING  (department_id)
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM   employees e
                       GROUP  BY department_id)
    GROUP  BY department_id,
              department_name;

  --iii) Não consegui com o JOIN

    SELECT department_id,
           d.department_name,
           COUNT(*)
    FROM   employees e
    JOIN   departments d
    USING  (department_id)
    HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                       FROM   employees e
                       JOIN   departments d
                       USING  (department_id)
                       GROUP  BY department_id)
    GROUP  BY department_id,
              department_name;

--s)
  
  SELECT e.employee_id,
         e.last_name,
         e.department_id,
         e.salary,
         AVG(s.salary)
  FROM   employees e
  JOIN   employees s
  ON     e.department_id = s.department_id
  GROUP  BY s.department_id,
            e.employee_id,
            e.last_name,
            e.department_id,
            e.salary;

--t)

  SELECT last_name,
         RPAD(TO_CHAR(hire_date, 'Month'), 10, ' ') ||
         TO_CHAR(hire_date, 'DD') birthday
  FROM   employees
  ORDER  BY TO_NUMBER(TO_CHAR(hire_date, 'MM')),
            TO_NUMBER(TO_CHAR(hire_date, 'DD'));
