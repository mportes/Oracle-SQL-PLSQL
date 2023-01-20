/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL1 
-- Data: 18/11/2022
-- Tópico: 10
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  CREATE PROCEDURE greet IS
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello World ');
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
  END;
  /

  BEGIN
    greet;
  END;
  /

/*Exercício 2*/

  DROP PROCEDURE greet;

  CREATE PROCEDURE greet(p_name VARCHAR2) IS
    v_today    DATE := SYSDATE;
    v_tomorrow v_today%TYPE;
  BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE(' Hello ' || p_name);
    DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
    DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
  END;
  /

  BEGIN
    greet('Nancy');
  END;
  /
