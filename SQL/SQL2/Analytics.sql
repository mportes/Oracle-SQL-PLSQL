SELECT empno,
       deptno,
       sal,
       AVG(sal) OVER(PARTITION BY deptno) AS avg_sal
FROM   emp;

SELECT empno,
       deptno,
       sal,
       FIRST_VALUE(sal IGNORE NULLS) OVER(PARTITION BY deptno) AS first_sal_in_dept
FROM   emp;

SELECT empno,
       deptno,
       sal,
       FIRST_VALUE(sal IGNORE NULLS) OVER(PARTITION BY deptno ORDER BY sal ASC NULLS LAST) AS first_val_in_dept
FROM   emp;

SELECT empno,
       deptno,
       sal,
       AVG(sal) OVER(PARTITION BY deptno ORDER BY sal) AS avg_dept_sal_sofar
FROM   emp;

SELECT empno,
       deptno,
       sal,
       AVG(sal) OVER(PARTITION BY deptno ORDER BY sal RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_avg,
       AVG(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_avg
FROM   emp;

SELECT empno,
       deptno,
       sal,
       FIRST_VALUE(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS previous_sal,
       LAST_VALUE(sal) OVER(ORDER BY sal ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_sal
FROM   emp;

SELECT empno,
       deptno,
       sal,
       RANK() OVER(PARTITION BY deptno ORDER BY sal) AS myrank
FROM   emp;

SELECT *
FROM   (SELECT empno,
               deptno,
               sal,
               RANK() OVER(PARTITION BY deptno ORDER BY sal) AS myrank
        FROM   emp)
WHERE  myrank <= 2;

SELECT empno,
       deptno,
       sal,
       DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) AS myrank
FROM   emp;

SELECT *
FROM   (SELECT empno,
               deptno,
               sal,
               DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) AS myrank
        FROM   emp)
WHERE  myrank <= 2;

SELECT empno,
       deptno,
       sal,
       FIRST_VALUE(sal) IGNORE NULLS OVER(PARTITION BY deptno ORDER BY sal) AS lowest_in_dept
FROM   emp;

SELECT empno,
       deptno,
       sal,
       LAST_VALUE(sal) IGNORE NULLS OVER(PARTITION BY deptno ORDER BY sal) AS highest_in_dept
FROM   emp;

SELECT empno,
       deptno,
       sal,
       LAST_VALUE(sal) IGNORE NULLS OVER(PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_in_dept
FROM   emp;

SELECT empno,
       ename,
       deptno,
       sal,
       ROW_NUMBER() OVER(ORDER BY sal) AS row_num,
       RANK() OVER(ORDER BY sal) AS row_rank,
       DENSE_RANK() OVER(ORDER BY sal) AS row_dense_rank
FROM   emp;

SELECT empno,
       ename,
       deptno,
       sal,
       ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS row_num
FROM   emp;

SELECT *
FROM   (SELECT empno,
               ename,
               deptno,
               sal,
               ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) AS row_num
        FROM   emp)
WHERE  row_num = 1;

SELECT empno,
       ename,
       deptno,
       sal,
       MAX(sal) OVER() AS max_sal
FROM   emp;

SELECT empno,
       ename,
       deptno,
       sal,
       MAX(sal) OVER(PARTITION BY deptno) AS max_sal_by_dept
FROM   emp;

SELECT empno,
       ename,
       deptno,
       sal,
       MIN(sal) OVER() AS min_sal
FROM   emp
ORDER  BY deptno;

SELECT empno,
       ename,
       deptno,
       sal,
       MIN(sal) OVER(PARTITION BY deptno) AS min_sal_by_dept
FROM   emp;

------------------------------------------------------------

SELECT val
FROM   rownum_order_test
WHERE  rownum <= 5
ORDER  BY val DESC;

SELECT *
FROM   (SELECT val
        FROM   rownum_order_test
        ORDER  BY val DESC)
WHERE  ROWNUM <= 5;

SELECT val
FROM   rownum_order_test
ORDER  BY val DESC
FETCH  FIRST 5 ROWS ONLY;

SELECT val
FROM   (SELECT val,
               rownum AS rnum
        FROM   (SELECT val
                FROM   rownum_order_test
                ORDER  BY val)
        WHERE  rownum <= 8)
WHERE  rnum >= 4;

WITH ordered_query AS
 (SELECT val
  FROM   rownum_order_test
  ORDER  BY val DESC)
SELECT val
FROM   ordered_query
WHERE  rownum <= 5;

------------------------------------------------------------

SELECT deptno,
       LISTAGG(ename, ',') WITHIN GROUP(ORDER BY ename) AS employees
FROM   emp
GROUP  BY deptno
ORDER  BY deptno;

SELECT deptno,
       LISTAGG(ename, ',') WITHIN GROUP(ORDER BY ename) AS employees
FROM   emp
CROSS  JOIN (SELECT LEVEL
             FROM   dual
             CONNECT BY LEVEL <= 1000)
WHERE  deptno = 30
GROUP  BY deptno
ORDER  BY deptno;
--erro por exceder o tamanho do retorno da função

SELECT deptno, LISTAGG(ename, ',' ON OVERFLOW ERROR) WITHIN GROUP (ORDER BY ename) AS employees
FROM emp
CROSS JOIN (SELECT level FROM dual CONNECT BY level <= 1000)
WHERE deptno = 30
GROUP BY deptno
ORDER BY deptno;
--mesma coisa, mas com o ON OVERFLOW ERROR explícito
