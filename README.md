# Dado 
Informação sem valor algum

## Informação
Quando um determinado dado passa a fazer parte de algum grupo

## Arquivo postgresql.conf
Encontra-se dentro do diretório PGDATA, mas caso tenha sido feita a instalação através do repositório oficial no ubuntu `/etc/postgresql/[versao]/[nome_cluster]/postgresql.conf`
Podemos visualizar as configurações atuais acessando a `view pg_settings`
```sql
select name, setting FROM  pg_settings
```
Ou dentro do banco
```shell
SHOW [parâmetro]
```
## Configurações 
LISTEN_ADDRESSES
Endereços que será liberado escuta/conexão

PORT
Porta default `5432`

## Arquivo pg_hba.conf
Controle de autenticação dos usuários. Pode determinar o ip que terá direito ao acesso

### O Formato do arquivo pode ser:
local database user auth-method [auth-options]
host database user address auth-method [auth-options]
host database user ip-address ip-mask auth-method [auth-options]

- Exemplo
host all all 127.0.0.1/32 md5


### Métodos de autenticação
TRUST -> Sem requisição de senha
REJECT -> rejeitar conexões
MD5 -> criptografia md5
PASSOWRD -> senha sem criptografia
GSS -> generic security service application program interface
SSPI -> security support provider interface - somente para windows
KRB5 -> kerberos v5
IDENT -> utiliza o usuário do sistema operacional do cliente via ident server
PEER -> utiliza o usuário do sistema do cliente
LDAP -> ldap server
RADIUS -> radius server
CERT -> autenticação via certificado ssl do cliente
PAM -> pluggable authentication modules. O usuário precisa esta no 

## Arquivo pg_ident.conf
Mapear usuário do sitema operacional com os usuários do banco de dados
É necessário habilitar o ident no arquivo `pg_hba.conf`

Formato
MAPNAME     SYSTEM-USERNAME PG-USERNAME
diretoria   marcelo         pg_marcelo

## Comandos administrativos
`pg_lsclusters` -> Lista todos os cluters PostgreSQL
`pg_createcluster <version><cluster name>` -> Cria um novo cluster
`pg_dropcluster <version><cluster>` -> Apaga um cluster PostgreSQL
`pg_ctlcluster <version><cluster><action>` -> Start, Stop, Status, Restart de clusters

### Binários
- createtb
- createuser
- dropdb
- dropuser
- initdb
- pg_ctl
- pg_basebackup
- pg_dump / pg_dumpall
- pg_restore
- psql
- reindexdb
- vacuumdb

## Cluster
Coleção de banco de dados que compartilham as mesmas configurações.

## Banco de dados
Conjunto de schemas com seus objetos/relações (tabelas, funções, views, e etc..)

## Schema
Conjunto de objetos/relações (tabelas, funções, views, e etc...)

## Se conectar ao banco através do psql
Por padrão ao executar o psql sem nenhuma informação adicional,
ele tente executar para o host local, porta defaul(5432) e usuário postgres, já tentendo acessar o banco com o menos nome do usuário

```shell
psql -h 127.0.0.1 -p 5432 -U postgres 
```

## Database, Schemas e Objetos

Database
`CREATE DATABASE name`

ALTER DATABASE name RENAME TO new_name
ALTER DATABASE name OWNER TO {new_owner | CURRENT_USER | SESSION_USER}
ALTER DATABASE SET TABLESPACE new_tablespace

DROP DATABASE name

Schema
Por padrão quando é criado um novo banco de dados, já é criado um schema public, mas caso queira criar um novo schema.
CREATE SCHEMA schema_name [AUTHORIZATION role_specification ]

ALTER SCHEMA name RENAME TO new_schema_name

Melhores práticas
CREATE SCHEMA IF NOT EXISTS schema_name [ AUTHORIZATION role_specification ]
DROP SCHEMA IF EXISTS [name];

### DML (Data Manipulation Language)
INSERT, UPDATE, DELETE, *SELECT

