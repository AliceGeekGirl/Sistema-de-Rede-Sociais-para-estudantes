/*
=============================================================================
Procedures do CRUD de Instituições

Documentação do Processo:
Estas procedures fazem as operações do CRUD da tabela instituicao. A tela do
CRUD (crud/crud_instituicao.py) não escreve SQL de INSERT, UPDATE e DELETE:
ela só chama estas procedures. Assim as regras ficam todas no banco.

Procedures:
	sp_instituicao_listar    -> lista as instituições (com filtro opcional)
	sp_instituicao_inserir   -> cadastra uma nova instituição
	sp_instituicao_atualizar -> altera os dados de uma instituição
	sp_instituicao_excluir   -> exclui uma instituição

Erros tratados (mensagens que aparecem na tela do CRUD):
	50101 -> campo obrigatório não informado
	50102 -> tipo diferente de 'Pública' ou 'Privada'
	50103 -> estado (UF) com tamanho diferente de 2 letras
	50104 -> já existe outra instituição com o mesmo nome
	50105 -> instituição não encontrada
	50106 -> instituição tem cursos cadastrados e não pode ser excluída

Justificativa de Uso:
Centraliza as regras do cadastro no banco. Mesmo que outra aplicação use a
tabela, as validações continuam valendo. Também evita que a aplicação monte
SQL juntando texto, o que protege contra SQL Injection.
=============================================================================
*/


-- -----------------------------------------------------------------
-- LISTAR
-- @filtro: texto para pesquisar no nome ou na sigla (opcional)
-- -----------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_instituicao_listar
	@filtro VARCHAR(80) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id_instituicao, nome, sigla, tipo, cidade, estado
	FROM instituicao
	WHERE @filtro IS NULL
	   OR @filtro = ''
	   OR nome LIKE '%' + @filtro + '%'
	   OR sigla LIKE '%' + @filtro + '%'
	ORDER BY id_instituicao;
END
GO


-- -----------------------------------------------------------------
-- INSERIR
-- Retorna o id gerado para a nova instituição
-- -----------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_instituicao_inserir
	@nome VARCHAR(80),
	@sigla VARCHAR(20),
	@tipo VARCHAR(20),
	@cidade VARCHAR(80),
	@estado CHAR(2)
AS
BEGIN
	SET NOCOUNT ON;

	-- Tira espaços do começo e do fim
	SET @nome = LTRIM(RTRIM(@nome));
	SET @sigla = LTRIM(RTRIM(@sigla));
	SET @cidade = LTRIM(RTRIM(@cidade));
	SET @estado = UPPER(LTRIM(RTRIM(@estado)));

	-- Campos obrigatórios
	IF ISNULL(@nome, '') = '' OR ISNULL(@sigla, '') = '' OR ISNULL(@tipo, '') = ''
	   OR ISNULL(@cidade, '') = '' OR ISNULL(@estado, '') = ''
		THROW 50101, 'Todos os campos são obrigatórios.', 1;

	-- Mesma regra do CHECK da tabela
	IF @tipo NOT IN ('Pública', 'Privada')
		THROW 50102, 'O tipo deve ser Pública ou Privada.', 1;

	IF LEN(@estado) <> 2
		THROW 50103, 'O estado deve ter 2 letras (ex.: SC).', 1;

	-- Mesma regra do UNIQUE da tabela
	IF EXISTS (SELECT 1 FROM instituicao WHERE nome = @nome)
		THROW 50104, 'Já existe uma instituição com esse nome.', 1;

	INSERT INTO instituicao (nome, sigla, tipo, cidade, estado)
	VALUES (@nome, @sigla, @tipo, @cidade, @estado);

	-- Devolve o id criado
	SELECT CAST(SCOPE_IDENTITY() AS INT) AS id_instituicao;
END
GO


