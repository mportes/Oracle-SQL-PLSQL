/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1 
-- Data: 17/11/2022
-- Tópico: 9
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  CREATE TABLE messages
  (
    results VARCHAR2(255)
  );

--b, c, d, e, f)

  DECLARE
    v_ename   employees.last_name%TYPE;
    v_emp_sal employees.salary%TYPE := 6000;
  BEGIN
    SELECT last_name
    INTO   v_ename
    FROM   employees
    WHERE  salary = v_emp_sal;
    INSERT INTO messages
    VALUES
      (v_ename || ' has a salary of ' || v_emp_sal);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO messages
      VALUES
        ('No employee with a salary of ' || v_emp_sal);
    WHEN TOO_MANY_ROWS THEN
      INSERT INTO messages
      VALUES
        ('More than one employee with a salary of ' || v_emp_sal);
    WHEN OTHERS THEN
      INSERT INTO messages
      VALUES
        ('Some other error ocurred.');
  END;
  /

--g)

  SELECT *
  FROM   messages;

--h)

  DECLARE
    v_ename   employees.last_name%TYPE;
    v_emp_sal employees.salary%TYPE := 2000;
  BEGIN
    SELECT last_name
    INTO   v_ename
    FROM   employees
    WHERE  salary = v_emp_sal;
    INSERT INTO messages
    VALUES
      (v_ename || ' has a salary of ' || v_emp_sal);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO messages
      VALUES
        ('No employee with a salary of ' || v_emp_sal);
    WHEN TOO_MANY_ROWS THEN
      INSERT INTO messages
      VALUES
        ('More than one employee with a salary of ' || v_emp_sal);
    WHEN OTHERS THEN
      INSERT INTO messages
      VALUES
        ('Some other error ocurred.');
  END;
  /

  SELECT *
  FROM   messages;

/*Exercício 2*/

  DECLARE
    e_childrecord_exists EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_childrecord_exists, -02292);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Deleting department 40........');
    DELETE FROM departments
    WHERE  department_id = 40;
  EXCEPTION
    WHEN e_childrecord_exists THEN
      DBMS_OUTPUT.PUT_LINE('Cannot delete this department. There are employees in this department (child records exist.)');
  END;
  /