### DDL (Data Definition Language)
CREATE, ALTER, DROP

CREATE [object] [object name] [options]
ALTER [object] [object name] [options]
DROP [object] [object name] [options]

CREATE DATABASE dadosbancarios;
ALTER DATABASE dadosbancarios OWNER TO diretoria;
DROP DATABASE dadosbancarios;

CREATE SCHEMA IF NOT EXISTS bancos;
ALTER SCHEMA bancos OWNER TO diretoria;
DROP SCHEMA IF EXISTS bancos;

CREATE TABLE [IF NOT EXISTS ] [table name](
    [field name] [type] [role] [options],
    [field name] [type] [role] [options]
);

ALTER TABLE [table name] [options];

DROP TABLE [table name];

CREATE TABLE IF NOT EXISTS banco(
    codigo INTEGER PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
);

CREATE TABLE IF NOT EXISTS banco(
    codigo INTEGER,
    nome VARCHAR(50) NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY(codigo)
);

ALTER TABLE banco ADD COLUMN tem_poupanca BOOLEAN;

DROP TABLE IF EXISTS banco;


#### INSERT
INSERT INTO [table name] ([fields table,])
VALUES ([values to fields in order fields table,]);

INSERT INTO [nome da table] ([campos da tabela,])
SELECT [valores de acordo com a ordem dos campos acima,];

INSERT INTO banco (codigo, nome, data_criacao)
VALUES(100, 'Banco do Brasil', now());

INSERT INTO banco (codigo, nome, data_criacao)
SELECT 100, 'Banco do Brasil', now();

#### UPDATE
UPDATE [table name] SET
[field1] = [new field1 value],
[field2] = [new field2 value]
...
[WHERE + conditions]

Atenção: Sempre utilize-os com condição

UPDATE banco SET
codigo = 500
WHERE codigo = 100;

UPDATE banco SET
data_criacao = now()
WHERE data_criacao IS NULL;

#### DELETE
DELETE FROM [table name]
[WHERE + conditions]

Atenção: Sempre utilize-os com condição.

DELETE FROM banco
WHERE codigo = 512;

DELETE FROM banco
WHERE nome = 'Conta Digital';

#### SELECT
SELECT [fields table]
FROM [table name]
[WHERE + conditions]

Boas práticas: Evite sempre que puder o SELECT *..

SELECT codigo, nome
FROM banco;

SELECT codigo, nome
FROM banco
WHERE data_criacao > '2022-10-12 10:00:00';

#### Revisão
PK
FK
Tipos de dados
DDL
DML

### Idempotência
Propriedade que algumas ações/operações possuem possibilitando-as de serem executadas diversas vezes sem alterar o resultado após aplicação inicial.
- IF EXISTS / IF NOT EXISTS (possibilita executar um comando mais de uma vez sem que ocorra erro ao executá-lo)
No caso de criação de banco de dados, tabela, é uma boa prática utilizar da idempotência.
Comandos pertinentes ao DDL e DML

#### Melhores práticas em DDL
Criar campos que realmente serão utilizados e que sirvam de atributo direto a um objetivo em comum.
- Cuidado com tamanho indevio de colunas: Ex: CEP VARCHAR(255)
- Criar/Acrescentar colunas que são "atributos básicos" do objeto;
- Cuidado com regras (constraints);
- Cuidado com excesso de foreign key

### Select
WHERE ativo IS TRUE; // IS compara um booleano
WHERE email LIKE '%gmail.com'; // LIKE compara string case sensitive;
WHERE nome ILIKE '%Bradesco'; // ILIKE compara strings ignorando o case sensitive;

### Condições
WHERE / AND / OR
- = 
- > / >=
- < / <=
- <> / !=
- LIKE
- ILIKE
- IN
- IS

#### SELECT - Idempotência
SELECT (campos,)
FROM tabela1
WHERE EXISTS (
    SELECT (campos,)
    FROM tabela2
    WHERE campo1 = valor1
    [AND/OR campoN = valorN]
);

