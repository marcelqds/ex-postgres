SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;

WITH tb_tmp_banco AS (
    SELECT numero, nome
    FROM banco;
)

SELECT numero, nome FROM tb_tmp_banco;

WITH params AS (
    SELECT 213 AS banco_numero
), tb_tmp_banco AS (
    SELECT numero, nome
    FROM banco bc
    JOIN params pa ON pa.banco_numero = bc.numero
)

SELECT numero, nome FROM tb_tmp_banco;

WITH clientes_e_transacoes AS (
    SELECT cl.nome AS cliente,tt.nome AS tipo_transacao,clt.valor AS transacao_valor
    FROM cliente_transacoes clt
    JOIN cliente cl ON cl.numero = clt.cliente_numero
    JOIN tipo_transacao tt ON tt.id = clt.tipo_transacao_id
)
SELECT cliente, tipo_transacao, transacao_valor FROM clientes_e_transacoes;








-- Sub-Selects
SELECT bc.numero, bc.nome
FROM banco bc
JOIN (
    SELECT 213 AS banco_numero
) params pa ON pa.banco_numero = bc.numero;



