/*
******************************Exercícios Treinamento************************
-- Nome: Matheus Silva Portes de Lima
-- Módulo: SQL Analytics
-- Data: 25/10/2022
-- Tópico: SQL Analytics
-- Instrutor: Gabriel Kazuki Onishi
****************************************************************************
*/

CREATE TABLE blocos (
  id INTEGER,
  cor VARCHAR2(10),
  formato VARCHAR2(10),
  peso INTEGER
);

INSERT INTO blocos VALUES ( 1, 'azul', 'quadrado', 1 );
INSERT INTO blocos VALUES ( 2, 'azul', 'triangulo', 2 );
INSERT INTO blocos VALUES ( 3, 'vermelho', 'quadrado', 1 );
INSERT INTO blocos VALUES ( 4, 'vermelho', 'quadrado', 2 );
INSERT INTO blocos VALUES ( 5, 'vermelho', 'triangulo', 3 );
INSERT INTO blocos VALUES ( 6, 'verde', 'triangulo', 1 );

COMMIT;

/*Exercício 1*/

  SELECT b.*,
         COUNT(0) OVER(PARTITION BY cor) total_qtd_cor,
         SUM(peso) OVER(PARTITION BY cor) total_peso_cor
  FROM   blocos b;

  SELECT DISTINCT cor,
                  COUNT(0) OVER(PARTITION BY cor) qtd_cor,
                  SUM(peso) OVER(PARTITION BY cor) peso_cor
  FROM   blocos;

/*Exercício 2*/

  SELECT b.*,
         COUNT(0) OVER(PARTITION BY formato) total_qtd_formato,
         AVG(peso) OVER(PARTITION BY formato) total_peso_formato
  FROM   blocos b;

  SELECT DISTINCT formato,
                  COUNT(0) OVER(PARTITION BY formato) qtd_formato,
                  AVG(peso) OVER(PARTITION BY formato) peso_formato
  FROM   blocos;

/*Exercício 3*/

  SELECT b.*,
         COUNT(0) OVER(ORDER BY id) qtd_acumulada,
         SUM(peso) OVER(ORDER BY id) peso_acumulado
  FROM   blocos b;

  -- Garantia que acumule a cada linha, e não a cada valor:

  SELECT b.*,
         COUNT(0) OVER(ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) qtd_acumulada,
         SUM(peso) OVER(ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) peso_acumulado
  FROM   blocos b;

/*Exercício 4*/

  SELECT b.*, AVG(peso) OVER (ORDER BY id) peso_medio_cor
  FROM blocos b;
  
  -- Garantia que acumule a cada linha, e não a cada valor:
  
  SELECT b.*, AVG(peso) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) peso_medio_cor
  FROM blocos b;

/*Exercício 5*/

  SELECT b.*,
         COUNT(0) OVER(PARTITION BY cor ORDER BY id) qtd_acumulada,
         SUM(peso) OVER(PARTITION BY cor ORDER BY id) peso_acumulado
  FROM   blocos b;
  
  -- Garantia que acumule a cada linha, e não a cada valor:
  
  SELECT b.*,
         COUNT(0) OVER(PARTITION BY cor ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) qtd_acumulada,
         SUM(peso) OVER(PARTITION BY cor ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) peso_acumulado
  FROM   blocos b;

/*Exercício 6*/

  SELECT b.*,
         NVL(SUM(peso) OVER (ORDER BY peso RANGE BETWEEN UNBOUNDED
                  PRECEDING AND 1 PRECEDING) peso_acum_menor_que_atual,
             0)
  FROM   blocos b;
  
  SELECT b.*,
         NVL(SUM(peso) OVER(ORDER BY peso DESC RANGE BETWEEN 1
                  FOLLOWING AND UNBOUNDED FOLLOWING),
             0) peso_acum_menor_que_atual
  FROM   blocos b;

/*Exercício 7*/

  SELECT b.*,
         COUNT(0) OVER(PARTITION BY b.cor) quantidade_por_cor
  FROM   blocos b
  WHERE  1 < (SELECT DISTINCT COUNT(0) OVER(PARTITION BY b.cor)
              FROM   blocos l
              WHERE  b.cor = l.cor)
  ORDER  BY b.id;

  WITH qtde_cor AS
   (SELECT id,
           COUNT(0) OVER(PARTITION BY cor) qtde
    FROM   blocos)
  SELECT b.*,
         q.qtde
  FROM   blocos   b,
         qtde_cor q
  WHERE  q.qtde > 1
  AND    b.id = q.id
  ORDER  BY b.id;

/*Exercício 8*/

  SELECT b.*,
         SUM(peso) OVER(PARTITION BY b.formato) peso_total_formato
  FROM   blocos b
  WHERE  4 < (SELECT DISTINCT SUM(peso) OVER(PARTITION BY b.formato)
              FROM   blocos l
              WHERE  b.formato = l.formato)
  ORDER  BY b.id;
  
  WITH peso_formato AS
   (SELECT id,
           SUM(peso) OVER(PARTITION BY formato) peso_total_formato
    FROM   blocos)
  SELECT b.*,
         p.peso_total_formato
  FROM   blocos   b,
         peso_formato p
  WHERE  p.peso_total_formato > 4
  AND    b.id = p.id
  ORDER  BY b.id;

/*Exercício 9*/

  SELECT b.*,
         FIRST_VALUE(formato) OVER(ORDER BY id) form_primeiro_bloco,
         LAST_VALUE(peso) OVER() peso_ultimo_bloco
  FROM   blocos b;
