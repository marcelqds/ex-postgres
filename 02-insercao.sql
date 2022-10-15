-- Inserção banco
INSERT INTO banco (numero,nome) VALUES 
(1000,'Banco do Brasil'),
(1001,'Caixa Economica'),
(1002,'Banco Bradesco');
INSERT INTO banco (numero,nome) SELECT 1003,'Banco Fácil';

-- Inserção agencia
INSERT INTO agencia (banco_numero,numero,nome)
VALUES (1000,100,'Camtinho do Céu'),
(1000,101,'Belmira Marim'),
(1001,100,'Cidade Dutra'),
(1001,101,'São José'),
(1002,100,'Parelheiros'),
(1002,101,'Marsilac'),
(1003,100,'Gaivotas'),
(1003,101,'Cantinho');

-- Inserção cliente
INSERT INTO cliente (nome,email) VALUES
('Marcelo','marcelo@cantinho.com'),
('Alex','alex@borore.com'),
('Elaine','elaine@bernardo.com'),
('João','joao@gaivotas.com'),
('Roseane','roeseane@natal.com'),
('Amanda','amanda@osasco.com');

-- Inserção conta corrente
INSERT INTO conta_corrente (banco_numero,agencia_numero, numero, digito,cliente_numero) VALUES
(1000,100,1,0,6),
(1000,100,2,0,5),
(1001,100,1,0,4),
(1002,100,1,0,3),
(1003,100,1,0,2),
(1003,101,2,0,1),
(1002,100,2,0,1),
(1002,101,1,0,2),

-- Inserção tipo transação
INSERT INTO tipo_transacao (nome) VALUES
('Depósito'),
('Saque'),
('Transferência'),
('DOC'),
('TED');

-- Inserção cliente transação
INSERT INTO cliente_transacao (banco_numero, agencia_numero,conta_corrente_numero, conta_corrente_digito, cliente_numero, tipo_transacao_id, valor) VALUES
(1002,100,2,0,1,1,500),
(1003,100,1,0,2,1,1000);





