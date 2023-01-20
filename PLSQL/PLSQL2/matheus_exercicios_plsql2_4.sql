/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 25/11/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a, b, c)

    CREATE OR REPLACE PACKAGE emp_pkg AS
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

      PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
                             p_emp_sal    OUT employees.salary%TYPE,
                             p_emp_job_id OUT employees.job_id%TYPE);
    END emp_pkg;
    /
    SHOW ERRORS

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN IS
        qtd_dept NUMBER;
      BEGIN
        SELECT COUNT(0)
        INTO   qtd_dept
        FROM   departments
        WHERE  department_id = p_dept_id;
        RETURN qtd_dept = 1;
      END;

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
    END emp_pkg;
    /
    SHOW ERRORS

  --d)

    EXECUTE emp_pkg.add_employee('Samuel', 'Joplin', 30);

  --e)

    SELECT *
    FROM   employees
    WHERE  email = 'SJOPLIN';

/*Exercício 2*/

  --a, b, c, d, e, f)

    CREATE OR REPLACE PACKAGE emp_pkg AS
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

      PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
                             p_emp_sal    OUT employees.salary%TYPE,
                             p_emp_job_id OUT employees.job_id%TYPE);

      FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
        RETURN employees%ROWTYPE;

      FUNCTION get_employee(p_emp_family employees.last_name%TYPE)
        RETURN employees%ROWTYPE;

      PROCEDURE print_employee(emp employees%ROWTYPE);
    END emp_pkg;
    /
    SHOW ERRORS

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN IS
        qtd_dept NUMBER;
      BEGIN
        SELECT COUNT(0)
        INTO   qtd_dept
        FROM   departments
        WHERE  department_id = p_dept_id;
        RETURN qtd_dept = 1;
      END;

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

      PROCEDURE print_employee(emp employees%ROWTYPE) IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('Department Id: ' || emp.department_id ||
                             ' | Employee Id: ' || emp.employee_id ||
                             ' | First Name: ' || emp.first_name ||
                             ' | Last Name: ' || emp.last_name ||
                             ' | Job Id: ' || emp.job_id || ' | Salary: ' ||
                             emp.salary);
      END;
    END emp_pkg;
    /
    SHOW ERRORS

  --g)

    SET SERVEROUTPUT ON
    DECLARE
      emp employees%ROWTYPE;
    BEGIN
      emp := emp_pkg.get_employee(100);
      emp_pkg.print_employee(emp);
      emp := emp_pkg.get_employee('Joplin');
      emp_pkg.print_employee(emp);
    END;
    /

/*Exercício 3*/

  --a, b, c, d)

    CREATE OR REPLACE PACKAGE emp_pkg AS
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

      PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
                             p_emp_sal    OUT employees.salary%TYPE,
                             p_emp_job_id OUT employees.job_id%TYPE);

      FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
        RETURN employees%ROWTYPE;

      FUNCTION get_employee(p_emp_family employees.last_name%TYPE)
        RETURN employees%ROWTYPE;

      PROCEDURE init_departments;

      PROCEDURE print_employee(emp employees%ROWTYPE);
    END emp_pkg;
    /
    SHOW ERRORS

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
      valid_departments boolean_tab_type;

      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN IS
        qtd_dept NUMBER;
      BEGIN
        SELECT COUNT(0)
        INTO   qtd_dept
        FROM   departments
        WHERE  department_id = p_dept_id;
        RETURN qtd_dept = 1;
      END;

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

      PROCEDURE init_departments IS
      BEGIN
        FOR rec IN (SELECT department_id
                    FROM   departments)
        LOOP
          valid_departments(rec.department_id) := TRUE;
        END LOOP;
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

    BEGIN
      init_departments;
    END emp_pkg;
    /
    SHOW ERRORS

/*Exercício 4*/

  --a)

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
      valid_departments boolean_tab_type;

      FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
        RETURN BOOLEAN IS
      BEGIN
        RETURN valid_departments(p_dept_id);
      END;

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

      PROCEDURE init_departments IS
      BEGIN
        FOR rec IN (SELECT department_id
                    FROM   departments)
        LOOP
          valid_departments(rec.department_id) := TRUE;
        END LOOP;
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

    BEGIN
      init_departments;
    END emp_pkg;
    /
    SHOW ERRORS

  --b)

    EXECUTE emp_pkg.add_employee('James', 'Bond', 15);

  --c)

    INSERT INTO departments
      (department_id,
       department_name)
    VALUES
      (15,
       'Security');

    COMMIT;

    SELECT *
    FROM   departments
    WHERE  department_id = 15;

  --d) Dá erro.

    EXECUTE emp_pkg.add_employee('James', 'Bond', 15);

  --e) Dá erro.

    EXECUTE emp_pkg.init_departments;

  --f) Executa.

    EXECUTE emp_pkg.add_employee('James', 'Bond', 15);

  --g)

    SET SERVEROUTPUT ON

    DELETE FROM employees
    WHERE  first_name = 'James'
    AND    last_name = 'Bond';

    DELETE FROM departments
    WHERE  department_id = 15;

    EXECUTE emp_pkg.init_departments;

/*Exercício 5*/

  --a) Executa normalmente.

    CREATE OR REPLACE PACKAGE emp_pkg AS
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

      PROCEDURE print_employee(emp employees%ROWTYPE);
    END emp_pkg;
    /
    SHOW ERRORS

  --b) Dá erro.

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
      valid_departments boolean_tab_type;

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

      PROCEDURE print_employee(emp employees%ROWTYPE) IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('Department Id: ' || emp.department_id ||
                             ' | Employee Id: ' || emp.employee_id ||
                             ' | First Name: ' || emp.first_name ||
                             ' | Last Name: ' || emp.last_name ||
                             ' | Job Id: ' || emp.job_id || ' | Salary: ' ||
                             emp.salary);
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
    SHOW ERRORS

  --c) Executa normalmente.

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      TYPE boolean_tab_type IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
      valid_departments boolean_tab_type;

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

      PROCEDURE print_employee(emp employees%ROWTYPE) IS
      BEGIN
        DBMS_OUTPUT.PUT_LINE('Department Id: ' || emp.department_id ||
                             ' | Employee Id: ' || emp.employee_id ||
                             ' | First Name: ' || emp.first_name ||
                             ' | Last Name: ' || emp.last_name ||
                             ' | Job Id: ' || emp.job_id || ' | Salary: ' ||
                             emp.salary);
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
    SHOW ERRORS
