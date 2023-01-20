/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL2
-- Data: 14/10/2022
-- Tópico: 5
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE TABLE dept2
  (
    id NUMBER(7),
    name VARCHAR2(25)
  );

  DESC dept2;

--b)

INSERT INTO dept2
  SELECT department_id,
         department_name
  FROM   departments;

SELECT *
FROM   dept2;

--c)

CREATE TABLE emp2
(
  id NUMBER(7),
  last_name VARCHAR2(25),
  first_name VARCHAR2(25),
  dept_id NUMBER(7)
);

DESC emp2;

--d)

CREATE TABLE emp2
(
  id NUMBER(7),
  last_name VARCHAR2(25),
  first_name VARCHAR2(25),
  dept_id NUMBER(7),
  CONSTRAINT my_emp_id_pk PRIMARY KEY (id)
);

--e)


ALTER TABLE dept2 
ADD CONSTRAINT my_dept_id_pk 
PRIMARY KEY (id);

--f)

ALTER TABLE emp2 
ADD CONSTRAINT my_emp_dept_id_fk 
FOREIGN KEY (dept_id) 
REFERENCES dept2 (id);

--g)

ALTER TABLE emp2 ADD (commission NUMBER(2,2) CONSTRAINT commission_ck CHECK (commission > 0));

--h)

DROP TABLE emp2 PURGE;
DROP TABLE dept2 PURGE;
