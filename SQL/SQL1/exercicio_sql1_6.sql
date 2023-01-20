/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 03/10/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a) True

  --b) False 

  --c) True

  --d)
  
    SELECT ROUND(MAX(salary)) "Maximum",
           ROUND(MIN(salary)) "Minimum",
           ROUND(SUM(salary)) "Sum",
           ROUND(AVG(salary)) "Average"
    FROM   employees;
    
  --e)
  
    SELECT job_id,
           ROUND(MAX(salary)) "Maximum",
           ROUND(MIN(salary)) "Minimum",
           ROUND(SUM(salary)) "Sum",
           ROUND(AVG(salary)) "Average"
    FROM   employees
    GROUP  BY job_id;
    
  --f)
  
    SELECT job_id,
           COUNT(*)
    FROM   employees
    GROUP  BY job_id;
    
    
    --Fiz com o upper pra ficar mais flexível, mas sei que não estava no enunciado
    SELECT job_id,
           COUNT(*)
    FROM   employees
    WHERE  UPPER(job_id) = UPPER('&job_id')
    GROUP  BY job_id;
  
  --g)
  
    SELECT COUNT(DISTINCT manager_id) "Number of Managers"
    FROM   employees;
  
  --h)
  
    SELECT MAX(salary) - MIN(salary) difference
    FROM   employees;
    
  --i)
  
    SELECT manager_id,
           MIN(salary)
    FROM   employees
    WHERE  manager_id IS NOT NULL
    GROUP  BY manager_id
    HAVING MIN(salary) > 6000
    ORDER  BY 2 DESC;

  --j)
  
    SELECT COUNT(*) total,
           COUNT(CASE TO_CHAR(hire_date, 'YYYY')
                   WHEN '2005' THEN
                    employee_id
                 END) "2005",
           COUNT(CASE TO_CHAR(hire_date, 'YYYY')
                   WHEN '2006' THEN
                    employee_id
                 END) "2006",
           COUNT(CASE TO_CHAR(hire_date, 'YYYY')
                   WHEN '2007' THEN
                    employee_id
                 END) "2007",
           COUNT(CASE TO_CHAR(hire_date, 'YYYY')
                   WHEN '2008' THEN
                    employee_id
                 END) "2008"
    FROM   employees;
  
  --k)
  
    SELECT job_id "Job",
           SUM(DECODE(department_id, 20, salary)) "Dept 20",
           SUM(DECODE(department_id, 50, salary)) "Dept 50",
           SUM(DECODE(department_id, 80, salary)) "Dept 80",
           SUM(DECODE(department_id, 90, salary)) "Dept 90",
           SUM(salary) "Total"
    FROM   employees
    GROUP  BY job_id
