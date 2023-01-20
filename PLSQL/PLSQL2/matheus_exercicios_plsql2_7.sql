/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 01/12/2022
-- Tópico: 7
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

SET SERVEROUTPUT ON

/*Exercício 1*/

  --a, c)

    CREATE OR REPLACE PACKAGE emp_pkg AS
      TYPE emp_tab_type IS TABLE OF employees%ROWTYPE INDEX BY PLS_INTEGER;

      PROCEDURE add_employee(first_name employees.first_name%TYPE,
                             last_name  employees.last_name%TYPE,
                             deptid     employees.department_id%TYPE := 30);

      PROCEDURE add_employee(first_name employees.first_name%TYPE,
                             last_name  employees.last_name%TYPE,
                             email      employees.email%TYPE,
                             job        employees.job_id%TYPE := 'SA_REP',
                             mgr        employees.manager_id%TYPE := 145,
                             sal        employees.salary%TYPE := 1000,
                             comm       employees.commission_pct%TYPE := 0,
                             deptid     employees.department_id%TYPE := 30);

      PROCEDURE init_departments;

      PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
                             p_emp_sal    OUT employees.salary%TYPE,
                             p_emp_job_id OUT employees.job_id%TYPE);

      FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
        RETURN employees%ROWTYPE;

      FUNCTION get_employee(p_emp_family employees.last_name%TYPE)
        RETURN employees%ROWTYPE;

      PROCEDURE get_employees(dept_id employees.department_id%TYPE);

      PROCEDURE print_employee(emp employees%ROWTYPE);
      
      PROCEDURE show_employees;
    END emp_pkg;
    /

  --b, c)

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
      valid_departments boolean_tab_type;

      emp_table emp_tab_type;

      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN;

      PROCEDURE add_employee(first_name employees.first_name%TYPE,
                             last_name  employees.last_name%TYPE,
                             deptid     employees.department_id%TYPE := 30) IS
      BEGIN
        add_employee(first_name,
                     last_name,
                     UPPER(SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 7)),
                     deptid => deptid);
      END;

      PROCEDURE add_employee(first_name employees.first_name%TYPE,
                             last_name  employees.last_name%TYPE,
                             email      employees.email%TYPE,
                             job        employees.job_id%TYPE := 'SA_REP',
                             mgr        employees.manager_id%TYPE := 145,
                             sal        employees.salary%TYPE := 1000,
                             comm       employees.commission_pct%TYPE := 0,
                             deptid     employees.department_id%TYPE := 30) IS
      BEGIN
        IF valid_deptid(deptid) THEN
          INSERT INTO employees
            (employee_id,
             first_name,
             last_name,
             email,
             hire_date,
             job_id,
             manager_id,
             salary,
             commission_pct,
             department_id)
          VALUES
            (employees_seq.NEXTVAL,
             INITCAP(first_name),
             INITCAP(last_name),
             UPPER(email),
             TRUNC(SYSDATE),
             UPPER(job),
             mgr,
             sal,
             comm,
             deptid);
        ELSE
          DBMS_OUTPUT.PUT_LINE('Departamento inválido!');
        END IF;
      END;

      PROCEDURE init_departments IS
      BEGIN
        FOR rec IN (SELECT department_id
                    FROM   departments)
        LOOP
          valid_departments(rec.department_id) := TRUE;
        END LOOP;
      END;

      PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
                             p_emp_sal    OUT employees.salary%TYPE,
                             p_emp_job_id OUT employees.job_id%TYPE) IS
      BEGIN
        SELECT salary,
               job_id
        INTO   p_emp_sal,
               p_emp_job_id
        FROM   employees
        WHERE  employee_id = p_emp_id;
      END;

      FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
        RETURN employees%ROWTYPE IS
        emp employees%ROWTYPE;
      BEGIN
        SELECT *
        INTO   emp
        FROM   employees
        WHERE  employee_id = p_emp_id;
        RETURN emp;
      END;

      FUNCTION get_employee(p_emp_family employees.last_name%TYPE)
        RETURN employees%ROWTYPE IS
        emp employees%ROWTYPE;
      BEGIN
        SELECT *
        INTO   emp
        FROM   employees
        WHERE  last_name = p_emp_family;
        RETURN emp;
      END;

      PROCEDURE get_employees(dept_id employees.department_id%TYPE) IS
      BEGIN
        SELECT *
        BULK   COLLECT
        INTO   emp_table
        FROM   employees
        WHERE  department_id = dept_id;
      END;

      PROCEDURE print_employee(emp employees%ROWTYPE) IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('Department Id: ' || emp.department_id ||
                             ' | Employee Id: ' || emp.employee_id ||
                             ' | First Name: ' || emp.first_name ||
                             ' | Last Name: ' || emp.last_name ||
                             ' | Job Id: ' || emp.job_id || ' | Salary: ' ||
                             emp.salary);
      END;

      PROCEDURE show_employees IS
      BEGIN
        IF emp_table.COUNT > 0 THEN
          FOR i IN emp_table.FIRST .. emp_table.LAST
          LOOP
            print_employee(emp_table(i));
          END LOOP;
        END IF;
      END;

      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN IS
      BEGIN
        RETURN valid_departments(p_dept_id);
      END;

    BEGIN
      init_departments;
    END emp_pkg;
    /

  --d)

    EXECUTE emp_pkg.get_employees(30);
    EXECUTE emp_pkg.show_employees();

    EXECUTE emp_pkg.get_employees(60);
    EXECUTE emp_pkg.show_employees();

