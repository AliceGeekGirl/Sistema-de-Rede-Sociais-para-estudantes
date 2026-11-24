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

-- PERGUNTA DE NEGÓCIO 2:
-- Quais grupos de estudo tiveram mais estudantes ativos (que publicaram ou comentaram) durante o mês de outubro de 2026?

-- Declaração da variável de tabela (@participantes)
-- O SQL Server não permite fazer JOIN ou WHERE diretamente em cima do resultado de uma Stored Procedure (EXEC). 
-- Por isso, declaramos uma variável do tipo TABLE na memória — com exatamente as mesmas colunas que a procedure devolve — para guardar os dados retornados e conseguir filtrá-los logo em seguida.
DECLARE @participantes TABLE (
    id_grupo INT,
    nome_grupo VARCHAR(120),
    id_usuario INT,
    nome_estudante VARCHAR(50),
    nome_usuario VARCHAR(40),
    curso VARCHAR(60),
    fase TINYINT,
    data_entrada DATETIME,
    criador_do_grupo VARCHAR(3),
    entradas_no_periodo INT,
    total_membros_grupo INT
);

-- Execução da procedure e armazenamento do retorno
-- Roda a procedure para o mês de outubro de 2026 e insere todas as linhas encontradas dentro da variável @participantes.
INSERT INTO @participantes
EXEC dbo.sp_participacao_grupos 
    @data_inicio = '2026-10-01', 
    @data_fim = '2026-10-31';

-- Filtragem e contagem dos estudantes ativos por grupo
SELECT 
    p.id_grupo,
    p.nome_grupo,
    COUNT(DISTINCT p.id_usuario) AS total_estudantes_ativos -- Garante que cada estudante seja contado apenas 1 vez no grupo, mesmo que tenha feito várias publicações e comentários no mês.
FROM @participantes p
WHERE 
    -- Mantém apenas quem fez pelo menos uma publicação em outubro de 2026.
    -- O 'T00:00:00' garante que o SQL Server em português leia a data no formato ISO (ano-mês-dia) sem confundir mês com dia, e o '< 2026-11-01' inclui tudo o que foi postado até as 23:59 do dia 31 de outubro.
    p.id_usuario IN (
        SELECT pub.id_autor
        FROM publicacao pub
        WHERE pub.data_publicacao >= '2026-10-01T00:00:00'
          AND pub.data_publicacao < '2026-11-01T00:00:00'
    )
    -- OU quem fez pelo menos um comentário em outubro de 2026
    OR p.id_usuario IN (
        SELECT com.id_usuario
        FROM comentario com
        WHERE com.data_comentario >= '2026-10-01T00:00:00'
          AND com.data_comentario < '2026-11-01T00:00:00'
    )
-- Agrupa o resultado por grupo de estudo para fazer a contagem
GROUP BY p.id_grupo, p.nome_grupo
-- Ordena do grupo com mais estudantes ativos para o menor (usando o nome como desempate)
ORDER BY total_estudantes_ativos DESC, p.nome_grupo;
GO
