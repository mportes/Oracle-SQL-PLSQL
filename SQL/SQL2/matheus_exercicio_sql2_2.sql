/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL2
-- Data: 10/10/2022
-- Tópico: 2
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

SELECT table_name
FROM   user_tables;

--b)

SELECT table_name,
       owner
FROM   all_tables
WHERE  UPPER(owner) <> 'MSPLIMA';

--c)

SELECT column_name,
       data_type,
       data_length,
       data_precision PRECISION,
       data_scale     scale,
       nullable
FROM   user_tab_columns
WHERE  table_name = UPPER('&table_name');

--d)

SELECT cc.column_name,
       constraint_name,
       uc.constraint_type,
       uc.search_condition,
       uc.status
FROM   user_constraints uc
JOIN   user_cons_columns cc
USING  (constraint_name)
WHERE  uc.table_name = UPPER('&table_name');

--e)

COMMENT ON TABLE departments IS 'Company department information including name, code, and location';

SELECT comments
FROM   user_tab_comments
WHERE  table_name = 'DEPARTMENTS';

--f)

CREATE TABLE dept2(department_id NUMBER(4) CONSTRAINT my_dept_id_pk
                   PRIMARY KEY,
                   department_name VARCHAR2(30) NOT NULL,
                   manager_id NUMBER(6),
                   location_id NUMBER(4));

CREATE TABLE emp2(employee_id NUMBER(6) CONSTRAINT my_emp_id_pk PRIMARY KEY,
                  first_name VARCHAR2(20),
                  last_name VARCHAR(25) NOT NULL,
                  email VARCHAR(25) NOT NULL,
                  phone_number VARCHAR(20),
                  hire_date DATE NOT NULL,
                  job_id VARCHAR(10) NOT NULL,
                  salary NUMBER(8, 2),
                  commission_pct NUMBER(2, 2),
                  manager_id NUMBER(6),
                  department_id NUMBER(4) CONSTRAINT my_emp_dept_id_fk
                  REFERENCES dept2(department_id));

--g)

SELECT table_name
FROM   tabs
WHERE  table_name IN ('DEPT2', 'EMP2');

--h)

SELECT constraint_name,
       constraint_type
FROM   user_constraints
WHERE  table_name IN ('DEPT2', 'EMP2')
AND    constraint_type IN ('P', 'R');

--i)

SELECT object_name,
       object_type
FROM   user_objects
WHERE  object_name IN ('DEPT2', 'EMP2');
