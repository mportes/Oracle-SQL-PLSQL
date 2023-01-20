/*
***************************Exercícios Treinamento***************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: PLSQL2
-- Data: 07/12/2022
-- Tópico: Extra XML
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

SET SERVEROUTPUT ON

/*CREATE OR REPLACE PROCEDURE emp_xml(p_dir      VARCHAR2,
                                    p_filename VARCHAR2) IS
  l_xmltype   XMLTYPE;
  l_domdoc    DBMS_XMLDOM.DOMDOCUMENT;
  l_root_node DBMS_XMLDOM.DOMNODE;

  departamentos_element DBMS_XMLDOM.DOMELEMENT;
  departamentos_node    DBMS_XMLDOM.DOMNODE;

  departamento_element DBMS_XMLDOM.DOMELEMENT;
  departamento_node    DBMS_XMLDOM.DOMNODE;

  nome_dept_element DBMS_XMLDOM.DOMELEMENT;
  nome_dept_node    DBMS_XMLDOM.DOMNODE;

  gerente_dept_element DBMS_XMLDOM.DOMELEMENT;
  gerente_dept_node    DBMS_XMLDOM.DOMNODE;

  cidade_dept_element DBMS_XMLDOM.DOMELEMENT;
  cidade_dept_node    DBMS_XMLDOM.DOMNODE;

  funcionarios_element DBMS_XMLDOM.DOMELEMENT;
  funcionarios_node    DBMS_XMLDOM.DOMNODE;

  funcionario_element DBMS_XMLDOM.DOMELEMENT;
  funcionario_node    DBMS_XMLDOM.DOMNODE;

  nome_func_element DBMS_XMLDOM.DOMELEMENT;
  nome_func_node    DBMS_XMLDOM.DOMNODE;

  email_func_element DBMS_XMLDOM.DOMELEMENT;
  email_func_node    DBMS_XMLDOM.DOMNODE;

  salary_func_element DBMS_XMLDOM.DOMELEMENT;
  salary_func_node    DBMS_XMLDOM.DOMNODE;

  attr DBMS_XMLDOM.DOMATTR;

  text      DBMS_XMLDOM.DOMTEXT;
  text_node DBMS_XMLDOM.DOMNODE;

  CURSOR dept_cur IS
    SELECT d.department_id,
           d.department_name,
           d.manager_id,
           d.location_id,
           l.city city
    FROM   departments d,
           locations   l
    WHERE  d.department_id IN (100, 110)
    AND    d.location_id = l.location_id;

  CURSOR emp_cur(p_dept_id departments.department_id%TYPE,
                 p_mgr_id  employees.employee_id%TYPE) IS
    SELECT employee_id,
           first_name || ' ' || last_name emp_name,
           email,
           TO_CHAR(salary, 'fm999999D00') salary
    FROM   employees
    WHERE  department_id = p_dept_id
    AND    employee_id != p_mgr_id
    ORDER  BY employee_id
    FETCH  FIRST 2 ROWS ONLY;
  
  dept dept_cur%ROWTYPE;
  emp emp_cur%ROWTYPE;
  
  f_file UTL_FILE.FILE_TYPE;
BEGIN
  f_file := UTL_FILE.FOPEN(p_dir, p_filename, 'W');
  
  l_domdoc := DBMS_XMLDOM.NEWDOMDOCUMENT;
  dbms_xmldom.setVersion(l_domdoc, '1.0" encoding="UTF-8');
  dbms_xmldom.setCharset(l_domdoc, 'UTF-8');

  l_root_node := DBMS_XMLDOM.MAKENODE(l_domdoc);

  departamentos_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                     'Departamentos');
  departamentos_node    := DBMS_XMLDOM.APPENDCHILD(l_root_node,
                                                   DBMS_XMLDOM.MAKENODE(departamentos_element));

  OPEN dept_cur;
  LOOP
    FETCH dept_cur
      INTO dept;
    EXIT WHEN dept_cur%NOTFOUND;
    departamento_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                      'Departamento');
    departamento_node    := DBMS_XMLDOM.APPENDCHILD(departamentos_node,
                                                    DBMS_XMLDOM.MAKENODE(departamento_element));
  
    attr := DBMS_XMLDOM.CREATEATTRIBUTE(l_domdoc, 'id');
    DBMS_XMLDOM.SETVALUE(attr, dept.department_id);
    attr := DBMS_XMLDOM.SETATTRIBUTENODE(departamento_element, attr);
  
    nome_dept_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                   'NomeDepartamento');
    nome_dept_node    := DBMS_XMLDOM.APPENDCHILD(departamento_node,
                                                 DBMS_XMLDOM.MAKENODE(nome_dept_element));
    text              := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc,
                                                    dept.department_name);
    text_node         := DBMS_XMLDOM.APPENDCHILD(nome_dept_node,
                                                 DBMS_XMLDOM.MAKENODE(text));
  
    gerente_dept_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                      'GerenteDepartamento');
    gerente_dept_node    := DBMS_XMLDOM.APPENDCHILD(departamento_node,
                                                    DBMS_XMLDOM.MAKENODE(gerente_dept_element));
    attr                 := DBMS_XMLDOM.CREATEATTRIBUTE(l_domdoc, 'id');
    DBMS_XMLDOM.SETVALUE(attr, dept.manager_id);
    attr := DBMS_XMLDOM.SETATTRIBUTENODE(gerente_dept_element, attr);
  
    SELECT employee_id,
           first_name || ' ' || last_name emp_name,
           email,
           TO_CHAR(salary, 'fm999999D00') salary
    INTO   emp
    FROM   employees
    WHERE  employee_id = dept.manager_id;
  
    nome_func_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                   'NomeFuncionario');
    nome_func_node    := DBMS_XMLDOM.APPENDCHILD(gerente_dept_node,
                                                 DBMS_XMLDOM.MAKENODE(nome_func_element));
    text              := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc, emp.emp_name);
    text_node         := DBMS_XMLDOM.APPENDCHILD(nome_func_node,
                                                 DBMS_XMLDOM.MAKENODE(text));
  
    email_func_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                    'EmailFuncionario');
    email_func_node    := DBMS_XMLDOM.APPENDCHILD(gerente_dept_node,
                                                  DBMS_XMLDOM.MAKENODE(email_func_element));
    text               := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc, emp.email);
    text_node          := DBMS_XMLDOM.APPENDCHILD(email_func_node,
                                                  DBMS_XMLDOM.MAKENODE(text));
  
    salary_func_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                     'SalarioFuncionario');
    salary_func_node    := DBMS_XMLDOM.APPENDCHILD(gerente_dept_node,
                                                   DBMS_XMLDOM.MAKENODE(salary_func_element));
    text                := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc, emp.salary);
    text_node           := DBMS_XMLDOM.APPENDCHILD(salary_func_node,
                                                   DBMS_XMLDOM.MAKENODE(text));
  
    cidade_dept_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                     'CidadeDepartamento');
    cidade_dept_node    := DBMS_XMLDOM.APPENDCHILD(departamento_node,
                                                   DBMS_XMLDOM.MAKENODE(cidade_dept_element));
    text                := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc, dept.city);
    text_node           := DBMS_XMLDOM.APPENDCHILD(cidade_dept_node,
                                                   DBMS_XMLDOM.MAKENODE(text));
  
    funcionarios_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                      'Funcionarios');
    funcionarios_node    := DBMS_XMLDOM.APPENDCHILD(departamento_node,
                                                    DBMS_XMLDOM.MAKENODE(funcionarios_element));
  
    OPEN emp_cur(dept.department_id, dept.manager_id);
    LOOP
      FETCH emp_cur
        INTO emp;
      EXIT WHEN emp_cur%NOTFOUND;
      funcionario_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                       'Funcionario');
      funcionario_node    := DBMS_XMLDOM.APPENDCHILD(funcionarios_node,
                                                     DBMS_XMLDOM.MAKENODE(funcionario_element));
      attr                := DBMS_XMLDOM.CREATEATTRIBUTE(l_domdoc, 'id');
      DBMS_XMLDOM.SETVALUE(attr, emp.employee_id);
      attr := DBMS_XMLDOM.SETATTRIBUTENODE(funcionario_element, attr);
    
      nome_func_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                     'NomeFuncionario');
      nome_func_node    := DBMS_XMLDOM.APPENDCHILD(funcionario_node,
                                                   DBMS_XMLDOM.MAKENODE(nome_func_element));
      text              := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc,
                                                      emp.emp_name);
      text_node         := DBMS_XMLDOM.APPENDCHILD(nome_func_node,
                                                   DBMS_XMLDOM.MAKENODE(text));
    
      email_func_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                      'EmailFuncionario');
      email_func_node    := DBMS_XMLDOM.APPENDCHILD(funcionario_node,
                                                    DBMS_XMLDOM.MAKENODE(email_func_element));
      text               := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc, emp.email);
      text_node          := DBMS_XMLDOM.APPENDCHILD(email_func_node,
                                                    DBMS_XMLDOM.MAKENODE(text));
    
      salary_func_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc,
                                                       'SalarioFuncionario');
      salary_func_node    := DBMS_XMLDOM.APPENDCHILD(funcionario_node,
                                                     DBMS_XMLDOM.MAKENODE(salary_func_element));
      text                := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc,
                                                        emp.salary);
      text_node           := DBMS_XMLDOM.APPENDCHILD(salary_func_node,
                                                     DBMS_XMLDOM.MAKENODE(text));
    END LOOP;
    attr := DBMS_XMLDOM.CREATEATTRIBUTE(l_domdoc, 'quantidadeFuncionarios');
    DBMS_XMLDOM.SETVALUE(attr, emp_cur%ROWCOUNT);
    attr := DBMS_XMLDOM.SETATTRIBUTENODE(funcionarios_element, attr);
    CLOSE emp_cur;
  END LOOP;

  attr := DBMS_XMLDOM.CREATEATTRIBUTE(l_domdoc, 'quantidadeDepartamentos');
  DBMS_XMLDOM.SETVALUE(attr, dept_cur%ROWCOUNT);
  attr := DBMS_XMLDOM.SETATTRIBUTENODE(departamentos_element, attr);

  CLOSE dept_cur;

  l_xmltype := DBMS_XMLDOM.GETXMLTYPE(l_domdoc);
  DBMS_XMLDOM.FREEDOCUMENT(l_domdoc);

  UTL_FILE.PUT_LINE(f_file, l_xmltype.GETCLOBVAL);
  UTL_FILE.FCLOSE(f_file);
END;
/*/

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE emp_xml_pkg IS
  PROCEDURE emp_xml(p_dir      VARCHAR2,
                    p_filename VARCHAR2);
