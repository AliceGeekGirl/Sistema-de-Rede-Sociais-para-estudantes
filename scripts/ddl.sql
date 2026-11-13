-- ============================================================================
-- SCRIPT DDL - REDE SOCIAL ESTUDANTIL (UNICONNECT)
-- SGDB: Microsoft SQL Server
-- ============================================================================

-- CRIAÇÃO DA TABELA: instituicao
-- Armazena dados das faculdades e universidades cadastradas no sistema
CREATE TABLE instituicao (
id_instituicao INT IDENTITY(1,1) NOT NULL, -- Identificador único da instituição e numeração gerada automaticamente (começa em 1 e aumenta +1)
nome VARCHAR(80) NOT NULL,
sigla VARCHAR(20) NOT NULL,
tipo VARCHAR(20) NOT NULL,                 -- Classificação da instituição ('Pública' ou 'Privada'), obrigatório
cidade VARCHAR(80) NOT NULL,
estado CHAR(2) NOT NULL,

-- Restrições (Constraints) da tabela instituicao
CONSTRAINT pk_instituicao PRIMARY KEY (id_instituicao),               -- Define id_instituicao como a Chave Primária (PK)
CONSTRAINT uq_instituicao_nome UNIQUE (nome),                         -- Impede que existam duas instituições com o mesmo nome
CONSTRAINT ck_instituicao_tipo CHECK (tipo IN ('Pública', 'Privada')) -- Garante que o tipo aceita apenas os valores 'Pública' ou 'Privada'
);
GO

-- CRIAÇÃO DA TABELA: curso
-- Armazena os cursos pertencentes a cada instituição
CREATE TABLE curso (
id_curso INT IDENTITY(1,1) NOT NULL, -- Identificador único do curso; gerado automaticamente
nome VARCHAR(60) NOT NULL,
id_instituicao INT NOT NULL,         -- Código da instituição a qual o curso pertence (ligação com a tabela instituicao)

  -- Restrições (Constraints) da tabela curso
CONSTRAINT pk_curso PRIMARY KEY (id_curso),                                           -- Define id_curso como Chave Primária
CONSTRAINT uq_curso_nome_instituicao UNIQUE (nome, id_instituicao),                  -- Evita cadastrar o mesmo curso duas vezes na mesma instituição
CONSTRAINT fk_curso_instituicao FOREIGN KEY (id_instituicao) REFERENCES instituicao (id_instituicao) -- Define id_instituicao como Chave Estrangeira (FK) apontando para instituicao
);
GO

-- ============================================================================
-- CRIAÇÃO DA TABELA: disciplina
-- Armazena as matérias/disciplinas pertencentes a cada curso
-- ============================================================================
CREATE TABLE disciplina (
id_disciplina INT IDENTITY(1,1) NOT NULL, -- Identificador único da disciplina; gerado automaticamente
nome VARCHAR(80) NOT NULL,                -- Nome da disciplina (ex: Banco de Dados II), obrigatório
carga_horaria SMALLINT NOT NULL,          -- Carga horária total da disciplina em horas, obrigatório
id_curso INT NOT NULL,                    -- Código do curso ao qual a disciplina pertence (ligação com curso)

-- Restrições (Constraints) da tabela disciplina
CONSTRAINT pk_disciplina PRIMARY KEY (id_disciplina),                             -- Define id_disciplina como Chave Primária
CONSTRAINT uq_disciplina_nome_curso UNIQUE (nome, id_curso),                      -- Evita cadastrar a mesma disciplina duas vezes no mesmo curso
CONSTRAINT ck_disciplina_carga_horaria CHECK (carga_horaria > 0),                 -- Valida para aceitar apenas valores de carga horária maiores que zero
CONSTRAINT fk_disciplina_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) -- Define id_curso como Chave Estrangeira (FK) apontando para a tabela curso
);
GO

