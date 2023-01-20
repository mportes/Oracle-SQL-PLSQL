/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1
-- Data: 08/11/2022
-- Tópico: 3
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a) valid

  --b) valid

  --c) invalid

  --d) invalid

  --e) valid

  --f) invalid

  --g) valid

  --h) valid
  
/*Exercício 2*/

  --a) valid
  
  --b) invalid
  
  --c) invalid
  
  --d) valid
  
/*Exercício 3*/

  --a) The block executes succesfully and prints "fernandez".
  
/*Exercício 4*/
  
  SET SERVEROUTPUT ON
  DECLARE
    v_today DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE('Hello World!');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
  END;
  /
  
/*Exercício 5*/

  VARIABLE b_basic_percent NUMBER
  VARIABLE b_pf_percent NUMBER
  SET SERVEROUTPUT ON
  DECLARE
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    :b_basic_percent := 45;
    :b_pf_percent := 12;
    DBMS_OUTPUT.PUT_LINE('Hello World!');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
  END;
  /
  PRINT b_basic_percent
  PRINT b_pf_percent
