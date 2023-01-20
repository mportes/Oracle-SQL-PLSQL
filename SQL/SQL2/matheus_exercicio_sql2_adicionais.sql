/******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL2
-- Data: 25/10/2022
-- Tópico: Adicionais
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

CREATE TABLE sal_history
(
  employee_id NUMBER(6),
  hire_date   DATE,
  salary      NUMBER (8,2)
);

CREATE TABLE mgr_history
(
  employee_id NUMBER(6),
  manager_id  NUMBER(6),
  salary      NUMBER (8,2)
);

CREATE TABLE special_sal
(
  employee_id NUMBER(6),
  salary      NUMBER (8,2)
);

--a)

  INSERT ALL WHEN salary < 5000 THEN INTO special_sal
  VALUES
    (employee_id,
     salary) ELSE INTO sal_history
  VALUES
    (employee_id,
     hire_date,
     salary) INTO mgr_history
  VALUES
    (employee_id,
     manager_id,
     salary)
    SELECT employee_id,
           hire_date,
           salary,
           manager_id
    FROM   employees
    WHERE  employee_id >= 200;

--b)

  SELECT *
  FROM   special_sal;

  SELECT *
  FROM   sal_history;

  SELECT *
  FROM   mgr_history;

--c)

  CREATE TABLE locations_named_index
  (
    deptno NUMBER(4) PRIMARY KEY USING INDEX (CREATE INDEX locations_pk_idx ON locations_named_index(deptno)),
    dname VARCHAR2(30)
  );

--d)

  SELECT index_name, table_name
  FROM user_indexes
  WHERE index_name = 'LOCATIONS_PK_IDX';

--e)

  ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
  
--f)

  --i)

    SELECT TZ_OFFSET('AUSTRALIA/SYDNEY')
    FROM   dual;

    SELECT TZ_OFFSET('CHILE/EASTERISLAND')
    FROM   dual;

  --ii)

    ALTER SESSION SET TIME_ZONE = '+11:00';

  --iii)

    SELECT SYSDATE,
           CURRENT_DATE,
           CURRENT_TIMESTAMP,
           LOCALTIMESTAMP
    FROM   dual;

  --iv)

    ALTER SESSION SET TIME_ZONE = '-05:00';

  --v)

    SELECT SYSDATE,
           CURRENT_DATE,
           CURRENT_TIMESTAMP,
           LOCALTIMESTAMP
    FROM   dual;

  --vi)

    ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

--g)

  SELECT last_name,
         EXTRACT(MONTH FROM hire_date),
         hire_date
  FROM   employees
  WHERE  EXTRACT(MONTH FROM hire_date) = 1;

--h)

  SELECT last_name,
         salary
  FROM   employees e
  WHERE  salary = (SELECT salary
                   FROM   employees
                   WHERE  employee_id = e.employee_id)
  AND    ROWNUM <= 3
  ORDER  BY salary DESC;
  
  SELECT *
  FROM   (SELECT last_name,
                 salary
          FROM   employees
          ORDER  BY salary DESC)
  WHERE  ROWNUM <= 3;
  
  SELECT last_name,
         salary
  FROM   employees e
  ORDER  BY salary DESC
  FETCH  FIRST 3 ROWS ONLY;

--i)
  
  SELECT employee_id,
         last_name
  FROM   employees
  WHERE  department_id IN
         (SELECT department_id
          FROM   departments
          WHERE  location_id IN
                 (SELECT location_id
                  FROM   locations
                  WHERE  UPPER(state_province) = 'CALIFORNIA'));
                  
  SELECT e.employee_id, e.last_name 
  FROM   employees e 
  JOIN   departments d 
  ON     e.department_id = d.department_id 
  JOIN   locations l 
  ON     d.location_id = l.location_id 
  AND    UPPER(l.state_province) = 'CALIFORNIA';
  
  SELECT e.employee_id, e.last_name 
  FROM   employees e, departments d, locations l
  WHERE  e.department_id = d.department_id 
  AND    d.location_id = l.location_id 
  AND    UPPER(l.state_province) = 'CALIFORNIA';
  

--j)

  DELETE FROM job_history j
  WHERE  (j.employee_id, j.start_date) =
         (SELECT h.employee_id,
                 MIN(start_date)
          FROM   job_history h
          WHERE  j.employee_id = h.employee_id
          GROUP  BY employee_id
          HAVING COUNT(*) >= 2);

--k)
 
  ROLLBACK;

--l)

  WITH max_sal_calc AS
   (SELECT job_id,
           MAX(salary) job_total,
           (SELECT MAX(salary)
            FROM   employees) total
    FROM   employees
    GROUP  BY job_id)
  SELECT j.job_title,
         ms.job_total
  FROM   max_sal_calc ms,
         jobs         j
  WHERE  ms.job_id = j.job_id
  AND    ms.job_total > ms.total / 2
  ORDER  BY ms.job_total DESC;