-- CRIAÇÃO DA TABELA: usuario
-- Armazena o perfil dos alunos e usuários cadastrados na rede
CREATE TABLE usuario (
id_usuario INT IDENTITY(1,1) NOT NULL,
nome VARCHAR(50) NOT NULL,
nome_usuario VARCHAR(40) NOT NULL,
email VARCHAR(120) NOT NULL,
senha_hash CHAR(64) NOT NULL,                                                       -- Hash da senha criptografada (ex: 64 caracteres do SHA-256), obrigatório
id_curso INT NOT NULL,                                                              -- Código do curso do estudante (ligação com a tabela curso)
fase TINYINT NOT NULL,
data_cadastro DATETIME NOT NULL CONSTRAINT df_usuario_data_cadastro DEFAULT GETDATE(), -- Registra a data/hora de criação da conta (padrão é o momento atual)

-- Restrições (Constraints) da tabela usuario
CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),                                 -- Define id_usuario como Chave Primária
CONSTRAINT uq_usuario_nome_usuario UNIQUE (nome_usuario),                       -- Impede cadastrar dois usuários com o mesmo @username
CONSTRAINT uq_usuario_email UNIQUE (email),                                     -- Impede cadastrar dois usuários com o mesmo e-mail
CONSTRAINT ck_usuario_fase CHECK (fase > 0),                                    -- Valida que a fase informada deve ser maior que zero
CONSTRAINT fk_usuario_curso FOREIGN KEY (id_curso) REFERENCES curso (id_curso) -- Define id_curso como Chave Estrangeira (FK) apontando para curso
);
GO

-- CRIAÇÃO DA TABELA: publicacao
-- Armazena as postagens feitas pelos usuários no feed
CREATE TABLE publicacao (
id_publicacao INT IDENTITY(1,1) NOT NULL,
id_autor INT NOT NULL,                                                                       -- Código do usuário que escreveu a publicação (ligação com usuario)
conteudo VARCHAR(MAX) NOT NULL,                                                              -- Texto completo da postagem sem limite fixo de tamanho, obrigatório
data_publicacao DATETIME NOT NULL CONSTRAINT df_publicacao_data_publicacao DEFAULT GETDATE(), -- Registra a data/hora da postagem (padrão é o momento atual)

-- Restrições (Constraints) da tabela publicacao
CONSTRAINT pk_publicacao PRIMARY KEY (id_publicacao),                             -- Define id_publicacao como Chave Primária
CONSTRAINT fk_publicacao_autor FOREIGN KEY (id_autor) REFERENCES usuario (id_usuario) -- Define id_autor como Chave Estrangeira (FK) apontando para usuario
);
GO

-- CRIAÇÃO DA TABELA: curtida (Tabela Auxiliar N:N)
-- Registra quais usuários curtiram quais postagens
CREATE TABLE curtida (
id_usuario INT NOT NULL,                                                          -- Código do usuário que curtiu a publicação
id_publicacao INT NOT NULL,                                                       -- Código da publicação que foi curtida
data_curtida DATETIME NOT NULL CONSTRAINT df_curtida_data_curtida DEFAULT GETDATE(), -- Data/hora em que a curtida foi dada (padrão é o momento atual)

  -- Restrições (Constraints) da tabela curtida
CONSTRAINT pk_curtida PRIMARY KEY (id_usuario, id_publicacao),                        -- Chave Primária Composta (impede o mesmo usuário curtir a mesma postagem mais de uma vez)
CONSTRAINT fk_curtida_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario), -- Define id_usuario como Chave Estrangeira (FK) apontando para usuario
CONSTRAINT fk_curtida_publicacao FOREIGN KEY (id_publicacao) REFERENCES publicacao (id_publicacao) -- Define id_publicacao como Chave Estrangeira (FK) apontando para publicacao
);
GO

-- CRIAÇÃO DA TABELA: comentario
-- Armazena os comentários feitos nas postagens
CREATE TABLE comentario (
id_comentario INT IDENTITY(1,1) NOT NULL,
id_publicacao INT NOT NULL,                                                                    -- Código da publicação comentada (ligação com publicacao)
id_usuario INT NOT NULL,                                                                       -- Código do usuário que comentou (ligação com usuario)
texto VARCHAR(MAX) NOT NULL,
data_comentario DATETIME NOT NULL CONSTRAINT df_comentario_data_comentario DEFAULT GETDATE(),

-- Restrições (Constraints) da tabela comentario
CONSTRAINT pk_comentario PRIMARY KEY (id_comentario),                                      -- Define id_comentario como Chave Primária
CONSTRAINT fk_comentario_publicacao FOREIGN KEY (id_publicacao) REFERENCES publicacao (id_publicacao), -- Liga o comentário à publicação correspondente (FK)
CONSTRAINT fk_comentario_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)  -- Liga o comentário ao autor do comentário (FK)
);
GO

