/* Tópico 7 */
/* Exercício 1 */

--a)

SELECT location_id,
       l.street_address,
       l.city,
       l.state_province,
       c.country_name
FROM   departments d NATURAL
JOIN   locations l NATURAL
JOIN   countries c;

SELECT l.location_id,
       l.street_address,
       l.city,
       l.state_province,
       c.country_name
FROM   departments d,
       locations   l,
       countries   c
WHERE  d.location_id = l.location_id
AND    l.country_id = c.country_id;

--b)

SELECT e.last_name,
       department_id,
       d.department_name
FROM   employees e
JOIN   departments d
USING  (department_id)
ORDER  BY e.last_name;

SELECT e.last_name,
       e.department_id,
       d.department_name
FROM   employees   e,
       departments d
WHERE  e.department_id = d.department_id
ORDER  BY e.last_name;

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

SELECT e.last_name,
       e.job_id,
       d.department_id,
       d.department_name
FROM   employees   e,
       departments d,
       locations   l
WHERE  e.department_id = d.department_id
AND    d.location_id = l.location_id
AND    LOWER(l.city) = 'toronto';

--d)

SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e
JOIN   employees m
ON     e.manager_id = m.employee_id;

SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e,
       employees m
WHERE  e.manager_id = m.employee_id;

--e)

SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e
LEFT   OUTER JOIN employees m
ON     e.manager_id = m.employee_id
ORDER  BY emp#;

SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e,
       employees m
WHERE  e.manager_id = m.employee_id(+)
ORDER  BY emp#;

--f)

SELECT department_id department,
       e.last_name   employee,
       c.last_name   colleague
FROM   employees e
JOIN   employees c
USING  (department_id)
WHERE  e.employee_id <> c.employee_id
ORDER  BY department,
          employee,
          colleague;

SELECT e.department_id department,
       e.last_name     employee,
       c.last_name     colleague
FROM   employees e,
       employees c
WHERE  e.department_id = c.department_id
AND    e.employee_id <> c.employee_id
ORDER  BY department,
          employee,
          colleague;

--g)

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
ORDER  BY 4 DESC;

SELECT e.last_name,
       e.job_id,
       d.department_name,
       e.salary,
       j.grade_level
FROM   employees   e,
       departments d,
       job_grades  j
WHERE  e.department_id = d.department_id
AND    e.salary BETWEEN j.lowest_sal AND j.highest_sal
ORDER  BY 4 DESC;

--h)

SELECT e.last_name,
       e.hire_date
FROM   employees e
JOIN   employees d
ON     e.hire_date > d.hire_date
WHERE  d.last_name = 'Davies';

SELECT e.last_name,
       e.hire_date
FROM   employees e,
       employees d
WHERE  e.hire_date > d.hire_date
AND    d.last_name = 'Davies';

--i)

SELECT e.last_name,
       e.hire_date,
       m.last_name last_name_1,
       m.hire_date hire_date_1
FROM   employees e
JOIN   employees m
ON     e.manager_id = m.employee_id
AND    e.hire_date < m.hire_date
ORDER  BY m.hire_date;

SELECT e.last_name,
       e.hire_date,
       m.last_name last_name_1,
       m.hire_date hire_date_1
FROM   employees e,
       employees m
WHERE  e.manager_id = m.employee_id
AND    e.hire_date < m.hire_date
ORDER  BY m.hire_date;

--ADICIONAIS

--j)

SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e
FULL   OUTER JOIN employees m
ON     e.manager_id = m.employee_id
ORDER  BY emp#;

SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e,
       employees m
WHERE  e.manager_id = m.employee_id(+)
UNION ALL
SELECT e.last_name   "Employee",
       e.employee_id emp#,
       m.last_name   "Manager",
       m.employee_id "Mgr#"
FROM   employees e,
       employees m
WHERE  e.manager_id(+) = m.employee_id
AND e.manager_id IS NULL
ORDER  BY emp#;