/*Exercício 2*/

  --a)

    CREATE TABLE log_newemp ( 
      entry_id NUMBER(6) CONSTRAINT log_newemp_pk PRIMARY KEY, 
      user_id VARCHAR2(30), 
      log_time DATE, 
      name VARCHAR2(60) 
    ); 
 
    CREATE SEQUENCE log_newemp_seq;

  --b, c)

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
      valid_departments boolean_tab_type;

      emp_table emp_tab_type;

      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN;

      PROCEDURE add_employee(first_name employees.first_name%TYPE,
                             last_name  employees.last_name%TYPE,
                             deptid     employees.department_id%TYPE := 30) IS
      BEGIN
        add_employee(first_name,
                     last_name,
                     UPPER(SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 7)),
                     deptid => deptid);
      END;

      PROCEDURE add_employee(first_name employees.first_name%TYPE,
                             last_name  employees.last_name%TYPE,
                             email      employees.email%TYPE,
                             job        employees.job_id%TYPE := 'SA_REP',
                             mgr        employees.manager_id%TYPE := 145,
                             sal        employees.salary%TYPE := 1000,
                             comm       employees.commission_pct%TYPE := 0,
                             deptid     employees.department_id%TYPE := 30) IS
        PROCEDURE audit_newemp(p_name employees.last_name%TYPE) IS
          PRAGMA AUTONOMOUS_TRANSACTION;
        BEGIN
          INSERT INTO log_newemp VALUES (log_newemp_seq.NEXTVAL, USER, SYSDATE, p_name);
          COMMIT;
        END;
      BEGIN
        IF valid_deptid(deptid) THEN
          audit_newemp(first_name || ' ' || last_name);
          INSERT INTO employees
            (employee_id,
             first_name,
             last_name,
             email,
             hire_date,
             job_id,
             manager_id,
             salary,
             commission_pct,
             department_id)
          VALUES
            (employees_seq.NEXTVAL,
             INITCAP(first_name),
             INITCAP(last_name),
             UPPER(email),
             TRUNC(SYSDATE),
             UPPER(job),
             mgr,
             sal,
             comm,
             deptid);
        ELSE
          DBMS_OUTPUT.PUT_LINE('Departamento inválido!');
        END IF;
      END;
      
      PROCEDURE init_departments IS
      BEGIN
        FOR rec IN (SELECT department_id
                    FROM   departments)
        LOOP
          valid_departments(rec.department_id) := TRUE;
        END LOOP;
      END;

      PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
                             p_emp_sal    OUT employees.salary%TYPE,
                             p_emp_job_id OUT employees.job_id%TYPE) IS
      BEGIN
        SELECT salary,
               job_id
        INTO   p_emp_sal,
               p_emp_job_id
        FROM   employees
        WHERE  employee_id = p_emp_id;
      END;

      FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
        RETURN employees%ROWTYPE IS
        emp employees%ROWTYPE;
      BEGIN
        SELECT *
        INTO   emp
        FROM   employees
        WHERE  employee_id = p_emp_id;
        RETURN emp;
      END;

      FUNCTION get_employee(p_emp_family employees.last_name%TYPE)
        RETURN employees%ROWTYPE IS
        emp employees%ROWTYPE;
      BEGIN
        SELECT *
        INTO   emp
        FROM   employees
        WHERE  last_name = p_emp_family;
        RETURN emp;
      END;

      PROCEDURE get_employees(dept_id employees.department_id%TYPE) IS
      BEGIN
        SELECT *
        BULK   COLLECT
        INTO   emp_table
        FROM   employees
        WHERE  department_id = dept_id;
      END;

      PROCEDURE print_employee(emp employees%ROWTYPE) IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('Department Id: ' || emp.department_id ||
                             ' | Employee Id: ' || emp.employee_id ||
                             ' | First Name: ' || emp.first_name ||
                             ' | Last Name: ' || emp.last_name ||
                             ' | Job Id: ' || emp.job_id || ' | Salary: ' ||
                             emp.salary);
      END;

      PROCEDURE show_employees IS
      BEGIN
        IF emp_table.COUNT > 0 THEN
          FOR i IN emp_table.FIRST .. emp_table.LAST
          LOOP
            print_employee(emp_table(i));
          END LOOP;
        END IF;
      END;

      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN IS
      BEGIN
        RETURN valid_departments(p_dept_id);
      END;

    BEGIN
      init_departments;
    END emp_pkg;
    /

  --d) Executou normalmente.

    EXECUTE emp_pkg.add_employee('Max', 'Smart', 20);
    EXECUTE emp_pkg.add_employee('Clark', 'Kent', 10);

  --e) 2 registros.

    SELECT *
    FROM   employees
    WHERE  last_name IN ('Smart', 'Kent');

    SELECT *
    FROM   log_newemp;

  --f)

    ROLLBACK;

  --g)
    --Nenhum registro.
    SELECT *
    FROM   employees
    WHERE  last_name IN ('Smart', 'Kent');
    
    --2 registros
    SELECT *
    FROM   log_newemp;
  
  
  
  
  
  
  
  
  
  
  
