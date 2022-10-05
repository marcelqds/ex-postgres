## Dado 
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
