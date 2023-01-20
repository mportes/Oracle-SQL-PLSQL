/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 25/11/2022
-- Tópico: 5
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

CREATE OR REPLACE PROCEDURE employee_report(p_dir      VARCHAR2,
                                            p_filename VARCHAR2) AS
  CURSOR emps IS
    SELECT e.last_name,
           e.salary,
           e.department_id
    FROM   employees e
    WHERE  e.salary > (SELECT AVG(salary)
                       FROM   employees
                       WHERE  department_id = e.department_id
                       GROUP  BY department_id);
  f_file UTL_FILE.FILE_TYPE;
BEGIN
  f_file := UTL_FILE.FOPEN(p_dir, p_filename, 'W');
  FOR emp IN emps
  LOOP
    UTL_FILE.PUT_LINE(f_file,
                      q'[Employee's Last Name: ]' || emp.last_name ||
                      q'[ | Employee's Salary: ]' || emp.salary ||
                       q'[ | Employee's Department Id: ]' ||
                      emp.department_id);
  END LOOP;
  UTL_FILE.FCLOSE(f_file);
EXCEPTION
  WHEN UTL_FILE.INVALID_FILEHANDLE THEN
    RAISE_APPLICATION_ERROR(-20001, 'Invalid File.');
  WHEN UTL_FILE.WRITE_ERROR THEN
    RAISE_APPLICATION_ERROR(-20002, 'Unable to write to file');
END;
/

/*Exercício 2*/

EXECUTE employee_report('KIPREV_SIDE_DIR', 'MSPLIMA_EMPLOYEE_REPORT.txt');

/*Exercício 3*/

--Feito