END emp_xml_pkg;
/

CREATE OR REPLACE PACKAGE BODY emp_xml_pkg IS
  l_xmltype XMLTYPE;
  l_domdoc  DBMS_XMLDOM.DOMDOCUMENT;
  text      DBMS_XMLDOM.DOMTEXT;
  text_node DBMS_XMLDOM.DOMNODE;
  attr      DBMS_XMLDOM.DOMATTR;
  TYPE emp_rec IS RECORD(
    employee_id employees.employee_id%TYPE,
    emp_name    VARCHAR2(46),
    email       employees.email%TYPE,
    salary      VARCHAR2(9));

  PROCEDURE create_element(p_title   VARCHAR2,
                           p_element IN OUT NOCOPY DBMS_XMLDOM.DOMELEMENT,
                           p_node    IN OUT NOCOPY DBMS_XMLDOM.DOMNODE,
                           p_parent  DBMS_XMLDOM.DOMNODE) IS
  BEGIN
    p_element := DBMS_XMLDOM.CREATEELEMENT(l_domdoc, p_title);
    p_node    := DBMS_XMLDOM.APPENDCHILD(p_parent,
                                         DBMS_XMLDOM.MAKENODE(p_element));
  END;

  PROCEDURE atr_text(p_text VARCHAR2,
                     p_node DBMS_XMLDOM.DOMNODE) IS
  BEGIN
    text      := DBMS_XMLDOM.CREATETEXTNODE(l_domdoc, p_text);
    text_node := DBMS_XMLDOM.APPENDCHILD(p_node, DBMS_XMLDOM.MAKENODE(text));
  END;

  PROCEDURE atr_atr(p_title   VARCHAR2,
                    p_value   VARCHAR2,
                    p_element DBMS_XMLDOM.DOMELEMENT) IS
  BEGIN
    attr := DBMS_XMLDOM.CREATEATTRIBUTE(l_domdoc, p_title);
    DBMS_XMLDOM.SETVALUE(attr, p_value);
    attr := DBMS_XMLDOM.SETATTRIBUTENODE(p_element, attr);
  END;

  PROCEDURE create_emp_element(p_element IN OUT NOCOPY DBMS_XMLDOM.DOMELEMENT,
                               p_node    IN OUT NOCOPY DBMS_XMLDOM.DOMNODE,
                               p_parent  DBMS_XMLDOM.DOMNODE,
                               emp       emp_rec) IS
  BEGIN
    create_element('NomeFuncionario', p_element, p_node, p_parent);
    atr_text(emp.emp_name, p_node);
  
    create_element('EmailFuncionario', p_element, p_node, p_parent);
    atr_text(emp.email, p_node);
  
    create_element('SalarioFuncionario', p_element, p_node, p_parent);
    atr_text(emp.salary, p_node);
  END;

  PROCEDURE emp_xml(p_dir      VARCHAR2,
                    p_filename VARCHAR2) IS
    l_root_node DBMS_XMLDOM.DOMNODE;
  
    departamentos_element DBMS_XMLDOM.DOMELEMENT;
    departamentos_node    DBMS_XMLDOM.DOMNODE;
  
    departamento_element DBMS_XMLDOM.DOMELEMENT;
    departamento_node    DBMS_XMLDOM.DOMNODE;
  
    dept_atr_element DBMS_XMLDOM.DOMELEMENT;
    dept_atr_node    DBMS_XMLDOM.DOMNODE;
  
    dept_atr_atr_element DBMS_XMLDOM.DOMELEMENT;
    dept_atr_atr_node    DBMS_XMLDOM.DOMNODE;
  
    dept_atr_atr_atr_element DBMS_XMLDOM.DOMELEMENT;
    dept_atr_atr_atr_node    DBMS_XMLDOM.DOMNODE;
  
    CURSOR dept_cur IS
      SELECT d.department_id,
             d.department_name,
             d.manager_id,
             d.location_id,
             l.city city
      FROM   departments d,
             locations   l
      WHERE  d.location_id = l.location_id
      ORDER  BY department_id;
  
    CURSOR emp_cur(p_dept_id departments.department_id%TYPE,
                   p_mgr_id  employees.employee_id%TYPE) IS
      SELECT employee_id,
             first_name || ' ' || last_name emp_name,
             email,
             TO_CHAR(salary, 'fm999999D00') salary
      FROM   employees
      WHERE  department_id = p_dept_id
      AND    employee_id != p_mgr_id
      ORDER  BY employee_id;
  
    emp  emp_cur%ROWTYPE;
    dept dept_cur%ROWTYPE;
  
    f_file UTL_FILE.FILE_TYPE;
  BEGIN
    f_file := UTL_FILE.FOPEN(p_dir, p_filename, 'W');
  
    l_domdoc := DBMS_XMLDOM.NEWDOMDOCUMENT;
    dbms_xmldom.setVersion(l_domdoc, '1.0" encoding="UTF-8');
    dbms_xmldom.setCharset(l_domdoc, 'UTF-8');
  
    l_root_node := DBMS_XMLDOM.MAKENODE(l_domdoc);
  
    create_element('Departamentos',
                   departamentos_element,
                   departamentos_node,
                   l_root_node);
  
    OPEN dept_cur;
    LOOP
      FETCH dept_cur
        INTO dept;
      EXIT WHEN dept_cur%NOTFOUND;
      create_element('Departamento',
                     departamento_element,
                     departamento_node,
                     departamentos_node);
      atr_atr('id', dept.department_id, departamento_element);
    
      create_element('NomeDepartamento',
                     dept_atr_element,
                     dept_atr_node,
                     departamento_node);
      atr_text(dept.department_name, dept_atr_node);
    
      create_element('GerenteDepartamento',
                     dept_atr_element,
                     dept_atr_node,
                     departamento_node);
    
      IF dept.manager_id IS NOT NULL THEN
        atr_atr('id', dept.manager_id, dept_atr_element);
      
        SELECT employee_id,
               first_name || ' ' || last_name emp_name,
               email,
               TO_CHAR(salary, 'fm999999D00') salary
        INTO   emp
        FROM   employees
        WHERE  employee_id = dept.manager_id;
      
        create_emp_element(dept_atr_atr_element,
                           dept_atr_atr_node,
                           dept_atr_node,
                           emp);
      END IF;
    
      create_element('CidadeDepartamento',
                     dept_atr_element,
                     dept_atr_node,
                     departamento_node);
      atr_text(dept.city, dept_atr_node);
    
      create_element('Funcionarios',
                     dept_atr_element,
                     dept_atr_node,
                     departamento_node);
    
      OPEN emp_cur(dept.department_id, dept.manager_id);
      LOOP
        FETCH emp_cur
          INTO emp;
        EXIT WHEN emp_cur%NOTFOUND;
        create_element('Funcionario',
                       dept_atr_atr_element,
                       dept_atr_atr_node,
                       dept_atr_node);
        atr_atr('id', emp.employee_id, dept_atr_atr_element);
      
        create_emp_element(dept_atr_atr_atr_element,
                           dept_atr_atr_atr_node,
                           dept_atr_atr_node,
                           emp);
      END LOOP;
      atr_atr('quantidadeFuncionarios', emp_cur%ROWCOUNT, dept_atr_element);
      CLOSE emp_cur;
    END LOOP;
    atr_atr('quantidadeDepartamentos',
            dept_cur%ROWCOUNT,
            departamentos_element);
  
    CLOSE dept_cur;
  
    l_xmltype := DBMS_XMLDOM.GETXMLTYPE(l_domdoc);
    DBMS_XMLDOM.FREEDOCUMENT(l_domdoc);
  
    UTL_FILE.PUT_LINE(f_file, l_xmltype.GETCLOBVAL);
    UTL_FILE.FCLOSE(f_file);
  EXCEPTION
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      RAISE_APPLICATION_ERROR(-20100, 'Arquivo inválido!');
    WHEN UTL_FILE.WRITE_ERROR THEN
      RAISE_APPLICATION_ERROR(-20200,
                              'Não foi possível escrever no arquivo!');
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20300, 'Erro inesperado: ' || SQLERRM);
  END;
END emp_xml_pkg;
/
