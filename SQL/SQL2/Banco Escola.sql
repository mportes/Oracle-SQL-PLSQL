-- BANCO DE DADOS ESCOLA

CREATE TABLE usuario
(
  prontuario VARCHAR(10) NOT NULL,
  nome VARCHAR(255) NOT NULL,
  cpf NUMBER(11) NOT NULL,
  data_nascimento DATE NOT NULL,
  status_matricula CHAR(1) DEFAULT 'S' NOT NULL ,
  ira NUMBER(4,2),
  lattes VARCHAR(255),
  tipo CHAR(1) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY (prontuario);

ALTER TABLE usuario ADD CONSTRAINT usuario_cpf_unique UNIQUE (cpf);

ALTER TABLE usuario ADD CHECK (ira BETWEEN 0 AND 10);

---------------------------------------------------------------------------------------------------------

CREATE TABLE departamento
(
  codigo VARCHAR(5) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  diretor VARCHAR(10)
);

ALTER TABLE departamento ADD CONSTRAINT dept_pk PRIMARY KEY (codigo);

ALTER TABLE departamento ADD CONSTRAINT dept_diretor_unique UNIQUE (diretor);

ALTER TABLE departamento ADD CONSTRAINT dept_usuario_diretor_fk FOREIGN KEY (diretor) REFERENCES usuario(prontuario);

---------------------------------------------------------------------------------------------------------

CREATE TABLE curso
(
  codigo VARCHAR(10) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  carga_horaria NUMBER(5,3),
  dept_codigo VARCHAR(5) NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY (codigo);

ALTER TABLE curso ADD CONSTRAINT curso_dept_fk FOREIGN KEY (dept_codigo) REFERENCES departamento(codigo);

ALTER TABLE curso ADD CHECK (carga_horaria >= 0);

---------------------------------------------------------------------------------------------------------

CREATE TABLE turma
(
  curso_codigo VARCHAR(10) NOT NULL,
  periodo CHAR(1) NOT NULL,
  termo NUMBER(1) DEFAULT 1 NOT NULL,
  subturma CHAR(1) NOT NULL,
  data_inicio DATE,
  previsao_fim DATE
);

ALTER TABLE turma ADD CONSTRAINT turma_pk PRIMARY KEY (curso_codigo, periodo, termo, subturma);

ALTER TABLE turma ADD CONSTRAINT turma_curso_fk FOREIGN KEY (curso_codigo) REFERENCES curso(codigo);

ALTER TABLE turma ADD CHECK (previsao_fim > data_inicio);

---------------------------------------------------------------------------------------------------------

CREATE TABLE disciplina
(
  codigo VARCHAR(50) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  dept_codigo VARCHAR(5) NOT NULL
);

ALTER TABLE disciplina ADD CONSTRAINT disc_pk PRIMARY KEY (codigo);

ALTER TABLE disciplina ADD CONSTRAINT disc_dept_fk FOREIGN KEY (dept_codigo) REFERENCES departamento(codigo);

---------------------------------------------------------------------------------------------------------

CREATE TABLE carga_horaria
(
  disc_codigo VARCHAR(50) NOT NULL,
  curso_codigo VARCHAR(10) NOT NULL,
  carga NUMBER(5,2) NOT NULL,
  data_inicio DATE,
  data_fim DATE
);

ALTER TABLE carga_horaria ADD CONSTRAINT ch_unique UNIQUE (disc_codigo, curso_codigo, data_inicio);

ALTER TABLE carga_horaria ADD CONSTRAINT ch_disc_fk FOREIGN KEY (disc_codigo) REFERENCES disciplina(codigo);

ALTER TABLE carga_horaria ADD CONSTRAINT ch_curso_fk FOREIGN KEY (curso_codigo) REFERENCES curso(codigo);

ALTER TABLE carga_horaria ADD CHECK (data_fim > data_inicio);

---------------------------------------------------------------------------------------------------------

CREATE TABLE aula
(
  data DATE NOT NULL,
  disc_codigo VARCHAR(50) NOT NULL,
  aluno_prontuario VARCHAR(10) NOT NULL,
  presenca CHAR(1) DEFAULT 'S' NOT NULL
);

ALTER TABLE aula ADD CONSTRAINT aula_pk PRIMARY KEY (data, disc_codigo, aluno_prontuario);

ALTER TABLE aula ADD CONSTRAINT aula_disc_fk FOREIGN KEY (disc_codigo) REFERENCES disciplina(codigo);

ALTER TABLE aula ADD CONSTRAINT aula_usuario_aluno_fk FOREIGN KEY (aluno_prontuario) REFERENCES usuario(prontuario);

---------------------------------------------------------------------------------------------------------


CREATE TABLE prof_disc_dept
(
  prof_prontuario VARCHAR(10),
  disc_codigo VARCHAR(50),
  dept_codigo VARCHAR(5) NOT NULL
);

ALTER TABLE prof_disc_dept ADD CONSTRAINT pdd_unique UNIQUE (prof_prontuario, disc_codigo, dept_codigo);

ALTER TABLE prof_disc_dept ADD CONSTRAINT pdd_usuario_prof_fk FOREIGN KEY (prof_prontuario) REFERENCES usuario(prontuario);

ALTER TABLE prof_disc_dept ADD CONSTRAINT pdd_disc_fk FOREIGN KEY (disc_codigo) REFERENCES disciplina(codigo);

ALTER TABLE prof_disc_dept ADD CONSTRAINT pdd_dept_fk FOREIGN KEY (dept_codigo) REFERENCES departamento(codigo);

---------------------------------------------------------------------------------------------------------

CREATE TABLE aluno_disc 
(
  disc_codigo VARCHAR(50) NOT NULL,
  aluno_prontuario VARCHAR(10) NOT NULL,
  data_inicio DATE NOT NULL,
  data_fim DATE,
  media_geral NUMBER(4,2),
  horario DATE,
  carga_cumprida NUMBER(5,2)
);

ALTER TABLE aluno_disc ADD CONSTRAINT ad_pk PRIMARY KEY (disc_codigo, aluno_prontuario, data_inicio);

ALTER TABLE aluno_disc ADD CONSTRAINT ad_disc_fk FOREIGN KEY (disc_codigo) REFERENCES disciplina(codigo);

ALTER TABLE aluno_disc ADD CONSTRAINT ad_usuario_aluno_fk FOREIGN KEY (aluno_prontuario) REFERENCES usuario(prontuario);

ALTER TABLE aluno_disc ADD CHECK (data_fim > data_inicio);

ALTER TABLE aluno_disc ADD CHECK (media_geral BETWEEN 0 AND 10);

---------------------------------------------------------------------------------------------------------

CREATE TABLE turma_aluno
(
  aluno_prontuario VARCHAR(10) NOT NULL,
  turma_curso_codigo VARCHAR(10) NOT NULL,
  turma_periodo CHAR(1) NOT NULL,
  turma_termo NUMBER(1) NOT NULL,
  turma_subturma CHAR(1) NOT NULL
);

ALTER TABLE turma_aluno ADD CONSTRAINT ta_pk PRIMARY KEY (aluno_prontuario, turma_curso_codigo, turma_periodo, turma_termo, turma_subturma);

ALTER TABLE turma_aluno ADD CONSTRAINT ta_usuario_aluno_fk FOREIGN KEY (aluno_prontuario) REFERENCES usuario(prontuario);

ALTER TABLE turma_aluno ADD CONSTRAINT ta_turma_fk FOREIGN KEY (turma_curso_codigo, turma_periodo, turma_termo, turma_subturma) REFERENCES turma(curso_codigo, periodo, termo, subturma);

---------------------------------------------------------------------------------------------------------

CREATE TABLE curso_disc
(
  disc_codigo VARCHAR(50) NOT NULL,
  curso_codigo VARCHAR(10) NOT NULL
);

ALTER TABLE curso_disc ADD CONSTRAINT cd_pk PRIMARY KEY (disc_codigo, curso_codigo);

ALTER TABLE curso_disc ADD CONSTRAINT cd_disc_fk FOREIGN KEY (disc_codigo) REFERENCES disciplina(codigo);

ALTER TABLE curso_disc ADD CONSTRAINT cd_curso_fk FOREIGN KEY (curso_codigo) REFERENCES curso(codigo);

---------------------------------------------------------------------------------------------------------