-- CRIAÇÃO DA TABELA: seguidor (Tabela Auxiliar N:N)
-- Registra as conexões de relacionamento entre usuários (quem segue quem)
CREATE TABLE seguidor (
id_seguidor INT NOT NULL,                                                         -- Código do usuário que está seguindo alguém
id_seguido INT NOT NULL,                                                          -- Código do usuário que está sendo seguido
data_inicio DATETIME NOT NULL CONSTRAINT df_seguidor_data_inicio DEFAULT GETDATE(), -- Data/hora em que começou a seguir (padrão é o momento atual)

-- Restrições (Constraints) da tabela seguidor
CONSTRAINT pk_seguidor PRIMARY KEY (id_seguidor, id_seguido),                         -- Chave Primária Composta (impede seguir o mesmo usuário mais de uma vez)
CONSTRAINT ck_seguidor_diferente CHECK (id_seguidor <> id_seguido),                   -- Regra de validação: impede que um usuário siga ele mesmo
CONSTRAINT fk_seguidor_usuario_seguidor FOREIGN KEY (id_seguidor) REFERENCES usuario (id_usuario), -- Liga id_seguidor ao usuário (FK)
CONSTRAINT fk_seguidor_usuario_seguido FOREIGN KEY (id_seguido) REFERENCES usuario (id_usuario)   -- Liga id_seguido ao usuário (FK)
);
GO

-- CRIAÇÃO DA TABELA: pergunta
-- Armazena as dúvidas acadêmicas publicadas pelos estudantes
CREATE TABLE pergunta (
id_pergunta INT IDENTITY(1,1) NOT NULL,
id_autor INT NOT NULL,                                                                     -- Código do usuário criador da dúvida (ligação com usuario)
id_disciplina INT NOT NULL,                                                                -- Código da matéria referente à dúvida (ligação com disciplina)
titulo VARCHAR(160) NOT NULL,
descricao VARCHAR(MAX) NOT NULL,
data_pergunta DATETIME NOT NULL CONSTRAINT df_pergunta_data_pergunta DEFAULT GETDATE(),

  -- Restrições (Constraints) da tabela pergunta
CONSTRAINT pk_pergunta PRIMARY KEY (id_pergunta),                                          -- Define id_pergunta como Chave Primária
CONSTRAINT fk_pergunta_autor FOREIGN KEY (id_autor) REFERENCES usuario (id_usuario),       -- Liga a pergunta ao autor (FK)
CONSTRAINT fk_pergunta_disciplina FOREIGN KEY (id_disciplina) REFERENCES disciplina (id_disciplina) -- Liga a pergunta à disciplina relacionada (FK)
);
GO

-- CRIAÇÃO DA TABELA: resposta
-- Armazena as respostas enviadas para cada pergunta
CREATE TABLE resposta (
id_resposta INT IDENTITY(1,1) NOT NULL,
id_pergunta INT NOT NULL,                                                                  -- Código da pergunta que está sendo respondida (ligação com pergunta)
id_usuario INT NOT NULL,                                                                   -- Código do usuário que respondeu (ligação com usuario)
texto VARCHAR(MAX) NOT NULL,
data_resposta DATETIME NOT NULL CONSTRAINT df_resposta_data_resposta DEFAULT GETDATE(),

-- Restrições (Constraints) da tabela resposta
CONSTRAINT pk_resposta PRIMARY KEY (id_resposta),                                          -- Define id_resposta como Chave Primária
CONSTRAINT fk_resposta_pergunta FOREIGN KEY (id_pergunta) REFERENCES pergunta (id_pergunta), -- Liga a resposta à sua pergunta de origem (FK)
CONSTRAINT fk_resposta_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)   -- Liga a resposta ao usuário que respondeu (FK)
);
GO

-- CRIAÇÃO DA TABELA: grupo_estudo
-- Armazena os grupos de estudo criados pela comunidade
CREATE TABLE grupo_estudo (
id_grupo INT IDENTITY(1,1) NOT NULL,
nome VARCHAR(120) NOT NULL,
descricao VARCHAR(255) NOT NULL,
id_criador INT NOT NULL,                                                                    -- Código do usuário que fundou o grupo (ligação com usuario)
data_criacao DATETIME NOT NULL CONSTRAINT df_grupo_estudo_data_criacao DEFAULT GETDATE(),

-- Restrições (Constraints) da tabela grupo_estudo
CONSTRAINT pk_grupo_estudo PRIMARY KEY (id_grupo),                                         -- Define id_grupo como Chave Primária
CONSTRAINT fk_grupo_estudo_criador FOREIGN KEY (id_criador) REFERENCES usuario (id_usuario) -- Liga o grupo ao seu fundador (FK)
);
GO

