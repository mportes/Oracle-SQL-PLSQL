/*
***************************Exerc�cios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- M�dulo: PLSQL2
-- Data: 21/11/2022
-- T�pico: 1
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exerc�cio 1*/

--a)

  CREATE OR REPLACE PROCEDURE add_job(p_job_id    jobs.job_id%TYPE,
                           p_job_title jobs.job_title%TYPE) IS
  BEGIN
    INSERT INTO jobs
      (job_id,
       job_title)
    VALUES
      (p_job_id,
       p_job_title);
  END;
  /

--b)

  EXECUTE add_job('IT_DBA', 'Database Administrator');

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_DBA';
  
--c)

  EXECUTE add_job('ST_MAN', 'Stock Manager');
  
  --D� erro, visto que a constraint unique da pk � violada, ou seja, j� existe um job com id 'ST_MAN'
  
/*Exerc�cio 2*/

--a)

  CREATE OR REPLACE PROCEDURE upd_job(p_job_id    jobs.job_id%TYPE,
                                      p_job_title jobs.job_title%TYPE) IS
  BEGIN
    UPDATE jobs
    SET    job_title = p_job_title
    WHERE  job_id = p_job_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20202, 'No job updated.');
    END IF;
  END;
/

--b)

  EXECUTE upd_job('IT_DBA', 'Data Administrator');

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_DBA';

--c)

  EXECUTE upd_job('IT_WEB', 'Web Master');
  
/*Exerc�cio 3*/

--a)

  CREATE OR REPLACE PROCEDURE del_job(p_job_id jobs.job_id%TYPE) IS
  BEGIN
    DELETE FROM jobs
    WHERE  job_id = p_job_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20203, 'No jobs deleted.');
    END IF;
  END;
  /

--b)

  EXECUTE del_job('IT_DBA');

  SELECT *
  FROM   jobs
  WHERE  job_id = 'IT_DBA';

--c)

  EXECUTE del_job('IT_WEB');
  
/*Exerc�cio 4*/

--a)

  CREATE OR REPLACE PROCEDURE get_employee(p_emp_id     employees.employee_id%TYPE,
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
  /

--b)

  SET AUTOPRINT ON
  VARIABLE v_salary NUMBER
  VARIABLE v_job VARCHAR2
  BEGIN
    get_employee(120, :v_salary, :v_job);
  END;
  /

--c)

  SET AUTOPRINT ON
  VARIABLE v_salary NUMBER
  VARIABLE v_job VARCHAR2
  BEGIN
    get_employee(300, :v_salary, :v_job);
  END;
  /

  --D� erro, visto que n�o h� nenhum employee cujo id � 300, logo, nenhum a consulta n�o tem nenhum resultado.
