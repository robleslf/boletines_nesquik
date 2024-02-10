-- Boletín 4-5 NESQUICK

-- 1

DROP DATABASE IF EXISTS practicas1;
CREATE DATABASE practicas1 CHARACTER SET latin1;
USE practicas1;
CREATE TABLE grupo (
    idGrupo       INT     UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    dataFormacion DATE    NOT NULL,
    nomeGrupo     VARCHAR(100) NOT NULL
);
CREATE TABLE fabricante (
    idFabricante    CHAR(5)      PRIMARY KEY,
    nome            VARCHAR(80),
    grupo           INT UNSIGNED,
    FOREIGN KEY (grupo) REFERENCES  grupo(idGrupo)
);

-- 1.a
ALTER TABLE fabricante 
	ADD COLUMN email VARCHAR(40) DEFAULT NULL,
    ADD COLUMN cif CHAR(9) NOT NULL AFTER idFabricante;
    
-- 1.b
ALTER TABLE fabricante
	DROP PRIMARY KEY,
    ADD CONSTRAINT fabricante_PK
		PRIMARY KEY (cif),
	DROP COLUMN idFabricante,
    RENAME COLUMN nome TO nmb;

-- 1.c
ALTER TABLE grupo
	ALTER COLUMN dataFormacion SET DEFAULT 0;

-- 2
-- 2.a
CREATE TABLE DEPARTAMENTO (
	codigoDepartamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    localizacion VARCHAR(20) NOT NULL
);



CREATE TABLE EMPREGADO (
	dni CHAR(9) PRIMARY KEY,
    nss CHAR(12) NOT NULL UNIQUE,
    nome VARCHAR(30) NOT NULL,
    dataNacemento DATE NOT NULL,
    sexo ENUM("M","F","H") NOT NULL COMMENT "M de masculino, F de femenino, H para hermafrodita",
    salario DECIMAL (7,2) NOT NULL, 
    codDepartamentoTraballa INT NOT NULL,
    codDepartamentoDirixe INT NULL,
    CONSTRAINT EMPREGADO_FK_DEPARTAMENTO_TRABALLA
		FOREIGN KEY (codDepartamentoTraballa) REFERENCES DEPARTAMENTO(codigoDepartamento)
			ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	CONSTRAINT EMPREGADO_FK_DEPARTAMENTO_DIRIXE
		FOREIGN KEY (codDepartamentoDirixe) REFERENCES DEPARTAMENTO(codigoDepartamento)
			ON UPDATE RESTRICT
            ON DELETE RESTRICT
);


-- 2.b DROP TABLE EMPREGADO; DROP TABLE DEPARTAMENTO; si es necesario
CREATE TABLE DEPARTAMENTO (
	codigoDepartamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    localizacion VARCHAR(20) NOT NULL,
    dniEmpregadoDirixe CHAR(9) NOT NULL
);



CREATE TABLE EMPREGADO (
	dni CHAR(9) PRIMARY KEY,
    nss CHAR(12) NOT NULL UNIQUE,
    nome VARCHAR(30) NOT NULL,
    dataNacemento DATE NOT NULL,
    sexo ENUM("M","F","H") NOT NULL COMMENT "M de masculino, F de femenino, H para hermafrodita",
    salario DECIMAL (7,2) NOT NULL, 
    codDepartamentoTraballa INT NOT NULL
);

ALTER TABLE DEPARTAMENTO
	ADD CONSTRAINT DEPARTAMENTO_FK_EMPREGADO
		FOREIGN KEY (dniEmpregadoDirixe) REFERENCES EMPREGADO(dni)
			ON UPDATE RESTRICT
            ON DELETE RESTRICT;
        
ALTER TABLE EMPREGADO
	ADD CONSTRAINT EMPREGADO_FK_DEPARTAMENTO
		FOREIGN KEY (codDepartamentoTraballa) REFERENCES DEPARTAMENTO(codigoDepartamento)
			ON DELETE RESTRICT
            ON UPDATE RESTRICT;

-- 2.c
SET foreign_key_checks = 0;

DROP TABLE IF EXISTS DEPARTAMENTO;
DROP TABLE IF EXISTS EMPREGADO;

