/*
******************************Exerc�cios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- M�dulo: SQL1 
-- Data: 30/09/2022
-- T�pico: 5
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exerc�cio 1*/

--a)

  SELECT last_name || ' earns ' || TO_CHAR(salary, 'fm$999,990.00') ||
         ' monthly but wants ' || TO_CHAR(salary * 3, 'fm$9,999,990.00') || '.' "Dream Salaries"
  FROM   employees;

--b)

  SELECT last_name,
         hire_date,
         TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'MONDAY'),
                 'fmDay, "the" Ddspth "of" Month, YYYY') review
  FROM   employees;

--c)

  SELECT last_name,
         NVL(TO_CHAR(commission_pct), 'No commission') comm
  FROM   employees;

--d)

  SELECT job_id,
         DECODE(job_id,
                'AD_PRES',
                'A',
                'ST_MAN',
                'B',
                'IT_PROG',
                'C',
                'SA_REP',
                'D',
                'ST_CLERK',
                'E',
                0) grade
  FROM   employees;

--e)

  SELECT job_id,
         (CASE job_id
           WHEN 'AD_PRES' THEN
            'A'
           WHEN 'ST_MAN' THEN
            'B'
           WHEN 'IT_PROG' THEN
            'C'
           WHEN 'SA_REP' THEN
            'D'
           WHEN 'ST_CLERK' THEN
            'E'
           ELSE
            '0'
         END) grade
  FROM   employees;
