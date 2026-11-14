-- VIEW: vw_publicacoes_detalhadas
-- Apresenta as publicações com seus respectivos autores e grupos de estudo (quando houver).
CREATE OR ALTER VIEW vw_publicacoes_detalhadas AS
SELECT p.id_publicacao,
           p.conteudo,
           p.data_publicacao,
           u.id_usuario,
           u.nome AS nome_autor,
           u.nome_usuario,
           pg.id_grupo,
           g.nome AS nome_grupo
FROM publicacao p
INNER JOIN usuario u ON p.id_autor = u.id_usuario
LEFT JOIN participante_grupo pg ON u.id_usuario = pg.id_usuario
LEFT JOIN grupo_estudo g ON pg.id_grupo = g.id_grupo;
GO

-- DEMONSTRAÇÃO DE CONSULTAS UTILIZANDO A VIEW

-- Listagem geral das publicações ordenadas das mais recentes para as mais antigas
SELECT * FROM vw_publicacoes_detalhadas
ORDER BY id_publicacao DESC;

-- Publicações de autores que não participam de nenhum grupo de estudo
SELECT * FROM vw_publicacoes_detalhadas
WHERE id_grupo IS NULL;

-- Quantidade de publicações distintas vinculadas a cada grupo de estudo
SELECT nome_grupo, COUNT(DISTINCT id_publicacao) AS total_publicacoes
FROM vw_publicacoes_detalhadas
WHERE nome_grupo IS NOT NULL
GROUP BY nome_grupo;
