/*
***************************Exerc�cios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- M�dulo: PLSQL1 
-- Data: 09/11/2022
-- T�pico: 5
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exerc�cio 1*/

SET SERVEROUTPUT ON
DECLARE
  v_max_deptno NUMBER;
BEGIN
  SELECT MAX(department_id)
  INTO   v_max_deptno
  FROM   departments;
  DBMS_OUTPUT.PUT_LINE('The maximum department_id is : ' || v_max_deptno);
END;
/

/*Exerc�cio 2*/

  SET SERVEROUTPUT ON
  DECLARE
    v_max_deptno NUMBER;
    v_dept_name departments.department_name%TYPE := 'Education';
    v_dept_id NUMBER;
  BEGIN
    SELECT MAX(department_id)
    INTO   v_max_deptno
    FROM   departments;
    DBMS_OUTPUT.PUT_LINE('The maximum department_id is : ' || v_max_deptno);
    v_dept_id := v_max_deptno + 10;
    INSERT INTO departments (department_id, department_name, location_id) VALUES (v_dept_id, v_dept_name, NULL);
    DBMS_OUTPUT.PUT_LINE(' SQL%ROWCOUNT gives ' || SQL%ROWCOUNT);
    COMMIT;
  END;
  /

  SELECT *
  FROM   departments
  WHERE  department_id = 280;

/*Exerc�cio 3*/

  BEGIN
    UPDATE departments
    SET    location_id = 3000
    WHERE  department_id = 280;
    COMMIT;
  END;
  /
    
  SELECT *
  FROM   departments
  WHERE  department_id = 280;
    
  BEGIN
    DELETE FROM departments
    WHERE  department_id = 280;
    COMMIT;
  END;
  /
