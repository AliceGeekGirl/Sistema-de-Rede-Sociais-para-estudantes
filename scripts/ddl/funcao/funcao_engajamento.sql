/*
=============================================================================
Objeto: dbo.fn_engajamento
Autora: Alice da Cruz Justi
Projeto: UniConnect

Documentação do Cálculo:
Recebe o ID de uma publicação (@id_publicacao) e calcula o engajamento total
somando a quantidade de curtidas e comentários. As duas contagens são feitas
separadamente usando COUNT(*) para evitar multiplicação de registros,
retornando 0 caso a publicação ainda não tenha interações.

Justificativa de Uso:
Evita repetir a lógica de contagem em várias consultas e Views do sistema.
Centraliza a regra de negócio no banco de dados, facilitando a manutenção
caso novos tipos de interação sejam adicionados no futuro.
=============================================================================
*/

-- SCRIPT DE FUNÇÕES:
-- Cria ou atualiza a função que recebe o ID da publicação e devolve um número inteiro
CREATE OR ALTER FUNCTION dbo.fn_engajamento (@id_publicacao INT) RETURNS INT AS
BEGIN

	-- Declara as variáveis que vão guardar o total de curtidas e comentários
	DECLARE @total_curtida INT, @total_comentario INT

	-- Conta quantas curtidas existem para a publicação informada
	SELECT @total_curtida = COUNT(*)
	FROM curtida
	WHERE id_publicacao = @id_publicacao

	-- Conta quantos comentários existem para a mesma publicação
	SELECT @total_comentario = COUNT(*)
	FROM comentario
	WHERE id_publicacao = @id_publicacao

	-- Soma os dois valores e retorna o engajamento total (retorna 0 se não houver interações)
	RETURN @total_curtida + @total_comentario

END
GO

-- Lista todas as publicações com o respectivo total de engajamento
SELECT 
    id_publicacao,
    conteudo, 
    dbo.fn_engajamento(id_publicacao) AS total_engajamento
FROM publicacao;
