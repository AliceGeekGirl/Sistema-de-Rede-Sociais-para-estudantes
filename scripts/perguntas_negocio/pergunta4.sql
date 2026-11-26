-- PERGUNTA DE NEGÓCIO 4:
-- Quais estudantes não publicaram nem comentaram nada nos últimos 30 dias?

-- Data de referência da análise
-- Os "últimos 30 dias" são contados para trás a partir desta data.
-- Foi fixada em 01/12/2026 (data da apresentação) para que o resultado
-- possa ser conferido com os dados de teste. Em uso real, bastaria trocar por
-- CAST(GETDATE() AS DATE).
DECLARE @data_referencia DATE = '2026-12-01';

-- Início do período: 30 dias antes da data de referência
DECLARE @data_inicio DATE = DATEADD(DAY, -30, @data_referencia);

SELECT
	u.id_usuario,
	u.nome AS nome_estudante,
	u.nome_usuario,
	c.nome AS curso,
	u.fase,

	-- Data da última publicação do estudante (NULL se nunca publicou)
	(SELECT MAX(p.data_publicacao)
	 FROM publicacao p
	 WHERE p.id_autor = u.id_usuario) AS ultima_publicacao,

	-- Data do último comentário do estudante (NULL se nunca comentou)
	(SELECT MAX(cm.data_comentario)
	 FROM comentario cm
	 WHERE cm.id_usuario = u.id_usuario) AS ultimo_comentario

FROM usuario u
INNER JOIN curso c ON c.id_curso = u.id_curso
WHERE
	-- Não existe nenhuma publicação do estudante dentro dos últimos 30 dias
	NOT EXISTS (
		SELECT 1
		FROM publicacao p
		WHERE p.id_autor = u.id_usuario
		  AND p.data_publicacao >= @data_inicio
	)
	-- E também não existe nenhum comentário do estudante nesse período
	AND NOT EXISTS (
		SELECT 1
		FROM comentario cm
		WHERE cm.id_usuario = u.id_usuario
		  AND cm.data_comentario >= @data_inicio
	)
-- Mostra primeiro quem está há mais tempo sem participar
ORDER BY ultima_publicacao, ultimo_comentario, u.nome;
GO


/*
=============================================================================
ANÁLISE DA PERGUNTA 4

Recursos utilizados:
	- NOT EXISTS: subconsulta que verifica se NÃO existe nenhuma publicação
	  (e, no segundo, nenhum comentário) do estudante dentro do período.
	  O estudante só aparece se as duas condições forem verdadeiras (AND).
	- Subconsulta correlacionada: as subconsultas usam u.id_usuario da
	  consulta principal, então são avaliadas para cada estudante.
	- DATEADD: calcula o início do período voltando 30 dias a partir da
	  data de referência.
	- MAX em subconsulta: mostra a data da última publicação e do último
	  comentário de cada estudante, para saber há quanto tempo está parado.

Análise geral:
Com a data de referência em 01/12/2026 (período de 01/11 a 01/12), a
consulta mostra dois perfis de estudante sem participação recente:
	- Estudantes que nunca publicaram nem comentaram (última publicação e
	  último comentário vazios). A maioria deles é do mesmo curso, o que
	  indica um curso que ainda não engajou na plataforma.
	- Estudantes que já participaram, mas pararam no fim de outubro. Esses
	  estão há pouco mais de 30 dias sem atividade e podem ser recuperados
	  com alguma ação de incentivo, como uma notificação ou convite para
	  um grupo de estudo.
=============================================================================
*/


-- =============================================================================
-- DEMONSTRAÇÃO 1: mudando a data de referência
-- Com a referência em 25/11/2026, o período passa a ser 26/10 a 25/11.
-- Resultado esperado: 5 estudantes. Nicolas, Pedro e Mariana saem da lista,
-- porque participaram em 26/10 e 27/10, que agora estão dentro da janela
-- de 30 dias. Ficam só os 5 que nunca participaram.
-- =============================================================================
DECLARE @data_referencia DATE = '2026-11-25';
DECLARE @data_inicio DATE = DATEADD(DAY, -30, @data_referencia);

SELECT u.id_usuario, u.nome AS nome_estudante
FROM usuario u
WHERE NOT EXISTS (SELECT 1 FROM publicacao p WHERE p.id_autor = u.id_usuario AND p.data_publicacao >= @data_inicio)
  AND NOT EXISTS (SELECT 1 FROM comentario cm WHERE cm.id_usuario = u.id_usuario AND cm.data_comentario >= @data_inicio)
ORDER BY u.nome;
GO


-- =============================================================================
-- DEMONSTRAÇÃO 2: um estudante inativo passa a participar
-- Dentro de uma transação, a Carla Teixeira (id 15) faz uma publicação em
-- 20/11/2026. Ela deve sumir da lista (de 8 para 7 estudantes).
-- No final, o ROLLBACK desfaz a publicação, então os dados não mudam.
-- =============================================================================
BEGIN TRANSACTION;

INSERT INTO publicacao (id_autor, conteudo, data_publicacao)
VALUES (15, 'Publicação de teste da pergunta 4.', '2026-11-20T10:00:00');

DECLARE @data_referencia DATE = '2026-12-01';
DECLARE @data_inicio DATE = DATEADD(DAY, -30, @data_referencia);

-- Resultado esperado: 7 estudantes (a Carla não aparece mais)
SELECT u.id_usuario, u.nome AS nome_estudante
FROM usuario u
WHERE NOT EXISTS (SELECT 1 FROM publicacao p WHERE p.id_autor = u.id_usuario AND p.data_publicacao >= @data_inicio)
  AND NOT EXISTS (SELECT 1 FROM comentario cm WHERE cm.id_usuario = u.id_usuario AND cm.data_comentario >= @data_inicio)
ORDER BY u.nome;

-- Desfaz a publicação de teste
ROLLBACK TRANSACTION;
GO
