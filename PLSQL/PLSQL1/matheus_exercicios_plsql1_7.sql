/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1 
-- Data: 11/11/2022
-- Tópico: 7
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  DECLARE
    v_countryid      countries.country_id%TYPE := 'CA';
    v_country_record countries%ROWTYPE;
  BEGIN
    SELECT *
    INTO   v_country_record
    FROM   countries
    WHERE  country_id = v_countryid;
    DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id ||
                         ' Country Name: ' || v_country_record.country_name ||
                         ' Region: ' || v_country_record.region_id);
  END;
  /

  DECLARE v_countryid countries.country_id%TYPE := 'DE';
  v_country_record countries%ROWTYPE;
  BEGIN
    SELECT *
    INTO   v_country_record
    FROM   countries
    WHERE  country_id = v_countryid;
    DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id ||
                         ' Country Name: ' || v_country_record.country_name ||
                         ' Region: ' || v_country_record.region_id);
  END;
  /

  DECLARE v_countryid countries.country_id%TYPE := 'UK';
  v_country_record countries%ROWTYPE;
  BEGIN
    SELECT *
    INTO   v_country_record
    FROM   countries
    WHERE  country_id = v_countryid;
    DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id ||
                         ' Country Name: ' || v_country_record.country_name ||
                         ' Region: ' || v_country_record.region_id);
  END;
  /

  DECLARE v_countryid countries.country_id%TYPE := 'US';
  v_country_record countries%ROWTYPE;
  BEGIN
    SELECT *
    INTO   v_country_record
    FROM   countries
    WHERE  country_id = v_countryid;
    DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id ||
                         ' Country Name: ' || v_country_record.country_name ||
                         ' Region: ' || v_country_record.region_id);
  END;
  /

/*Exercício 2*/

  DECLARE
    TYPE dept_table_type IS TABLE OF departments.department_name%TYPE INDEX BY PLS_INTEGER;
    my_dept_table dept_table_type;
    f_loop_count  NUMBER := 10;
    v_deptno      NUMBER := 0;
  BEGIN
    WHILE v_deptno <= 100
    LOOP
      v_deptno := v_deptno + 10;
      SELECT department_name
      INTO   my_dept_table(v_deptno)
      FROM   departments
      WHERE  department_id = v_deptno;
    END LOOP;
    LOOP
      DBMS_OUTPUT.PUT_LINE(my_dept_table(f_loop_count));
      f_loop_count := f_loop_count + 10;
      EXIT WHEN f_loop_count > 100;
    END LOOP;
  END;
  /

/*Exercício 3*/

  DECLARE
    TYPE dept_table_type IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
    my_dept_table dept_table_type;
    f_loop_count  NUMBER := 10;
    v_deptno      NUMBER := 0;
  BEGIN
    WHILE v_deptno <= 100
    LOOP
      v_deptno := v_deptno + 10;
      SELECT *
      INTO   my_dept_table(v_deptno)
      FROM   departments
      WHERE  department_id = v_deptno;
    END LOOP;
    LOOP
      DBMS_OUTPUT.PUT_LINE(
        'Department Number: ' || my_dept_table(f_loop_count).department_id ||
        ' Department Name: ' || my_dept_table(f_loop_count).department_name ||
        ' Manager Id: ' || my_dept_table(f_loop_count).manager_id ||
        ' Location Id: ' || my_dept_table(f_loop_count).location_id);
      f_loop_count := f_loop_count + 10;
      EXIT WHEN f_loop_count > 100;
    END LOOP;
  END;
  /
