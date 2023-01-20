/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 05/12/2022
-- Tópico: 8
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

SET SERVEROUTPUT ON

/*Exercício 1*/

  --a)

    CREATE OR REPLACE PROCEDURE check_salary(p_job_id employees.job_id%TYPE,
                                             p_sal    employees.salary%TYPE) IS
      v_max_sal jobs.max_salary%TYPE;
      v_min_sal jobs.min_salary%TYPE;
    BEGIN
      SELECT max_salary,
             min_salary
      INTO   v_max_sal,
             v_min_sal
      FROM   jobs
      WHERE  job_id = p_job_id;

      IF p_sal NOT BETWEEN v_min_sal AND v_max_sal THEN
        RAISE_APPLICATION_ERROR(-20103,
                                'Invalid salary ' || p_sal ||
                                '. Salaries for job ' || p_job_id ||
                                ' must be between ' || v_min_sal || ' and ' ||
                                v_max_sal || '.');
      END IF;
    END;
    /

  --b)

    CREATE OR REPLACE TRIGGER check_salary_trg
      BEFORE INSERT OR UPDATE ON employees
      FOR EACH ROW
    BEGIN
      check_salary(:NEW.job_id, :NEW.salary);
    END;
    /

/*Exercício 2*/

  --a) Um erro é lançado, porque o salário da funcionária não foi registrado e, portanto, não está entre o min. e o max.

    EXECUTE emp_pkg.add_employee('Eleanor', 'Beh', 30);

  --b)

    --Erro, porque 2000 não está entre 2500 e 5500, faixa salarial para PU_CLERK
    UPDATE employees
    SET    salary = 2000
    WHERE  employee_id = 115;

    --Erro, porque a faixa salarial de HR_REP é de 4000 a 9000, e o employee 115 recebe 3100
    UPDATE employees
    SET    job_id = 'HR_REP'
    WHERE  employee_id = 115;

    --Roda, porque 2800 não está entre 2500 e 5500, faixa salarial para PU_CLERK
    UPDATE employees
    SET    salary = 2800
    WHERE  employee_id = 115;

/*Exercício 3*/

  --a)

    CREATE OR REPLACE TRIGGER check_salary_trg
      BEFORE INSERT OR UPDATE OF salary, job_id ON employees
      FOR EACH ROW
      WHEN (NVL(OLD.job_id, '0') != NEW.job_id OR NVL(OLD.salary, 0) != NEW.salary)
    BEGIN
      check_salary(:NEW.job_id, :NEW.salary);
    END;
    /

  --b)

    EXECUTE emp_pkg.add_employee(first_name => 'Eleanor', last_name => 'Beh', email => 'EBEH', job => 'IT_PROG', sal => 5000);

  --c)

    --Erro, porque a faixa salarial de IT_PROG é de 4000 a 10000, e está sendo atribuído 11000 como salário de algum employee
    UPDATE employees
    SET    salary = salary + 2000
    WHERE  job_id = 'IT_PROG';

  --d)

    --Roda, porque 9000 está entre 4000 e 1000
    UPDATE employees
    SET    salary = 9000
    WHERE  first_name = 'Eleanor'
    AND    last_name = 'Beh';
    
  --e)
  
    --Erro, porque a faixa salarial de ST_MAN é de 4000 a 10000, e está sendo atribuído 11000 como salário de algum employee
    UPDATE employees
    SET    job_id = 'ST_MAN'
    WHERE  first_name = 'Eleanor'
    AND    last_name = 'Beh';

/*Exercício 4*/

  --a)

    /*
      CREATE OR REPLACE TRIGGER delete_emp_trg
        BEFORE DELETE ON employees
      BEGIN
        IF (TO_CHAR(SYSDATE, 'DY') NOT IN ('SAT', 'SUN')) AND
           ((TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) BETWEEN 9 AND 17) OR
           (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) = 18 AND
           TO_NUMBER(TO_CHAR(SYSDATE, 'MI')) = 0)) THEN
          RAISE_APPLICATION_ERROR(-20500,
                                  q'[Employees rows can only be deleted when it's not weekday business hours!]');
        END IF;
      END;
      /
    */
    
    --OU
    
    CREATE OR REPLACE TRIGGER delete_emp_trg
      BEFORE DELETE ON employees
    BEGIN
      IF (TO_CHAR(SYSDATE, 'DY') NOT IN ('SAT', 'SUN')) AND
         (SYSDATE BETWEEN (TRUNC(SYSDATE) + 9/24) AND (TRUNC(SYSDATE) + 18/24)) THEN
        RAISE_APPLICATION_ERROR(-20500,
                                q'[Employees rows can only be deleted when it's not weekday business hours!]');
      END IF;
    END;
    /
    
  --b)

    DELETE FROM employees
    WHERE  job_id = 'SA_REP'
    AND    department_id IS NULL;
