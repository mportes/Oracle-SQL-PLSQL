/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 29/11/2022
-- Tópico: 6
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

SET SERVEROUTPUT ON

/*Exercício 1*/

  --a)

    CREATE OR REPLACE PACKAGE tbl_pkg AUTHID CURRENT_USER IS
      PROCEDURE make(p_table_name VARCHAR2,
                     p_col_specs  VARCHAR2);
      PROCEDURE add_row(p_table_name VARCHAR2,
                        p_col_values VARCHAR2,
                        p_cols       VARCHAR2 := NULL);
      PROCEDURE upd_row(p_table_name VARCHAR2,
                        p_set_values VARCHAR2,
                        p_conditions VARCHAR2 := NULL);
      PROCEDURE del_row(p_table_name VARCHAR2,
                        p_conditions VARCHAR2 := NULL);
      PROCEDURE remove(p_table_name VARCHAR2);
    END tbl_pkg;
    /

  --b)

    CREATE OR REPLACE PACKAGE BODY tbl_pkg IS
      PROCEDURE EXECUTE(v_command VARCHAR2) IS
      BEGIN
        EXECUTE IMMEDIATE v_command;
      END;

      PROCEDURE make(p_table_name VARCHAR2,
                     p_col_specs  VARCHAR2) IS
      BEGIN
        EXECUTE('CREATE TABLE ' || p_table_name || '(' || p_col_specs || ')');
      END;

      PROCEDURE add_row(p_table_name VARCHAR2,
                        p_col_values VARCHAR2,
                        p_cols       VARCHAR2 := NULL) IS
      BEGIN
        IF p_cols IS NOT NULL THEN
          EXECUTE('INSERT INTO ' || p_table_name || ' (' || p_cols ||
                  ') VALUES (' || p_col_values || ')');
        ELSE
          EXECUTE('INSERT INTO ' || p_table_name || ' VALUES (' ||
                  p_col_values || ')');
        END IF;
      END;

      PROCEDURE upd_row(p_table_name VARCHAR2,
                        p_set_values VARCHAR2,
                        p_conditions VARCHAR2 := NULL) IS
      BEGIN
        EXECUTE('UPDATE ' || p_table_name || ' SET ' || p_set_values ||
                ' WHERE 1 = 1 ' || p_conditions);
      END;

      PROCEDURE del_row(p_table_name VARCHAR2,
                        p_conditions VARCHAR2 := NULL) IS
      BEGIN
        EXECUTE('DELETE FROM ' || p_table_name || ' WHERE 1 = 1 ' || p_conditions);
      END;

      PROCEDURE remove(p_table_name VARCHAR2) IS
        v_cur_id INTEGER;
        v_command VARCHAR2(200);
      BEGIN
        v_command := 'DROP TABLE ' || p_table_name;
        v_cur_id := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(v_cur_id, v_command, DBMS_SQL.NATIVE);
        DBMS_SQL.CLOSE_CURSOR(v_cur_id);
      END;
    END tbl_pkg;
    /

  --c)

    EXECUTE tbl_pkg.make(' my_contacts', 'id NUMBER(4), name VARCHAR2(40)');

  --d)

    DESC my_contacts;

  --e)

    BEGIN
      tbl_pkg.add_row('my_contacts', '1,''Lauran Serhal''', 'id, name');
      tbl_pkg.add_row('my_contacts', '2,''Nancy''', 'id, name');
      tbl_pkg.add_row('my_contacts', '3,''Sunitha Patel''', 'id,name');
      tbl_pkg.add_row('my_contacts', '4,''Valli Pataballa''', 'id,name');
    END;
    /

    COMMIT;

  --f)

    SELECT *
    FROM   my_contacts;

  --g)

    EXECUTE tbl_pkg.del_row('my_contacts',' AND id = 3');
    COMMIT;

  --h)

    EXECUTE tbl_pkg.upd_row('my_contacts','  name=''Nancy Greenberg''','AND id=2');
    COMMIT;

  --i)

    SELECT *
    FROM   my_contacts;

  --j)

    EXECUTE tbl_pkg.remove('my_contacts');

/*Exercício 2*/

  --a)

    CREATE OR REPLACE PACKAGE compile_pkg AUTHID CURRENT_USER IS
      PROCEDURE make(p_program_name VARCHAR2);
    END compile_pkg;
    /

  --b)

    CREATE OR REPLACE PACKAGE BODY compile_pkg IS
      PROCEDURE EXECUTE(v_command VARCHAR2) IS
      BEGIN
        EXECUTE IMMEDIATE v_command;
      END;

      FUNCTION get_type(p_name VARCHAR2) RETURN VARCHAR2 IS
        v_type user_source.name%TYPE;
      BEGIN
        SELECT TYPE
        INTO   v_type
        FROM   user_source
        WHERE  NAME = p_name
        AND    ROWNUM = 1;
        RETURN v_type;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RETURN NULL;
      END;

      PROCEDURE make(p_program_name VARCHAR2) IS
        v_type user_source.name%TYPE := get_type(p_program_name);
      BEGIN
        IF (v_type IS NOT NULL) THEN
          EXECUTE('ALTER ' || v_type || ' ' || p_program_name || ' COMPILE');
        END IF;
      END;
    END compile_pkg;
    /

  --c)

    BEGIN
      compile_pkg.make('EMPLOYEE_REPORT');
      compile_pkg.make('EMP_PKG');
      compile_pkg.make('EMP_DATA');
    END;
    /
