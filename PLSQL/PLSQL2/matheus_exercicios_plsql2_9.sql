/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 06/12/2022
-- Tópico: 9
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

SET SERVEROUTPUT ON

/*Exercício 1*/

  --a)

    CREATE OR REPLACE PACKAGE emp_pkg AS
      -- ...
      PROCEDURE set_salary(p_job_id  jobs.job_id%TYPE,
                           p_min_sal jobs.min_salary%TYPE);
      -- ...
    END emp_pkg;
    /

    CREATE OR REPLACE PACKAGE BODY emp_pkg AS
      -- ...
      
      PROCEDURE set_salary(p_job_id  jobs.job_id%TYPE,
                           p_min_sal jobs.min_salary%TYPE) IS
      BEGIN
        UPDATE employees
        SET    salary = p_min_sal
        WHERE  job_id = p_job_id
        AND    salary < p_min_sal;
      END;

      -- ...

    BEGIN
      init_departments;
    END emp_pkg;
    /

  --b)

    CREATE OR REPLACE TRIGGER upd_minsalary_trg
      AFTER UPDATE OF min_salary ON jobs
      FOR EACH ROW
    BEGIN
      emp_pkg.set_salary(:NEW.job_id, :NEW.min_salary);
    END;
    /

  --c)

    SELECT e.employee_id,
           e.last_name,
           e.job_id,
           e.salary,
           j.min_salary
    FROM   employees e,
           jobs      j
    WHERE  e.job_id = j.job_id
    AND    e.job_id = 'IT_PROG';

    --Dá erro, porque a trigger tenta acessar uma mutating table.
    UPDATE jobs
    SET    min_salary = min_salary + 1000
    WHERE  job_id = 'IT_PROG';

/*Exercício 2*/

    --a)

    CREATE OR REPLACE PACKAGE jobs_pkg IS
      PROCEDURE initialize;
      FUNCTION get_minsalary(jobid VARCHAR2) RETURN NUMBER;
      FUNCTION get_maxsalary(jobid VARCHAR2) RETURN NUMBER;
      PROCEDURE set_minsalary(jobid      VARCHAR2,
                              min_salary NUMBER);
      PROCEDURE set_maxsalary(jobid      VARCHAR2,
                              max_salary NUMBER);
    END jobs_pkg;
    /

  --b)

    CREATE OR REPLACE PACKAGE BODY jobs_pkg IS
      TYPE jobs_tab_type IS TABLE OF jobs%ROWTYPE INDEX BY jobs.job_id%TYPE;
      jobstab jobs_tab_type;

      PROCEDURE initialize IS
        CURSOR cur_jobs IS
          SELECT *
          FROM   jobs;
      BEGIN
        FOR job IN cur_jobs
        LOOP
          jobstab(job.job_id) := job;
        END LOOP;
      END;

      FUNCTION get_minsalary(jobid VARCHAR2) RETURN NUMBER IS
      BEGIN
        RETURN jobstab(jobid).min_salary;
      END;

      FUNCTION get_maxsalary(jobid VARCHAR2) RETURN NUMBER IS
      BEGIN
        RETURN jobstab(jobid).max_salary;
      END;

      PROCEDURE set_minsalary(jobid      VARCHAR2,
                              min_salary NUMBER) IS
      BEGIN
        jobstab(jobid).min_salary := min_salary;
      END;

      PROCEDURE set_maxsalary(jobid      VARCHAR2,
                              max_salary NUMBER) IS
      BEGIN
        jobstab(jobid).max_salary := max_salary;
      END;
    END jobs_pkg;
    /

  --c)

    CREATE OR REPLACE PROCEDURE check_salary(p_job_id employees.job_id%TYPE,
                                             p_sal    employees.salary%TYPE) IS
      v_max_sal jobs.max_salary%TYPE := jobs_pkg.get_maxsalary(p_job_id);
      v_min_sal jobs.min_salary%TYPE := jobs_pkg.get_minsalary(p_job_id);
    BEGIN
      IF p_sal NOT BETWEEN v_min_sal AND v_max_sal THEN
        RAISE_APPLICATION_ERROR(-20103,
                                'Invalid salary ' || p_sal ||
                                '. Salaries for job ' || p_job_id ||
                                ' must be between ' || v_min_sal || ' and ' ||
                                v_max_sal || '.');
      END IF;
    END;
    /

  --d)

    CREATE OR REPLACE TRIGGER init_jobpkg_trg
      BEFORE INSERT OR UPDATE ON jobs
    BEGIN
      jobs_pkg.initialize;
    END;
    /

  --e) Os funcionários que recebiam menos que o novo salário (antigo salário + 1000), que são o Austin, o Pataballa e o Lorentz

    SELECT e.employee_id,
           e.last_name,
           e.job_id,
           e.salary,
           j.min_salary
    FROM   employees e,
           jobs      j
    WHERE  e.job_id = j.job_id
    AND    e.job_id = 'IT_PROG';

    UPDATE jobs
    SET    min_salary = min_salary + 1000
    WHERE  job_id = 'IT_PROG';

    SELECT e.employee_id,
           e.last_name,
           e.job_id,
           e.salary,
           j.min_salary
    FROM   employees e,
           jobs      j
    WHERE  e.job_id = j.job_id
    AND    e.job_id = 'IT_PROG';

/*Exercício 3*/

  --a) Erro de no data found, porque a jobstab não está inicializada na jobs_pkg.

    EXECUTE emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', sal => 6500);

  --b)

    CREATE OR REPLACE TRIGGER employee_initjobs_trg
      BEFORE INSERT OR UPDATE ON employees
    BEGIN
      jobs_pkg.initialize;
    END;
    /

  --c)

    EXECUTE emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', sal => 6500);

    SELECT employee_id,
           first_name,
           last_name,
           salary,
           job_id,
           department_id
    FROM   employees
    WHERE  email = 'SMORSE';
