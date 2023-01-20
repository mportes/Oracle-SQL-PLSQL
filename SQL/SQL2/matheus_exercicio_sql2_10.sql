/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL2
-- Data: 19/10/2022
-- Tópico: 10
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

--a)

  ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

--b)

  --i)

    SELECT TZ_OFFSET('US/PACIFIC-NEW') FROM dual;

    SELECT TZ_OFFSET('SINGAPORE') FROM dual;

    SELECT TZ_OFFSET('EGYPT') FROM dual;

  --ii)

    ALTER SESSION SET TIME_ZONE = '-07:00';

  --iii)

    SELECT current_date,
           current_timestamp,
           localtimestamp
    FROM   dual;

  --iv)

    ALTER SESSION SET TIME_ZONE = '+08:00';

  --v)

    SELECT current_date,
           current_timestamp,
           localtimestamp
    FROM   dual;

--c)

  SELECT dbtimezone,
         sessiontimezone
  FROM   dual;

--d)

  SELECT last_name,
         EXTRACT(YEAR FROM hire_date)
  FROM   employees
  WHERE  department_id = 80;

--e)

  ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

--f)

  CREATE TABLE sample_dates (date_col DATE);
  INSERT INTO sample_dates VALUES (sysdate);

  --i)

    SELECT *
    FROM   sample_dates;

  --ii)

    ALTER TABLE sample_dates MODIFY (date_col TIMESTAMP);

    SELECT *
    FROM   sample_dates;

  --iii)

    ALTER TABLE sample_dates MODIFY (date_col TIMESTAMP WITH TIME ZONE);

    /* Pode-se converter coluna do tipo DATE para TIMESTAMP, mesmo com dados 
    já inseriods. Entretanto, não se pode converter colunas dos tipos DATE ou 
    TIMESTAMP para TIMESTAMP WITH TIME ZONE se já houver dados inseridos na 
    coluna, e neste caso já havia. */
    
--g)
  
  SELECT last_name,
         CASE EXTRACT(YEAR FROM hire_date)
           WHEN 2008 THEN
            'Needs Review'
           ELSE
            'not this year!'
         END "Review"
  FROM   employees
  ORDER  BY hire_date;

--h)
  
  SELECT last_name,
         hire_date,
         SYSDATE,
         CASE
           WHEN hire_date + TO_YMINTERVAL('15-00') <= SYSDATE THEN
            '15 years of service'
           WHEN hire_date + TO_YMINTERVAL('10-00') <= SYSDATE THEN
            '10 years of service'
           WHEN hire_date + TO_YMINTERVAL('05-00') <= SYSDATE THEN
            '5 years of service'
           ELSE
            'maybe next year!'
         END "Awards"
  FROM   employees
  ORDER  BY hire_date;
