/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 22/11/2022
-- Tópico: 2
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a)

    CREATE OR REPLACE FUNCTION get_job(p_job_id jobs.job_id%TYPE) RETURN VARCHAR2 IS
      v_job_title VARCHAR2(35);
    BEGIN
      SELECT job_title
      INTO   v_job_title
      FROM   jobs
      WHERE  job_id = p_job_id;
      RETURN v_job_title;
    END;
    /

  --b)

    SET AUTOPRINT ON;
    VARIABLE b_title VARCHAR2(35);
    EXECUTE :b_title := get_job('SA_REP');

/*Exercício 2*/

  --a)

    CREATE OR REPLACE FUNCTION get_annual_comp(p_emp_sal employees.salary%TYPE,
                                               p_com_pct employees.commission_pct%TYPE)
      RETURN employees.salary%TYPE IS
    BEGIN
      RETURN (NVL(p_emp_sal, 0) * 12) + (NVL(p_com_pct, 0) * NVL(p_emp_sal, 0) * 12);
    END;
    /

  --b)

    SELECT employee_id,
           last_name,
           get_annual_comp(salary, commission_pct) "Annual Compensation"
    FROM   employees
    WHERE  department_id = 30;

/*Exercício 3*/

  --a)

    CREATE OR REPLACE FUNCTION valid_deptid(p_dept_id departments.department_id%TYPE)
      RETURN BOOLEAN IS
      qtd_dept NUMBER;
    BEGIN
      SELECT COUNT(0)
      INTO   qtd_dept
      FROM   departments
      WHERE  department_id = p_dept_id;
      RETURN qtd_dept = 1;
    END;
    /

  --b)

    CREATE OR REPLACE PROCEDURE add_employee(first_name employees.first_name%TYPE,
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
        RAISE_APPLICATION_ERROR(-20203, 'Invalid department.');
      END IF;
    END;
    /

  --c)

    SET SERVEROUTPUT ON;
    EXECUTE add_employee('Jane', 'Harris', 'JAHARRIS', deptid => 15);

    --A function valid_deptid retorna false e, portanto, a mensagem que alerta o usuário de que o departamento é inválido é exibida

  --d)

    SET SERVEROUTPUT ON;
    EXECUTE add_employee('Joe', 'Harris', 'JOHARRIS', deptid => 80);

    --Como o departamento 80 existe, a function valid_deptid retorna true e, assim, o employee é inserido na tabela:

    SELECT *
    FROM   employees
    WHERE  email = 'JOHARRIS';