-- -----------------------------------------------------------------
-- ATUALIZAR
-- -----------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_instituicao_atualizar
	@id_instituicao INT,
	@nome VARCHAR(80),
	@sigla VARCHAR(20),
	@tipo VARCHAR(20),
	@cidade VARCHAR(80),
	@estado CHAR(2)
AS
BEGIN
	SET NOCOUNT ON;

	SET @nome = LTRIM(RTRIM(@nome));
	SET @sigla = LTRIM(RTRIM(@sigla));
	SET @cidade = LTRIM(RTRIM(@cidade));
	SET @estado = UPPER(LTRIM(RTRIM(@estado)));

	IF NOT EXISTS (SELECT 1 FROM instituicao WHERE id_instituicao = @id_instituicao)
		THROW 50105, 'Instituição não encontrada.', 1;

	IF ISNULL(@nome, '') = '' OR ISNULL(@sigla, '') = '' OR ISNULL(@tipo, '') = ''
	   OR ISNULL(@cidade, '') = '' OR ISNULL(@estado, '') = ''
		THROW 50101, 'Todos os campos são obrigatórios.', 1;

	IF @tipo NOT IN ('Pública', 'Privada')
		THROW 50102, 'O tipo deve ser Pública ou Privada.', 1;

	IF LEN(@estado) <> 2
		THROW 50103, 'O estado deve ter 2 letras (ex.: SC).', 1;

	-- O nome não pode ser igual ao de OUTRA instituição
	IF EXISTS (SELECT 1 FROM instituicao WHERE nome = @nome AND id_instituicao <> @id_instituicao)
		THROW 50104, 'Já existe outra instituição com esse nome.', 1;

	UPDATE instituicao
	SET nome = @nome,
	    sigla = @sigla,
	    tipo = @tipo,
	    cidade = @cidade,
	    estado = @estado
	WHERE id_instituicao = @id_instituicao;
END
GO


-- -----------------------------------------------------------------
-- EXCLUIR
-- -----------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_instituicao_excluir
	@id_instituicao INT
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT 1 FROM instituicao WHERE id_instituicao = @id_instituicao)
		THROW 50105, 'Instituição não encontrada.', 1;

	-- A tabela curso tem chave estrangeira para instituicao. Se a instituição
	-- tiver cursos, o banco não deixaria excluir, então a procedure avisa antes
	-- com uma mensagem mais clara.
	IF EXISTS (SELECT 1 FROM curso WHERE id_instituicao = @id_instituicao)
		THROW 50106, 'Esta instituição tem cursos cadastrados e não pode ser excluída.', 1;

	DELETE FROM instituicao
	WHERE id_instituicao = @id_instituicao;
END
GO


-- =============================================================================
-- TESTES DAS PROCEDURES
-- Tudo dentro de uma transação com ROLLBACK, então os dados não mudam.
-- =============================================================================
BEGIN TRANSACTION;

-- Lista com filtro (esperado: 1 linha, a UniSATC)
EXEC dbo.sp_instituicao_listar @filtro = 'SATC';

-- Inserir (esperado: devolve o id da nova instituição)
EXEC dbo.sp_instituicao_inserir 'Instituição de Teste', 'IT', 'Privada', 'Içara', 'sc';

-- Atualizar a instituição de teste
DECLARE @id INT = (SELECT id_instituicao FROM instituicao WHERE nome = 'Instituição de Teste');
EXEC dbo.sp_instituicao_atualizar @id, 'Instituição de Teste', 'ITESTE', 'Pública', 'Içara', 'SC';
SELECT * FROM instituicao WHERE id_instituicao = @id;

-- Excluir a instituição de teste (não tem cursos, então pode)
EXEC dbo.sp_instituicao_excluir @id;

-- Erro 50106: a UniSATC (id 1) tem cursos cadastrados
BEGIN TRY
	EXEC dbo.sp_instituicao_excluir 1;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS codigo_erro, ERROR_MESSAGE() AS mensagem;
END CATCH;

ROLLBACK TRANSACTION;
GO
