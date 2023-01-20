/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL1 
-- Data: 04/10/2022
-- Tópico: 7
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

/*Exercício 1*/

  --a)   

    SELECT location_id,
           l.street_address,
           l.city,
           l.state_province,
           c.country_name
    FROM   departments d NATURAL
    JOIN   locations l NATURAL
    JOIN   countries c;
    
  --b) ORDER BY apenas para ficar mais parecido com o exibido
  
    SELECT e.last_name,
           department_id,
           d.department_name
    FROM   employees e
    JOIN   departments d
    USING  (department_id)
    ORDER BY e.last_name;
    
  --c)
  
    SELECT e.last_name,
           e.job_id,
           department_id,
           d.department_name
    FROM   employees e
    JOIN   departments d
    USING  (department_id)
    JOIN   locations l
    USING  (location_id)
    WHERE  LOWER(l.city) = 'toronto';

  --d)
  
    SELECT e.last_name   "Employee",
           e.employee_id emp#,
           m.last_name   "Manager",
           m.employee_id "Mgr#"
    FROM   employees e
    JOIN   employees m
    ON     e.manager_id = m.employee_id;

  --e) ORDER BY apenas para ficar mais parecido com o exibido
  
    SELECT e.last_name   "Employee",
           e.employee_id emp#,
           m.last_name   "Manager",
           m.employee_id "Mgr#"
    FROM   employees e
    LEFT   OUTER JOIN employees m
    ON     e.manager_id = m.employee_id
    ORDER BY emp#;
  
  --f) ORDER BY apenas para ficar mais parecido com o exibido
  
    SELECT department_id department,
           e.last_name   employee,
           c.last_name   colleague
    FROM   employees e
    JOIN   employees c
    USING  (department_id)
    WHERE e.employee_id <> c.employee_id
    ORDER  BY department, employee, colleague;
    
  --g) ORDER BY apenas para ficar mais parecido com o exibido
  
    DESC job_grades;
    
    SELECT e.last_name,
           e.job_id,
           d.department_name,
           e.salary,
           j.grade_level
    FROM   employees e
    JOIN   departments d
    USING  (department_id)
    JOIN   job_grades j
    ON     e.salary BETWEEN j.lowest_sal AND highest_sal
    ORDER BY 4 DESC;

  --h)
  
    SELECT e.last_name,
           e.hire_date
    FROM   employees e
    JOIN   employees d
    ON     e.hire_date > d.hire_date
    WHERE d.last_name = 'Davies';
    
    
  --i) ORDER BY apenas para ficar mais parecido com o exibido
  
    SELECT e.last_name,
           e.hire_date,
           m.last_name last_name_1,
           m.hire_date hire_date_1
    FROM   employees e
    JOIN   employees m
    ON     e.manager_id = m.employee_id
    AND    e.hire_date < m.hire_date
    ORDER  BY m.hire_date;
  
  
  
  
  
  
  
