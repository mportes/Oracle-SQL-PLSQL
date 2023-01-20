/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 08/12/2022
-- Tópico: Extra REGEX
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/


SET SERVEROUTPUT ON

/*Exercício 1*/

CREATE OR REPLACE FUNCTION validate_password(p_user     VARCHAR2,
                                             p_password VARCHAR2)
  RETURN BOOLEAN IS
BEGIN
  IF REGEXP_LIKE(p_password, '^[[:alpha:]0-9[:punct:]]{8,}$') AND
     REGEXP_COUNT(p_password, '[[:alpha:]]') >= 2 AND
     REGEXP_COUNT(p_password, '[0-9]') >= 1 AND
     REGEXP_COUNT(p_password, '[[:punct:]]') >= 1 AND
     REGEXP_COUNT(UPPER(p_password), UPPER(p_user)) = 0 THEN
    RETURN TRUE;
  END IF;
  RETURN FALSE;
END;
/
SHOW ERRORS

/*Exercício 2*/

CREATE OR REPLACE FUNCTION validate_email(p_email VARCHAR2) RETURN BOOLEAN IS
BEGIN
  IF REGEXP_COUNT(p_email, ' ') = 0 AND
     REGEXP_COUNT(p_email, '@') = 1 AND
     REGEXP_LIKE(p_email, '.+@.+\..+') THEN
    RETURN TRUE;
  END IF;
  RETURN FALSE;
END;
/
SHOW ERRORS