Não é uma boa prática. Melhor prática utilizar o LEFT JOIN.

#### INSERT - Idempotência
INSERT INTO agencia (banco_numero, numero, nome)
SELECT 341, 1, 'Centro da Cidade'
WHERE NOT EXISTS (
    SELECT banco_numero, numero, nome 
    FROM agencia
    WHERE banco_numero = 341 AND numero = 1 AND nome = 'Centro da Cidade'
);

Não é uma boa prática

#### ON CONFLICT 
INSERT INTO agencia (banco_numero, numero, nome) VALUES (341,1,'Centro da Cidade')
ON CONFLICT (banco_numero, numero) DO NOTHING;

É uma boa prática no postgres;

#### UPDATE
UPDATE tabela_nome SET campo1 = valor1, campoN = valorN WHERE (condições);

#### DELETE
DELETE FROM tabela_nome WHERE (condições);

#### TRUNCATE
Definição: "Esvazia" a tabela
TRUNCATE [TABLE] [ONLY] name [ * ] [, ...]
    [RESTART IDENTITY | CONTINUE IDENTITY ] [ CASCADE | RESTRICT ]

- Limpar e reinicializar os ids
TRUNCATE TABLE ONLY cliente_transacoes RESTART IDENTITY CASCADE;

- Limpar e manter continuo os ids
TRUNCATE TABLE ONLY cliente_transacoes CONTINUE IDENTITY RESTRICT;

