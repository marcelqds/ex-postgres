SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome FROM cliente;
SELECT banco_numero, agencia_numero, numero, digito, cliente_numero FROM conta_corrente;
SELECT id, nome FROM tipo_transacao;
SELECT banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero, valor FROM cliente_transacoes;

SELECT COUNT(1) FROM banco; -- 155
SELECT COUNT(1) FROM agencia; --304

SELECT bc.numero, bc.nome, ag.numero, ag.nome
FROM banco AS bc
JOIN agencia AS bc ON ag.banco_numero = bc.numero;

SELECT COUNT( DISTINCT bc.numero)
FROM banco AS bc
JOIN agencia AS ag ON ag.banco_numero = bc.numero;

SELECT bc.numero, bc.nome, ag.numero, ag.nome
FROM banco AS bc
LEFT JOIN agencia AS ag ON ag.banco_numero = bc.numero;

SELECT bc.numero, bc.nome, ag.numero, ag.nome
FROM banco AS bc
RIGHT JOIN agencia AS ag ON ag.banco_numero = bc.numero;

SELECT bc.numero, bc.nome, ag.numero, ag.nome
FROM banco AS bc
FULL JOIN agencia AS ag ON ag.banco_numero = bc.numero;

SELECT bc.nome, ag.nome, cc.numero AS conta, cc.digito, cl.nome
FROM banco bc
JOIN agencia ag ON ag.banco_numero = bc.numero
JOIN conta_corrente cc ON cc.banco_numero = bc.numero AND cc.agencia_numero = ag.numero
JOIN cliente cl ON cl.numero = cc.cliente_numero;

SELECT bc.nome banco, ag.nome agencia, cc.numero conta_corrente, cc.digito conta_digito,tt.nome tipo_transacao, clt.valor, cl.nome cliente
FROM banco bc
JOIN agencia ag ON ag.banco_numero = bc.numero
JOIN conta_corrente cc ON cc.banco_numero = bc.numero AND cc.agencia_numero = ag.numero
JOIN cliente cl ON cl.numero = cc.cliente_numero
JOIN cliente_transacoes clt ON clt.banco_numero = bc.numero 
   AND clt.agencia_numero = ag.numero
   AND clt.conta_corrente_numero = cc.numero
   AND clt.conta_corrente_digito = cc.digito
   AND clt.cliente_numero = cl.numero
JOIN tipo_transacao tt ON tt.id = clt.tipo_transacao_id
OFFSET 0 LIMIT 10;

