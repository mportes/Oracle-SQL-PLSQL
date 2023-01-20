/*
******************************Exerc�cios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- M�dulo: SQL2
-- Data: 17/10/2022
-- T�pico: 8
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exerc�cio 1*/

--a) CREATE SESSION, system privilege.

--b) CREATE TABLE.

--c) Quem teve o privil�gio concedido com a cl�usula WITH GRANT OPTION.

--d) Criar roles.

--e) ALTER USER user IDENTIFIED BY new_password.

--f) Apenas o User21.

--g)

  GRANT update
  ON    departments
  TO    scott
  WITH  GRANT OPTION;

--h)

  --i)

    GRANT select
    ON    regions
    TO    jsobrals
    WITH  GRANT OPTION;

  --ii) Feito por usu�rio.
  
    SELECT *
    FROM   regions;
    
  --iii) Feito por usu�rio
  
    GRANT select
    ON    regions
    TO    gabriel;
  
  --iv)
    
    REVOKE select
    ON     regions
    FROM   jsobral;
  
--i)

  GRANT select, 
        update,
        insert,
        delete
  ON    countries 
  TO    jsobrals;

--j)

  REVOKE select, 
         update,
         insert,
         delete
  ON     countries 
  FROM   jsobrals;
  
--k)

  GRANT select
  ON    departments
  TO    jsobrals;
  
  GRANT select
  ON    departments
  TO    msplima;
  
--l)

  SELECT *
  FROM   departments;

--m)

  INSERT INTO departments VALUES (500, 'Education', NULL, NULL);
  
  SELECT *
  FROM   jsobral.department;
  
  INSERT INTO departments VALUES (510, 'Human Resources', NULL, NULL);
  
  SELECT *
  FROM   jsobral.department
  WHERE  department_id = 510;

--n)

  CREATE SYNONYM depts FOR jsobral.departments;
  
  CREATE SYNONYM depts FOR msplima.departments;

--o)

  SELECT * FROM depts;
  
--p)

  REVOKE select
  ON     departments
  FROM   jsobrals;
  
  REVOKE select
  ON     departments
  FROM   msplima;
  
--q)

  DELETE FROM departments WHERE department_id = 500;
  DELETE FROM departments WHERE department_id = 510;
  
--r)

  DROP SYNONYM depts;
