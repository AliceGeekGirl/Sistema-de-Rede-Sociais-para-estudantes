-- PERGUNTA DE NEGÓCIO 5:
-- Quais são os 3 estudantes de cada curso que mais publicaram no período?

-- Período da análise
-- Foi usado o semestre de setembro a novembro de 2026, que é o período
-- que tem publicações nos dados de teste. Para outro período, basta
-- trocar as duas datas.
DECLARE @data_inicio DATE = '2026-09-01';
DECLARE @data_fim DATE = '2026-11-30';

-- data_publicacao é DATETIME (tem hora). Para incluir o último dia inteiro,
-- a busca vai até o início do dia seguinte (sem incluir ele).
DECLARE @data_limite DATETIME = DATEADD(DAY, 1, CAST(@data_fim AS DATETIME));

-- -----------------------------------------------------------------
-- CTE 1: total de publicações de cada estudante no período
-- -----------------------------------------------------------------
WITH publicacoes_por_estudante AS (
	SELECT
		u.id_usuario,
		u.nome AS nome_estudante,
		c.nome AS curso,
		COUNT(p.id_publicacao) AS total_publicacoes,
		MAX(p.data_publicacao) AS ultima_publicacao
	FROM publicacao p
	INNER JOIN usuario u ON u.id_usuario = p.id_autor
	INNER JOIN curso c ON c.id_curso = u.id_curso
	WHERE p.data_publicacao >= @data_inicio
	  AND p.data_publicacao < @data_limite
	GROUP BY u.id_usuario, u.nome, c.nome
),

-- -----------------------------------------------------------------
-- CTE 2: posição de cada estudante dentro do seu curso (Window Function)
-- -----------------------------------------------------------------
ranking AS (
	SELECT
		curso,
		id_usuario,
		nome_estudante,
		total_publicacoes,
		ultima_publicacao,

		-- Numera os estudantes de cada curso, começando pelo que mais publicou.
		-- Em caso de empate, fica na frente quem publicou mais recentemente.
		ROW_NUMBER() OVER (
			PARTITION BY curso
			ORDER BY total_publicacoes DESC, ultima_publicacao DESC
		) AS posicao_no_curso,

		-- Total de publicações do curso inteiro no período
		SUM(total_publicacoes) OVER (PARTITION BY curso) AS total_publicacoes_curso
	FROM publicacoes_por_estudante
)

-- -----------------------------------------------------------------
-- Consulta final: somente os 3 primeiros de cada curso
-- -----------------------------------------------------------------
SELECT
	curso,
	posicao_no_curso,
	nome_estudante,
	total_publicacoes,
	ultima_publicacao,
	total_publicacoes_curso
FROM ranking
WHERE posicao_no_curso <= 3
ORDER BY curso, posicao_no_curso;
GO


/*
=============================================================================
ANÁLISE DA PERGUNTA 5

O que foi usado na consulta:
	- WITH (CTE): serve para dividir a consulta em partes com nome.
	  A primeira parte conta as publicações de cada estudante e a segunda
	  usa essa contagem para montar o ranking.
	- ROW_NUMBER(): função de janela que dá um número de posição (1, 2, 3...)
	  para cada estudante, de quem publicou mais para quem publicou menos.
	- PARTITION BY curso: faz o ROW_NUMBER começar de novo no 1 em cada
	  curso, então cada curso tem o seu próprio ranking.
	- SUM() OVER: soma as publicações do curso inteiro e mostra esse total
	  em todas as linhas do curso.
	- WHERE posicao_no_curso <= 3: deixa só os 3 primeiros de cada curso.
	- Desempate: se dois estudantes do mesmo curso tiverem o mesmo número de
	  publicações, fica na frente quem publicou por último (mais recente).

Análise:
Engenharia de Computação e Engenharia de Software foram os cursos com mais
publicações no período (10 cada). Os outros cursos ficaram com 6.
Em todos os cursos o 1º lugar tem bem mais publicações que os outros, então
quem movimenta o curso na rede são poucos estudantes.
Ciência de Dados e IA não aparece porque ninguém desse curso publicou nada,
o mesmo que apareceu na pergunta 4.
=============================================================================
*/


