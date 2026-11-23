/*
=============================================================================
Procedure: dbo.sp_participacao_grupos

Documentação do Processo:
Recebe um período de busca (data inicial e data final) e retorna os
estudantes que entraram em grupos de estudo dentro desse período, com os
dados do grupo, do estudante e do curso.

As datas informadas NÃO são entrada e saída do estudante, e sim o intervalo
da consulta. O modelo não registra data de saída: o estudante é considerado
participante do grupo a partir da data de entrada (tabela participante_grupo).

Parâmetros:
	@data_inicio DATE -> início do período de busca (obrigatório)
	@data_fim    DATE -> fim do período de busca, com o dia inteiro incluído (obrigatório)
	@id_grupo    INT  -> grupo específico (opcional; se não informar, traz todos)

Erros tratados:
	50001 -> data inicial ou final não informada
	50002 -> data inicial maior que a data final
	50003 -> grupo informado não existe

Justificativa de Uso:
A consulta junta quatro tabelas (participante_grupo, grupo_estudo, usuario e
curso) e vai ser usada em outras partes do trabalho, como a pergunta de
negócio 2 (grupos com mais estudantes ativos) e o relatório final. Deixando a
consulta na procedure, basta informar o período, e a validação das datas fica
no próprio banco. Como a procedure só consulta dados, não precisa de transação.
=============================================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_participacao_grupos
	@data_inicio DATE,
	@data_fim DATE,
	@id_grupo INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- -----------------------------------------------------------------
	-- PARTE 1: validação dos parâmetros
	-- -----------------------------------------------------------------

	-- As duas datas do período são obrigatórias
	IF @data_inicio IS NULL OR @data_fim IS NULL
		THROW 50001, 'Informe a data inicial e a data final do período.', 1;

	-- A data inicial não pode ser depois da data final
	IF @data_inicio > @data_fim
		THROW 50002, 'A data inicial não pode ser maior que a data final.', 1;

	-- Se foi informado um grupo, ele precisa existir
	IF @id_grupo IS NOT NULL AND NOT EXISTS (SELECT 1 FROM grupo_estudo WHERE id_grupo = @id_grupo)
		THROW 50003, 'O grupo de estudo informado não existe.', 1;

	-- -----------------------------------------------------------------
	-- PARTE 2: ajuste da data final
	-- -----------------------------------------------------------------

	-- data_entrada é DATETIME (tem hora). Se comparar direto com a data final,
	-- quem entrou no último dia depois de 00:00 fica de fora. Por isso a busca
	-- vai até o início do dia seguinte (sem incluir ele).
	DECLARE @data_limite DATETIME = DATEADD(DAY, 1, CAST(@data_fim AS DATETIME));

	-- -----------------------------------------------------------------
	-- PARTE 3: consulta da participação nos grupos
	-- -----------------------------------------------------------------

	SELECT
		g.id_grupo,
		g.nome AS nome_grupo,
		u.id_usuario,
		u.nome AS nome_estudante,
		u.nome_usuario,
		c.nome AS curso,
		u.fase,
		pg.data_entrada,

		-- Mostra se o estudante foi quem criou o grupo
		CASE WHEN g.id_criador = u.id_usuario THEN 'Sim' ELSE 'Não' END AS criador_do_grupo,

		-- Quantos estudantes entraram nesse grupo dentro do período (Window Function)
		COUNT(*) OVER (PARTITION BY g.id_grupo) AS entradas_no_periodo,

		-- Total de membros do grupo, sem considerar o período
		(SELECT COUNT(*) FROM participante_grupo pg2 WHERE pg2.id_grupo = g.id_grupo) AS total_membros_grupo

	FROM participante_grupo pg
	INNER JOIN grupo_estudo g ON g.id_grupo = pg.id_grupo
	INNER JOIN usuario u ON u.id_usuario = pg.id_usuario
	INNER JOIN curso c ON c.id_curso = u.id_curso
	WHERE pg.data_entrada >= @data_inicio
	  AND pg.data_entrada < @data_limite
	  AND (@id_grupo IS NULL OR pg.id_grupo = @id_grupo)

	-- Grupos com mais entradas no período aparecem primeiro
	ORDER BY entradas_no_periodo DESC, g.id_grupo, pg.data_entrada;
END
GO


-- =============================================================================
-- TESTES DA PROCEDURE
-- Executar depois do tabelas.sql e do popula_tabelas.sql
-- =============================================================================

-- Teste 1: entradas em outubro de 2026 (resultado esperado: 59 linhas)
EXEC dbo.sp_participacao_grupos @data_inicio = '2026-10-01', @data_fim = '2026-10-31';

-- Teste 2: entradas em novembro de 2026 (resultado esperado: 15 linhas)
EXEC dbo.sp_participacao_grupos @data_inicio = '2026-11-01', @data_fim = '2026-11-30';

-- Teste 3: somente o grupo 1 em outubro de 2026 (resultado esperado: 8 linhas)
EXEC dbo.sp_participacao_grupos @data_inicio = '2026-10-01', @data_fim = '2026-10-31', @id_grupo = 1;

-- Teste 4: data inicial maior que a final (resultado esperado: erro 50002)
BEGIN TRY
	EXEC dbo.sp_participacao_grupos @data_inicio = '2026-12-01', @data_fim = '2026-10-01';
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS codigo_erro, ERROR_MESSAGE() AS mensagem;
END CATCH;

-- Teste 5: grupo que não existe (resultado esperado: erro 50003)
BEGIN TRY
	EXEC dbo.sp_participacao_grupos @data_inicio = '2026-10-01', @data_fim = '2026-10-31', @id_grupo = 999;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS codigo_erro, ERROR_MESSAGE() AS mensagem;
END CATCH;
