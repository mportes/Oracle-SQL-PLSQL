/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1 
-- Data: 11/11/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  CREATE TABLE messages
  (
    results VARCHAR2(255)
  );

  BEGIN
    FOR i IN 1 .. 10 LOOP
      CONTINUE WHEN i = 6 OR i = 8;
      INSERT INTO messages VALUES (i);
    END LOOP;
    COMMIT;
  END;
  /

  SELECT * FROM messages;

/*Exercício 2*/

  CREATE TABLE emp AS SELECT * FROM employees;
  ALTER TABLE emp ADD (stars VARCHAR2(50));

  DECLARE
    v_empno    emp.employee_id%TYPE := 176;
    v_asterisk emp.stars%TYPE := '';
    v_sal      emp.salary%TYPE;
  BEGIN
    SELECT NVL(salary, 0)
    INTO   v_sal
    FROM   emp
    WHERE  employee_id = v_empno;
    FOR i IN 1 .. v_sal / 1000
    LOOP
      v_asterisk := v_asterisk || '*';
    END LOOP;
    UPDATE emp
    SET    stars = v_asterisk
    WHERE  employee_id = v_empno;
    COMMIT;
  END;
  /

  SELECT *
  FROM   emp
  WHERE  employee_id = 176;