CREATE TABLE DEPARTAMENTO (
	codigoDepartamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    localizacion VARCHAR(20) NOT NULL,
    dniEmpregadoDirixe CHAR(9) NOT NULL,
    CONSTRAINT DEPARTAMENTO_FK_EMPREGADO
		FOREIGN KEY (dniEmpregadoDirixe) REFERENCES EMPREGADO(dni)
			ON DELETE RESTRICT
            ON UPDATE RESTRICT
);



CREATE TABLE EMPREGADO (
	dni CHAR(9) PRIMARY KEY,
    nss CHAR(12) NOT NULL UNIQUE,
    nome VARCHAR(30) NOT NULL,
    dataNacemento DATE NOT NULL,
    sexo ENUM("M","F","H") NOT NULL COMMENT "M de masculino, F de femenino, H para hermafrodita",
    salario DECIMAL (7,2) NOT NULL, 
    codDepartamentoTraballa INT NOT NULL,
    CONSTRAINT EMPREGADO_FK_DEPARTAMENTO
		FOREIGN KEY (codDepartamentoTraballa) REFERENCES DEPARTAMENTO(codigoDepartamento)
			ON DELETE RESTRICT
            ON UPDATE RESTRICT
);

SET foreign_key_checks = 1;


-- 3

-- 3.a
CREATE DATABASE IF NOT EXISTS eleccionModulos;
USE eleccionModulos;

-- 3.b
CREATE TABLE PROFESOR (
	idProfesor CHAR(15) NOT NULL PRIMARY KEY COMMENT "Nome curto do profesor",
    corpo ENUM("S","T") NOT NULL COMMENT "Corpo ao que pertenece. Valores permitidos: S= Profesorado Secundaria T= Profesorado Técnico",
    nrp CHAR(20) NOT NULL UNIQUE COMMENT "Número de Rexistro Persoal",
    nome VARCHAR(20) NOT NULL,
    apelidos VARCHAR(60) NOT NULL,
    horasLectivos SMALLINT UNSIGNED COMMENT "Nº de horas de clase que impartye o profesor. Por decto: 18" DEFAULT 18,
    INDEX indx_apelidos (apelidos)
);

CREATE TABLE GRUPO (
	idGrupo CHAR(15) NOT NULL PRIMARY KEY COMMENT "Clave para identificar o grupo",
    descricion VARCHAR(100) NOT NULL COMMENT "Descricion do nome do grupo",
    horasTitoria SMALLINT UNSIGNED COMMENT "Nº de horas de redución para o profesor titor",
    idProfesor CHAR(15) COMMENT "Identyificador do profesor que é titor do grupo"
);


CREATE TABLE MODULO (
	idModulo CHAR(6) NOT NULL PRIMARY KEY COMMENT "Clave para identificar o módulo",
    horasSemanais TINYINT UNSIGNED COMMENT "Descrición do nome do grupo",
    corpo ENUM("S","T") NOT NULL COMMENT "Corpo dos profesores que poden impartir o módulo. Valores permitidos: S=Profesorado Secundaria T=Profesorado Técnico"
);

CREATE TABLE IMPARTE (
	idModulo CHAR(6) NOT NULL COMMENT "Clave para identificar o módulo",
    idGrupo CHAR(15) NOT NULL COMMENT "Clave para identificar o grupo",
    idProfesor CHAR(15) NOT NULL COMMENT "Nome curto do profesor",
	CONSTRAINT IMPARTE_PK
		PRIMARY KEY (idModulo, idGrupo, idProfesor)
);


-- 3.c

ALTER TABLE IMPARTE
	ADD CONSTRAINT IMPARTE_FK_MODULO
		FOREIGN KEY (idModulo) REFERENCES MODULO(idModulo)
			ON DELETE RESTRICT
            ON UPDATE CASCADE,
	ADD CONSTRAINT IMPARTE_FK_GRUPO 
		FOREIGN KEY (idGrupo) REFERENCES GRUPO(IDgRUPO)
			ON DELETE RESTRICT
            ON UPDATE CASCADE,
	ADD CONSTRAINT IMPARTE_FK_PROFESOR
		FOREIGN KEY (idProfesor) REFERENCES PROFESOR(idProfesor)
			ON DELETE RESTRICT
            ON UPDATE CASCADE;
            
ALTER TABLE GRUPO
	ADD CONSTRAINT GRUPO_FK_PROFESOR
		FOREIGN KEY (idProfesor) REFERENCES PROFESOR(idProfesor)
			ON DELETE RESTRICT
            ON UPDATE CASCADE;



