-- CRIAÇÃO DA TABELA: participante_grupo (Tabela Auxiliar N:N)
-- Registra a entrada e participação dos alunos nos grupos de estudo
CREATE TABLE participante_grupo (
id_grupo INT NOT NULL,                                                                                  -- Código do grupo de estudos em que o aluno está inscrito
id_usuario INT NOT NULL,                                                                                -- Código do estudante participante do grupo
data_entrada DATETIME NOT NULL CONSTRAINT df_participante_grupo_data_entrada DEFAULT GETDATE(),

-- Restrições (Constraints) da tabela participante_grupo
CONSTRAINT pk_participante_grupo PRIMARY KEY (id_grupo, id_usuario),                                 -- Chave Primária Composta (evita que o mesmo usuário entre duas vezes no mesmo grupo)
CONSTRAINT fk_participante_grupo_grupo FOREIGN KEY (id_grupo) REFERENCES grupo_estudo (id_grupo),    -- Liga ao grupo de estudos (FK)
CONSTRAINT fk_participante_grupo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)   -- Liga ao usuário membro (FK)
);
GO

-- CRIAÇÃO DA TABELA: mensagem
-- Armazena as mensagens diretas e privadas trocadas entre dois alunos
CREATE TABLE mensagem (
id_mensagem INT IDENTITY(1,1) NOT NULL,
id_remetente INT NOT NULL,                                                         -- Código do usuário que enviou a mensagem (ligação com usuario)
id_destinatario INT NOT NULL,                                                      -- Código do usuário que recebe a mensagem (ligação com usuario)
conteudo VARCHAR(MAX) NOT NULL,
data_envio DATETIME NOT NULL CONSTRAINT df_mensagem_data_envio DEFAULT GETDATE(),
lida BIT NOT NULL CONSTRAINT df_mensagem_lida DEFAULT 0,                           -- Indicador visual de leitura: 0 = Não lida, 1 = Lida (padrão inicia em 0)

-- Restrições (Constraints) da tabela mensagem
CONSTRAINT pk_mensagem PRIMARY KEY (id_mensagem),                                        -- Define id_mensagem como Chave Primária
CONSTRAINT ck_mensagem_diferente CHECK (id_remetente <> id_destinatario),                -- Validação: impede que um usuário mande mensagem para ele mesmo
CONSTRAINT fk_mensagem_remetente FOREIGN KEY (id_remetente) REFERENCES usuario (id_usuario), -- Liga a mensagem ao usuário remetente (FK)
CONSTRAINT fk_mensagem_destinatario FOREIGN KEY (id_destinatario) REFERENCES usuario (id_usuario) -- Liga a mensagem ao usuário destinatário (FK)
);
GO

-- CRIAÇÃO DA TABELA: material
-- Armazena arquivos, resumos e links compartilhados para estudo
CREATE TABLE material (
id_material INT IDENTITY(1,1) NOT NULL,
titulo VARCHAR(160) NOT NULL,
descricao VARCHAR(255) NOT NULL,
tipo VARCHAR(20) NOT NULL,
url VARCHAR(255) NOT NULL,                                                                            -- Endereço web/link para acessar o arquivo publicado, obrigatório
id_usuario INT NOT NULL,                                                                              -- Código do estudante que disponibilizou o material (ligação com usuario)
id_disciplina INT NOT NULL,                                                                           -- Código da disciplina a qual o material se refere (ligação com disciplina)
data_compartilhamento DATETIME NOT NULL CONSTRAINT df_material_data_compartilhamento DEFAULT GETDATE(),

-- Restrições (Constraints) da tabela material
CONSTRAINT pk_material PRIMARY KEY (id_material),                                                     -- Define id_material como Chave Primária
CONSTRAINT ck_material_tipo CHECK (tipo IN ('PDF', 'Slide', 'Vídeo', 'Link', 'Resumo')),              -- Validação: aceita somente uma das 5 categorias listadas
CONSTRAINT fk_material_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),             -- Liga o material ao usuário dono da postagem (FK)
CONSTRAINT fk_material_disciplina FOREIGN KEY (id_disciplina) REFERENCES disciplina (id_disciplina) -- Liga o material à disciplina correspondente (FK)
);
GO
