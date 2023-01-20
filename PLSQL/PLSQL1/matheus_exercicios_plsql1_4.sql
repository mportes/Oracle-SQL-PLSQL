/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1 
-- Data: 09/11/2022
-- Tópico: 4
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a) 2 - NUMBER(3)
  
  --b) Western Europe - VARCHAR2(50)
  
  --c) 601 - NUMBER(3)
  
  --d) Product 10012 is in stock - VARCHAR2(255)
  
  --e) Nenhum, porque a variável não foi declarada no outer block.
  
/*Exercício 2*/

  --a) 201 - NUMBER(7)
  
  --b) Unisports - VARCHAR2(255)
  
  --c) EXCELLENT - VARCHAR2(50)
  
  --d) Womansport - VARCHAR2(50)
  
  --e) Nenhum. Variável não declarada.
  
  --f) GOOD - VARCHAR2(50)
  
/*Exercício 3*/

  --VARIABLE b_basic_percent NUMBER
  --VARIABLE b_pf_percent NUMBER
  SET SERVEROUTPUT ON
  DECLARE
    v_today         DATE := SYSDATE;
    v_tomorrow      v_today%TYPE;
    v_basic_percent NUMBER;
    v_pf_percent    NUMBER;
    v_fname         VARCHAR2(15);
    v_emp_sal       NUMBER(10);
  BEGIN
    v_tomorrow := v_today + 1;
    /*:b_basic_percent := 45;
    :b_pf_percent := 12;*/
    SELECT first_name,
           salary
    INTO   v_fname,
           v_emp_sal
    FROM   employees
    WHERE  employee_id = 110;
    v_basic_percent := 45;
    v_pf_percent    := 12;
    DBMS_OUTPUT.PUT_LINE(' Hello ' || v_fname);
    /*DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);*/
    DBMS_OUTPUT.PUT_LINE('YOUR SALARY IS : ' || v_emp_sal);
    DBMS_OUTPUT.PUT_LINE('YOUR CONTRIBUTION TOWARDS PF: 
       ' ||
                         (v_emp_sal * v_basic_percent / 100) * v_pf_percent / 100);
  END;
  /

