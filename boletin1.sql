-- BOLETÍN 1 NESQUICK

-- 1
-- A
CREATE DATABASE IF NOT EXISTS practicas1;

-- B (antes USE fabricante;)
CREATE TABLE fabricante (
	idFabricante CHAR(5) NOT NULL COMMENT "Código que identifica a cada fabricante",
    nome VARCHAR(80) NOT NULL,
	CONSTRAINT fabricante_PK
		PRIMARY KEY (idFabricante)
);

-- 2
CREATE TABLE PELICULA (
	codPelicula INT AUTO_INCREMENT,
    anoRodaxe INT NULL,
    titulo VARCHAR(100) NOT NULL,
    xenero ENUM("drama", "comedia", "animación") NOT NULL,
    duracion DECIMAL(4,2) NOT NULL,
    CONSTRAINT PELICULA_PK
		PRIMARY KEY (codPelicula),
	CONSTRAINT PELICULA_duracion_mayor_a_0
		CHECK (duracion > 0)
);


CREATE TABLE NACIONALIDADE (
	codPelicula INT,
	nacionalidade VARCHAR(30),
    CONSTRAINT NACIONALIDADE_PK
		PRIMARY KEY (codPelicula),
	CONSTRAINT NACIONALIDADE_FK_PELICULA
		FOREIGN KEY (codPelicula) REFERENCES PELICULA(codPelicula)
);


-- 3
CREATE TABLE EQUIPO (
	codEquipo CHAR(9) COMMENT "Combinación de letras y números",
    nome VARCHAR(30) NOT NULL,
    director VARCHAR(40) NOT NULL,
    urlWeb VARCHAR(50) NOT NULL,
    CONSTRAINT EQUIPO_PK
		PRIMARY KEY (codEquipo)
);

CREATE TABLE CICLISTA (
	fichaFederativa CHAR(9) COMMENT "Lo que quieras poner de ficha explicación",
    dataNacemento DATE NOT NULL,
    nome VARCHAR(30) NOT NULL,
    apelidos VARCHAR(50) NOT NULL,
    codEquipo CHAR(9),
    CONSTRAINT CICLISTA_PK
		PRIMARY KEY (fichaFederativa),
	CONSTRAINT CICLISTA_FK_EQUIPO
		FOREIGN KEY (codEquipo) REFERENCES EQUIPO(codEquipo)
);

-- 4
CREATE TABLE GRUPO (
	codGrupo CHAR(9),
    nome VARCHAR(30) NOT NULL UNIQUE,
    cache DECIMAL(5,2) NOT NULL,
    dataFormacion DATE NOT NULL,
    CONSTRAINT GRUPO_PK
		PRIMARY KEY (codGrupo)
);

CREATE TABLE CONCERTO (
	codConcerto CHAR(9),
    nome VARCHAR(30) NOT NULL,
    data DATETIME NOT NULL,
    aforo INT NOT NULL,
    prezo DECIMAL(5,2) NOT NULL,
    CONSTRAINT CONCERTO_aforo_maximo
		CHECK(aforo <= 100000),
	CONSTRAINT CONCERTO_PK
		PRIMARY KEY (codCOncerto)
);

CREATE TABLE ACTUA (
	codGrupo CHAR(9),
    codConcerto CHAR(9),
    CONSTRAINT ACTUA_PK
		PRIMARY KEY (codGrupo,codConcerto),
	CONSTRAINT ACTUA_FK_GRUPO
		FOREIGN KEY (codGrupo) REFERENCES GRUPO(codGrupo),
	CONSTRAINT ACTUA_FK_CONCERTO
		FOREIGN KEY (codConcerto) REFERENCES CONCERTO(codConcerto)
);
	
-- 5
CREATE TABLE PISO (
	codPiso CHAR(9),
    domicilio VARCHAR(50) NOT NULL,
    localidade VARCHAR(50) NOT NULL,
    codigoPostal CHAR(5) NOT NULL,
    CONSTRAINT PISO_PK
		PRIMARY KEY (codPiso)
);

CREATE TABLE CONTADOR (
	codCOntador CHAR(9),
    modelo ENUM('aeg235', "samsung20", 'aeg55') NOT NULL,
    codPiso CHAR(9),
    CONSTRAINT CONTADOR_PK
		PRIMARY KEY (codContador),
	CONSTRAINT CONTADOR_FK_PISO
		FOREIGN KEY (codPiso) REFERENCES PISO(codPiso)
);




	