-- =============================================================================
-- DEMONSTRAÇÃO 1: mudando o período
-- Considerando somente novembro de 2026 (01/11 a 30/11).
-- Resultado esperado: 12 linhas. Direito, Medicina e Psicologia mostram só
-- 2 estudantes, porque apenas 2 estudantes de cada um desses cursos
-- publicaram em novembro. Ou seja, a consulta traz no máximo 3 por curso.
-- =============================================================================
DECLARE @data_inicio DATE = '2026-11-01';
DECLARE @data_fim DATE = '2026-11-30';
DECLARE @data_limite DATETIME = DATEADD(DAY, 1, CAST(@data_fim AS DATETIME));

WITH publicacoes_por_estudante AS (
	SELECT u.id_usuario, u.nome AS nome_estudante, c.nome AS curso,
	       COUNT(p.id_publicacao) AS total_publicacoes, MAX(p.data_publicacao) AS ultima_publicacao
	FROM publicacao p
	INNER JOIN usuario u ON u.id_usuario = p.id_autor
	INNER JOIN curso c ON c.id_curso = u.id_curso
	WHERE p.data_publicacao >= @data_inicio AND p.data_publicacao < @data_limite
	GROUP BY u.id_usuario, u.nome, c.nome
),
ranking AS (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY curso ORDER BY total_publicacoes DESC, ultima_publicacao DESC) AS posicao_no_curso
	FROM publicacoes_por_estudante
)
SELECT curso, posicao_no_curso, nome_estudante, total_publicacoes
FROM ranking
WHERE posicao_no_curso <= 3
ORDER BY curso, posicao_no_curso;
GO


-- =============================================================================
-- DEMONSTRAÇÃO 2: um estudante passa a publicar mais
-- Dentro de uma transação, o Diego Ferreira (id 9, Engenharia de Software),
-- que tinha só 1 publicação no período, faz mais 4 publicações em novembro.
-- Resultado esperado: o Diego vai para o 1º lugar de Engenharia de Software
-- com 5 publicações, e a Carla Menezes sai do top 3 do curso.
-- No final, o ROLLBACK desfaz as publicações, então os dados não mudam.
-- =============================================================================
BEGIN TRANSACTION;

INSERT INTO publicacao (id_autor, conteudo, data_publicacao)
VALUES (9, 'Publicação de teste 1 da pergunta 5.', '2026-11-20T10:00:00'),
       (9, 'Publicação de teste 2 da pergunta 5.', '2026-11-21T10:00:00'),
       (9, 'Publicação de teste 3 da pergunta 5.', '2026-11-22T10:00:00'),
       (9, 'Publicação de teste 4 da pergunta 5.', '2026-11-23T10:00:00');

DECLARE @data_inicio DATE = '2026-09-01';
DECLARE @data_fim DATE = '2026-11-30';
DECLARE @data_limite DATETIME = DATEADD(DAY, 1, CAST(@data_fim AS DATETIME));

WITH publicacoes_por_estudante AS (
	SELECT u.id_usuario, u.nome AS nome_estudante, c.nome AS curso,
	       COUNT(p.id_publicacao) AS total_publicacoes, MAX(p.data_publicacao) AS ultima_publicacao
	FROM publicacao p
	INNER JOIN usuario u ON u.id_usuario = p.id_autor
	INNER JOIN curso c ON c.id_curso = u.id_curso
	WHERE p.data_publicacao >= @data_inicio AND p.data_publicacao < @data_limite
	GROUP BY u.id_usuario, u.nome, c.nome
),
ranking AS (
	SELECT *, ROW_NUMBER() OVER (PARTITION BY curso ORDER BY total_publicacoes DESC, ultima_publicacao DESC) AS posicao_no_curso
	FROM publicacoes_por_estudante
)
-- Mostra só o curso de Engenharia de Software para facilitar a comparação
SELECT curso, posicao_no_curso, nome_estudante, total_publicacoes
FROM ranking
WHERE posicao_no_curso <= 3
  AND curso = 'Engenharia de Software'
ORDER BY posicao_no_curso;

-- Desfaz as publicações de teste
ROLLBACK TRANSACTION;
GO
