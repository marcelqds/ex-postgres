 
CREATE OR REPLACE VIEW vw_bancos AS (
    SELECT numero, nome, ativo
    FROM banco
);

SELECT numero, nome, ativo
FROM vw_bancos;

CREATE OR REPLACE VIEW vw_bancos (banco_numero, banco_nome, banco_ativo) AS (
    SELECT numero, nome, ativo
    FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos;

-- INSERT UPDATE DELETE

INSERT INTO vw_bancos (numero, nome, ativo) VALUES (100, 'Banco CEM', TRUE);

UPDATE vw_bancos SET nome = 'Banco 100' WHERE numero = 100;

DELETE FROM vw_bancos WHERE numero = 100;

-- TEMPORARY

CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
    SELECT numero, nome
    FROM agencia
);

SELECT numero, nome
FROM vw_agencia

-- RECURSIVE

CREATE TABLE IF NOT EXISTS funcionarios (
    id SERIAL NOT NULL,
    nome VARCHAR(50),
    gerente INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (gerente) REFERENCES funcionarios (id)
);

INSERT INTO funcionarios (nome, gerente) VALUES ('Ancelmo',null);
INSERT INTO funcionarios (nome, gerente) VALUES ('Beatriz',1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Magno',1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Cremilda',2);
INSERT INTO funcionarios (nome, gerente) VALUES ('Wagner',4);

SELECT id, nome, gerente FROM funcionarios WHERE gerente IS NULL;
--ID  NOME    GERENTE
--1   Ancelmo 

SELECT id, nome, gerente FROM funcionarios WHERE id= 999;
--ID    NOME    GERENTE

-- UNION ALL
SELECT id, nome, gerente FROM funcionarios WHERE gerente IS NULL
UNION ALL
SELECT id, nome, gerente FROM funcionarios WHERE id = 999
--ID  NOME    GERENTE
--1   Ancelmo 

CREATE OR REPLACE RECURSIVE VIEW vw_funcionarios (id, gerente, funcionario) AS (
    SELECT id, gerente, nome
    FROM funcionarios
    WHERE gerente is NULL
    UNION ALL
    SELECT fun.id, fun.gerente, fun.nome
    FROM funcionarios fun
    JOIN vw_funcionarios vwf ON vwf.id = fun.gerente
);

SELECT id, gerente, funcionario 
FROM vw_funcionarios;

CREATE OR REPLACE RECURSIVE VIEW vw_funcionarios (id, gerente, funcionarios) AS (
    SELECT id, CAST('' AS VARCHAR) AS gerente, nome
    FROM funcionarios
    WHERE gerente IS NULL
    UNION ALL
    SELECT fun.id, ger.nome, fun.nome
    FROM funcionarios fun
    JOIN vw_funcionarios vwf ON vwf.id = fun.gerente
    JOIN funcionarios ger ON ger.id = vwf.id
);

SELECT id, gerente, funcionario
FROM vw_funcionarios;


-- WITH OPTIONS

CREATE OR REPLACE VIEW vw_bancos_ativos AS (
    SELECT numero, nome, ativo
    FROM banco
    WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_bancos_ativos(5698,'Teste Digital',FALSE);
-- ERRO

CREATE OR REPLACE VIEW vw_bancos_maiores_que_100 AS (
    SELECT numero, nome, ativo
    FROM vw_bancos_ativos
    WHERE numero > 100
) WITH LOCAL CHECK OPTION;

INSERT INTO vw_bancos_maiores_que_100 (numero, nome, ativo) VALUES(99,'Banco DIO', FALSE);
-- ERRO
INSERT INTO vw_bancos_maiores_que_100 (numero, nome, ativo) VALUES(200,'Banco DIO', FALSE);
-- ERRO



CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
    SELECT nome 
    FROM agencia
);
SELECT nome FROM vw_gencia;

CREATE OR REPLACE VIEW vw_bancos_com_a AS (
    SELECT numero, nome, ativo
    FROM vw_bancos_ativos
    WHERE nome ILIKE 'a%'
) WITH LOCAL CHECK OPTION;
-- WITH CASCADED CHECK OPTION;

SELECT numero, nome, ativo FROM vw_bancos_com_a;

INSERT INTO vw_bancos_com_a (numero, nome, ativo) VALUES (331,'Alfa Ommega',true);
INSERT INTO vw_bancos_com_a (numero, nome, ativo) VALUES (332,'Gama',true);

