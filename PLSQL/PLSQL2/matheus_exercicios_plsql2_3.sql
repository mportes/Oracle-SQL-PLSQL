/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 23/11/2022
-- Tópico: 3
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a)
    
    CREATE OR REPLACE PACKAGE job_pkg AS
      PROCEDURE add_job(p_job_id    jobs.job_id%TYPE,
                        p_job_title jobs.job_title%TYPE);
      PROCEDURE upd_job(p_job_id    jobs.job_id%TYPE,
                        p_job_title jobs.job_title%TYPE);
      PROCEDURE del_job(p_job_id jobs.job_id%TYPE);
      FUNCTION get_job(p_job_id jobs.job_id%TYPE) RETURN jobs.job_title%TYPE;
    END job_pkg;
    /
    SHOW ERRORS

  --b)

    CREATE OR REPLACE PACKAGE BODY job_pkg AS
      PROCEDURE add_job(p_job_id    jobs.job_id%TYPE,
                        p_job_title jobs.job_title%TYPE) IS
      BEGIN
        INSERT INTO jobs
          (job_id,
           job_title)
        VALUES
          (p_job_id,
           p_job_title);
        COMMIT;
      END;

      PROCEDURE upd_job(p_job_id    jobs.job_id%TYPE,
                        p_job_title jobs.job_title%TYPE) IS
      BEGIN
        UPDATE jobs
        SET    job_title = p_job_title
        WHERE  job_id = p_job_id;
        IF SQL%ROWCOUNT = 0 THEN
          RAISE_APPLICATION_ERROR(-20202, 'No job updated.');
        END IF;
        COMMIT;
      END;

      PROCEDURE del_job(p_job_id jobs.job_id%TYPE) IS
      BEGIN
        DELETE FROM jobs
        WHERE  job_id = p_job_id;
        IF SQL%ROWCOUNT = 0 THEN
          RAISE_APPLICATION_ERROR(-20203, 'No jobs deleted.');
        END IF;
        COMMIT;
      END;

      FUNCTION get_job(p_job_id jobs.job_id%TYPE) RETURN jobs.job_title%TYPE IS
        v_job_title jobs.job_title%TYPE;
      BEGIN
        SELECT job_title
        INTO   v_job_title
        FROM   jobs
        WHERE  job_id = p_job_id;
        RETURN v_job_title;
      END;
    END job_pkg;
    /  
    SHOW ERRORS

  --c) Feito.

  --d)

    EXECUTE job_pkg.add_job('IT-SYSAN', 'SYSTEMS ANALYST');

  --e)

    SELECT *
    FROM   jobs
    WHERE  job_id = 'IT-SYSAN';

/*Exercício 2*/

  --a, b)

    CREATE OR REPLACE PACKAGE emp_pkg AS
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
        COMMIT;
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

  --b) Deu erro.

    EXECUTE emp_pkg.add_employee('David', 'Smith', 'DASMITH', deptid => 15);

  --c) Não deu erro.

    EXECUTE emp_pkg.add_employee('David', 'Smith', 'DASMITH', deptid => 80);

  --d)

    SELECT *
    FROM   employees
    WHERE  email = 'DASMITH';