#### Funções Agregadas
- AVG
- COUNT (opção: HAVING)
- MAX
- MIN
- SUM
[Funções agregadas](https://www.postgresql.org/docs/11/functions-aggregate.html)

#### JOINs
- JOIN (INNER JOIN)
- LEFT JOIN (LEFT OUTER JOIN)
- RIGHT JOIN (RIGHT OUTER JOIN)
- FULL JOIN (FULL OUTER JOIN)
- CROSS JOIN

#### INNER JOIN
Traz os resultados que respeitem a condição entre as tabelas. O resultado sera á intersecção entre as tabelas.

#### LEFT JOIN
Traz todos os dados da tabela a esquerda, e dados da tabela a direita caso tenha relação, se não existir, terá null no retorno.

#### RIGHT JOIN
Traz todos os resultados da tabela a direita, e resultados da tabela a esquerda caso tenha relação, se não existir, terá null no retorno.

#### FULL JOIN
Traz todos os resultados que tem relação, depois todos os registros da tabela a esquerda que não tenha relação, com os dados quanto a direita null, após trará todos os resultados da tabela a direita que não tenha relação, com os dados da tabela a direita null.

#### CROSS JOIN
Todas os dados da tabela a esquerda será cruzado com todos os dados com a tabela a direita. Montando assim uma matrix.

### CTE (Common Table Expressions)
Forma auxiliar de organizar "statements"
Normalmente utilizado com código complexo.

WITH [nome1] AS (
    SELECT (campos,)
    FROM tabela_A
    [WHERE]
), [nome2] AS (
    SELECT [campos,]
    FROM tabela_B
    [WHERE]
)
SELECT [nome1].(campos,), [nome2].(campos,)
FROM [nome1]
JOIN [nome2]...

### Views
View são visões.
"Camadas" para as tabelas.
"Alias" para uma ou mais queries
Aceitam comandos de SELECT, INSERT, UPDATE, e DELETE

Somente as views que fazem referência a apenas uma tabela aceitam (SELECT, INSERT, UPDATE, DELETE), caso tenha JOIN, só aceitará o SELECT

CREATE [OR REPLACE] [ TEMP | TEMPORARY ] [ RECURSIVE ] VIEW name [( column_name [, ...])]
    [ WITH (view_option_name [= view_option_value] [, ...] )]
    AS query
    [ WITH [CASCADED | LOCAL ] CHECK OPTION ]

View Idempotência = CREATE OR REPLACE
TEMP = View só irá existir na sessão que foi criada
RECURSIVE = Select dentro da view, que irá chamar recursivamente até chegar na regra desejada.


- CREATE OR REPLACE

CREATE OR REPLACE VIEW minha_view AS (
    SELECT nome, email
    FROM usuario
);

SELECT nome, email
FROM minha_view;

CREATE OR REPLACE VIEW minha_view (usuario_nome, usuario_email ) AS (
    SELECT nome, email
    FROM usuario
);

SELECT usuario_nome, usuario_email
FROM minha_view

- TEMPORARY
Criada no momento de requisição do usuário, e destruida após o encerramento da sessão.

CREATE OR REPLACE TEMPORARY VIEW minha_view AS (
    SELECT nome, email
    FROM usuario
);

SELECT nome, email
FROM minha_view

- RECURSIVE
Obrigatório:
    - A existência dos campos da VIEW
    - UNION ALL

*UNION - Unifica
*UNION ALL - Não unifica

CREATE OR REPLACE RECURSIVE VIEW (nome_da_view) (campos_da_view) AS (
    SELECT base
    UNION ALL
    SELECT campos
    FROM tabela_base
    *JOIN (nome_da_view)*
);


- WITH OPTION

CREATE OR REPLACE VIEW minha_view AS (
    SELECT nome, email
    FROM usuario
);

INSERT INTO minha_view (nome, email) VALUES ('Bora','bora@bora.com.br');
-- OK

CREATE OR REPLACE VIEW minha_view AS (
    SELECT nome, email, ativo
    FROM usuario
    WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

INSERT INTO minha_view (nome, email, ativo) VALUES ('Bora', 'bora@bora.com.br',FALSE);
-- ERRO

- WITH CASCADED
Caso inclua condições em views e nessa não foi incluido o `WITH LOCAL`, poderá checar através do `WITH CASCADED` como opção na view que estará utilizando outra view como depedência/referencia.

CREATE OR REPLACE VIEW minha_view AS(
    ...
    WHERE ativo IS TRUE
);


CREATE OR REPLACE VIEW minha_veiw_com_email AS (
    ...
    FROM minha_view

)  WITH CASCADED CHECK OPTION;


#### Transações
Conceito fundamental de todos os sistemas de banco de dados.
Conceito de múltiplas etapas/códigos reunidos em apenas 1 transação, onde o resultado precisa ser tudo ou nada.

- Exemplo de operação que se ocorrer erro, as informações podem ser perdidas

UPDATE conta SET valor = valor - 100.00 WHERE nome = 'Alice';
UPDATE conta SET valor = valor + 100.00 WHERE nome= 'Bob';

- Exemplo de transação, se ocorrer erro, nada será modificado, caso chegue no final, será executado um `COMMIT`, confirmando a transação.
Outra opção seria o `ROLLBACK`, para desfazer.

BEGIN;

    UPDATE conta SET valor = valor - 100.00 
    WHERE nome = 'Alice';

    UPDATE conta SET valor = valor + 100.00 
    WHERE nome= 'Bob';

COMMIT;

- SAVEPOINT

BEGIN;
    UPDATE conta SET valor = valor - 100.00
    WHERE nome = 'Alice';

SAVEPOINT my_savepoint;
    UPDATE conta SET valor = valor + 100.00
    WHERE nome = 'Bob';
    -- oops ... não é para Bob, é para o Wally!!!
ROLLBACK TO my_savepoint;

    UPDATE conta SET valor = valor + 100.00
    WHERE nome = 'Wally';
COMMIT;


#### Funções
Conjunto de códigos que são executados `dentro de uma transação` com a finalidade de facilitar a programação e obter o reaproveitamento/reutilização de códigos;

Existem 4 tipos de funções:
- query language functions (funções escritas em SQL)
- procedural language functions (funções escritas em: PL/pgSQL ou PL/py)
- internal functions
- C-language functions (C ou C++, podemos compilar os códigos em C)

Porém o foco será `USER DEFINED FUNCTIONS`.
Funções que podem ser criadas pelo usuário.

- [Linguagens para criar funções](https://www.postgresql.org/docs/11/external-pl.html)
    - SQL
    - PL/PGSQL
    - PL/PY
    - PL/PHP
    - PL/RUBY
    - PL/JAVA
    - PL/LUA
    - ...

Definição

CREATE [ OR REPLACE ] FUNCTION
    name ( [ argmode ] [ argname ] argtype [ { DEFAULT | = } default_expr ] [, ...] ])
    [ RETURNS rettype
     | RETURNS TABLE (column_name column_type [, ...] ) ]
    {   LANGUAGE lang_name
        | TRANFORM { FOR TYPE type_name }  [, ...]
        | WINDOW
        | IMMUTABLE | STABLE | VOLATILE | [ NOT ] LEAKPROOF
        | CALLED ON NULL INPUT | RETURNS NULL ON NULL INPUT | STRICT
        | [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
        | PARALLEL { UNSAFE | RESTRICTED | SAFE }
        | CONST execution_cost
        | ROWS result_rows
        | SET configuration_parameter { TO value | = value | FROM CURRENT }
        | AS 'definition'
        | AS 'obj_file', 'link_symbol'
    } ...

Funcões idempotência
- CREATE `OR REPLACE` FUNCTION [nome da função]
    - Mesmo nome
    - Mesmo tipo de retorno
    - Mesmo número de parâmetros/argumentos


#### RETURNS
Tipo de retorno (data type)
- INTEGER
- CHAR / VARCHAR
- BOOLEAN
- ROW
- TABLE
- JSON

#### SECURITY
- INVOKER (padrão, permitir que a função seja executada com as permissões do usuário que está executando a função)
- DEFINER (com as permissões do usuário que criou a função)

#### Comportamento
- IMMUTABLE
Não pode alterar o banco de dados.
Funções que garantem o mesmo resultado para os mesmos argumentos/parâmetros da função. Evitar a utilização de selects, pois tableas podem sofrer alterações.
- STABLE
Não pode alterar o banco de dados.
Funções que garantem o mesmo resultado para os mesmos arguentos/parâmetros da função. Trabalha melhor com tipos de current_timestamp e outros tipos variáveis. Podem cotner selects.
- VOLATILLE
Comportamento padrão. Aceita todos os cenários.

#### SEGURANÇA E BOAS PRÁTICAS
- CALLED ON NULL INPUT
padrão.
Se qualquer um dos parâmetros/argumentos for NULL, a função será executada.
- RETURNS NULL ON NULL INPUT
Se qualquer um dos parâmetros/argumentos for NULL, a função retornará NULL.
- SECURITY INVOKER
Padrão
A função é executada com as permissões de quem executa.
- SECURITY DEFINER
A função é executada com as permissões de quem criou a função.

#### RECURSOS
- COST
Custo/row em unidades de CPU
- ROWS
Numero estimado de linhas que será analisada pelo planner;

#### SQL FUNCTIONS
Não é possível utilizar `TRANSAÇÕES`

CREATE OR REPLACE FUNCTION fc_somar(INTEGER, INTEGER)
RETURNS INTEGER
LANGUAGE SQL
AS $$
    SELECT $1 + $2;
$$;

CREATE OR REPLACE FUNCTION fc_somar ( num1 INTEGER, num2 INTEGER)
RETURNS INTEGER
LANGUAGE SQL
AS $$
    SELECT num1 + num2;
$$;

CREATE OR REPLACE FUNCTION fc_usuario_add (p_nome VARCHAR, p_email VARCHAR)
RETURNS TABLE (id INTEGER, nome VARCHAR)
RETURNS NULL ON NULL INPUT
LANGUAGE SQL
AS $$
    INSERT INTO usuarios (nome, email)
    VALUES (p_nome, p_email);

    SELECT id, nome
    FROM usuarios
    WHERE email = p_email
$$;


