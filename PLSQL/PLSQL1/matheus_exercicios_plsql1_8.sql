/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1 
-- Data: 14/11/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  DECLARE
    v_deptno NUMBER := 50;
    CURSOR c_emp_cursor IS
      SELECT last_name,
             salary,
             manager_id
      FROM   employees
      WHERE  department_id = v_deptno;
  BEGIN
    FOR employee IN c_emp_cursor
    LOOP
      IF employee.salary < 5000 AND
         employee.manager_id IN (101, 124) THEN
        DBMS_OUTPUT.PUT_LINE(employee.last_name || ' Due for a raise');
      ELSE
        DBMS_OUTPUT.PUT_LINE(employee.last_name || ' Not Due for a raise');
      END IF;
    END LOOP;
  END;
  /

/*Exercício 2*/

  DECLARE
    CURSOR c_dept_cursor IS
      SELECT department_id,
             department_name
      FROM   departments
      WHERE  department_id < 100
      ORDER  BY department_id;
    CURSOR c_emp_cursor(deptno NUMBER) IS
      SELECT last_name,
             job_id,
             hire_date,
             salary
      FROM   employees
      WHERE  department_id = deptno
      AND    employee_id < 120;
    v_dept_id       departments.department_id%TYPE;
    v_dept_name     departments.department_name%TYPE;
    v_emp_lname     employees.last_name%TYPE;
    v_emp_job_id    employees.job_id%TYPE;
    v_emp_hire_date employees.hire_date%TYPE;
    v_emp_sal       employees.salary%TYPE;
  BEGIN
    OPEN c_dept_cursor;
    LOOP
      FETCH c_dept_cursor
        INTO v_dept_id,
             v_dept_name;
      EXIT WHEN c_dept_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Department Number : ' || v_dept_id ||
                           '  Department Name : ' || v_dept_name);
      IF NOT c_emp_cursor%ISOPEN THEN
        OPEN c_emp_cursor(v_dept_id);
      END IF;
      LOOP
        FETCH c_emp_cursor
          INTO v_emp_lname,
               v_emp_job_id,
               v_emp_hire_date,
               v_emp_sal;
        EXIT WHEN c_emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_lname || '    ' || v_emp_job_id || '    ' ||
                             v_emp_hire_date || '    ' || v_emp_sal);
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
      CLOSE c_emp_cursor;
    END LOOP;
    CLOSE c_dept_cursor;
  END;
  /

  --usando %ROWTYPE
  DECLARE
    CURSOR c_dept_cursor IS
      SELECT department_id,
             department_name
      FROM   departments
      WHERE  department_id < 100
      ORDER  BY department_id;
    CURSOR c_emp_cursor(deptno NUMBER) IS
      SELECT last_name,
             job_id,
             hire_date,
             salary
      FROM   employees
      WHERE  department_id = deptno
      AND    employee_id < 120;
    dept_record c_dept_cursor%ROWTYPE;
    emp_record c_emp_cursor%ROWTYPE;
  BEGIN
    OPEN c_dept_cursor;
    LOOP
      FETCH c_dept_cursor
        INTO dept_record;
      EXIT WHEN c_dept_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Department Number : ' || dept_record.department_id || '  Department Name : ' || dept_record.department_name);
      IF NOT c_emp_cursor%ISOPEN THEN
        OPEN c_emp_cursor(dept_record.department_id);
      END IF;
      LOOP
        FETCH c_emp_cursor INTO emp_record;
        EXIT WHEN c_emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_record.last_name || '    ' || emp_record.job_id || '    ' || emp_record.hire_date || '    ' || emp_record.salary);
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
      CLOSE c_emp_cursor;
    END LOOP;
    CLOSE c_dept_cursor;
  END;
  /
/
