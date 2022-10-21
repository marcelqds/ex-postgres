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

