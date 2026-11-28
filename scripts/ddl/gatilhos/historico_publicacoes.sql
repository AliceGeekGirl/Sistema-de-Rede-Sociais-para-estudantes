/* SCRIPT DE GATILHOS:

Justificativa de Uso:

A trigger trg_historico_publicacao garante a auditoria e rastreabilidade das
alterações feitas nas postagens da rede social. Como estudantes podem editar suas publicações após publicá-las, 
manter o registro automático do texto anterior, do novo texto e da data/hora da modificação no próprio banco de
dados evita perda de informações e garante que nenhuma alteração passe sem registro, 
independentemente de onde o UPDATE seja executado.

*/

-- Criação da tabela de histórico de alterações nas publicações
-- Essa tabela funciona como um arquivo de auditoria: toda vez que alguém editar uma postagem, o texto antigo e o texto novo ficam salvos aqui.
CREATE TABLE historico_publicacao (
    id_historico INT IDENTITY(1,1) NOT NULL,
    id_publicacao INT NOT NULL,
    conteudo_anterior VARCHAR(MAX) NOT NULL,
    conteudo_novo VARCHAR(MAX) NOT NULL,
    data_alteracao DATETIME NOT NULL CONSTRAINT df_historico_publicacao_data DEFAULT GETDATE(),

    -- Restrições (Constraints) da tabela historico_publicacao
    CONSTRAINT pk_historico_publicacao PRIMARY KEY (id_historico),
    CONSTRAINT fk_historico_publicacao_publicacao FOREIGN KEY (id_publicacao) REFERENCES publicacao (id_publicacao)
);
GO

-- Criação da Trigger para registrar edições no conteúdo da publicação
-- A trigger fica "escutando" a tabela publicacao e dispara sozinha (AFTER UPDATE) sempre que um comando UPDATE for executado nela.
CREATE TRIGGER trg_historico_publicacao
ON publicacao
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON; -- Evita exibir mensagens extras de "(X linhas afetadas)" durante a execução interna da trigger

    -- Insere no histórico apenas se o texto da publicação realmente mudou, 'deleted' contém os dados antes do UPDATE e 'inserted' contém os dados depois
    -- Aqui, copiamos o antes e o depois para a tabela historico_publicacao:
    INSERT INTO historico_publicacao (id_publicacao, conteudo_anterior, conteudo_novo)
    SELECT 
        i.id_publicacao,
        d.conteudo AS conteudo_anterior,
        i.conteudo AS conteudo_novo
    FROM inserted i
    INNER JOIN deleted d ON i.id_publicacao = d.id_publicacao
    WHERE d.conteudo <> i.conteudo; -- Só salva no histórico se o texto realmente tiver mudado (evita registros duplicados caso o UPDATE salve o mesmo texto)
END;
GO

-- DEMONSTRAÇÃO DE FUNCIONAMENTO

-- Passo 1: Conferir como a publicação 1 está antes da alteração
SELECT id_publicacao, id_autor, conteudo, data_publicacao
FROM publicacao
WHERE id_publicacao = 1;
GO

-- Passo 2: Atualizar o conteúdo da publicação 1 (dispara a trigger automaticamente) e grava o histórico sem precisarmos fazer um INSERT manual.
UPDATE publicacao
SET conteudo = 'Alguém tem material de revisão de Circuitos Digitais? A prova foi adiada para terça-feira.'
WHERE id_publicacao = 1;
GO

-- Passo 3: Conferir o registro gerado automaticamente na tabela de histórico
SELECT *
FROM historico_publicacao;
GO
