/*
******************************Exerc�cios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- M�dulo: SQL1 
-- Data: 27/09/2022
-- T�pico: 2
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exerc�cio 1*/

-- a, b) True

/*c) 1- falta uma v�rgula durante a listagem das colunas da consulta; 
     2- coluna tabela est� referenciada de forma errada ou n�o declarada
     ('sal' em vez de 'salary'); 3- a opera��o de multiplica��o est� usando
     um operador n�o existente e, portanto, errado ('x' em vez de '*');
     4- o alias tem um espa�o, mas n�o est� entre aspas, n�o sendo reconhecido
     dessa forma. */

  SELECT employee_id,
         last_name,
         salary * 12 "ANNUAL SALARY"
  FROM   employees;

/*Exerc�cio 2*/

--a)

  DESC departments;

  SELECT *
  FROM   departments;

--b)

  --i)

    DESC employees;

  --ii)

    SELECT employee_id,
           last_name,
           job_id,
           hire_date startdate
    FROM   employees;

--c)

  SELECT DISTINCT job_id
  FROM   employees;

/*Exerc�cio 3*/

--a)

  SELECT employee_id "Emp #",
         last_name   "Employee",
         job_id      "Job",
         hire_date   "Hire Date"
  FROM   employees;

--b)

  SELECT last_name || ', ' || job_id "Employee and Title"
  FROM   employees;

--c)

  SELECT employee_id || ',' || first_name || ',' || last_name || ',' ||
         email || ',' || phone_number || ',' || job_id || ',' || manager_id || ',' ||
         hire_date || ',' || salary || ',' || commission_pct || ',' ||
         department_id the_output
  FROM   employees;
