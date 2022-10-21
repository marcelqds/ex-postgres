-- SQL
CREATE OR REPLACE FUNCTION fc_bancos_add (p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS TABLE (numero INTEGER, nome VARCHAR)
RETURNS NULL ON NULL INPUT
LANGUAGE SQL
AS $$
    INSERT INTO banco (numero, nome, ativo)
    VALUES (p_numero, p_nome, p_ativo);

    SELECT numero, nome
    FROM banco
    WHERE numero = p_numero;
$$;

-- PLPGSQL
CREATE OR REPLACE FUNCTION banco_add (p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS BOOLEAN
LANGUAGE PLPGSQL
AS $$
DECLARE variavel_id INTEGER;
BEGIN
    SELECT INTO variavel_id numero FROM banco WHERE nome = p_nome;
    IF variavel_id IS NULL THEN
        INSERT INTO banco (numero, nome, ativo)
        VALUES (p_numero, p_nome, p_ativo);
    ELSE
        RETURN FALSE;
    END IF;

    SELECT INTO variavel_id numero FROM banco WHERE nome = p_nome;

    IF variavel_id IS NULL THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;
$$;

SELECT banco_add(13, 'Banco Azarado', true);

CREATE OR REPLACE FUNCTION fc_somar(INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
RETURN NULL OR NULL INPUT
LANGUAGE SQL
AS $$
    SELECT $1 + $2;
$$;

SELECT fc_somar(1,3);

CREATE OR REPLACE FUNCTION fc_somar2 (INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
CALLED ON NULL INPUT 
LANGUAGE SQL
AS $$
    SELECT COALESCE($1,0) + COALESCE($1,0);
$$;

-- PLSQL

CREATE OR REPLACE FUNCTION fc_bancos_selecionar_numero(p_nome VARCHAR)
RETURNS INTEGER
SECURITY INVOKER
LANGUAGE PLPGSQL
CALLED ON NULL INPUT
AS $$
DECLARE variavel_id INTEGER;
    SELECT INTO variavel_id numero 
    FROM banco 
    WHERE nome = p_nome;
    
    RETURN variavel_id;
$$;

CREATE OR REPLACE FUNCTION fc_bancos_inserir (p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS BOOLEAN
SECURITY INVOKER
CALLED ON NULL INPUT
LANGUAGE PLPGSQL
AS $$
DECLARE variavel_id INTEGER;
BEGIN
    IF p_numero IS NULL OR p_nome IS NULL OR p_ativo IS NULL THEN
        RETURN false;
    END IF;

    SELECT INTO variavel_id numero
    FROM banco
    WHERE numero = p_numero;
    
    IF variavel_id IS NULL THEN
        INSERT INTO banco (numero, nome, ativo)
        VALUES (p_numero, p_nome, p_ativo);

        RETURN true;
    END IF;

    RETURN false;

END;
$$;
