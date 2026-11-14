-- SCRIPT DE INSERÇÃO DE DADOS (DML): Tabela instituicao
-- Popula as 21 instituições de ensino no banco de dados (Como id_instituicao é IDENTITY, o SQL gera automaticamente IDs de 1 a 21)
INSERT INTO instituicao (nome, sigla, tipo, cidade, estado)
VALUES
('Associação Beneficente da Indústria Carbonífera de Santa Catarina', 'UniSATC', 'Privada', 'Criciúma', 'SC'),      -- Gerará id_instituicao = 1
('Universidade do Extremo Sul Catarinense', 'UNESC', 'Privada', 'Criciúma', 'SC'),                                 -- Gerará id_instituicao = 2
('Universidade Estadual de Campinas', 'Unicamp', 'Pública', 'Campinas', 'SP'),                                      -- Gerará id_instituicao = 3
('Universidade Federal do Rio Grande do Sul', 'UFRGS', 'Pública', 'Porto Alegre', 'RS'),                             -- Gerará id_instituicao = 4
('Universidade Federal de Santa Catarina', 'UFSC', 'Pública', 'Florianópolis', 'SC'),                                -- Gerará id_instituicao = 5
('Universidade Federal do Rio de Janeiro', 'UFRJ', 'Pública', 'Rio de Janeiro', 'RJ'),                               -- Gerará id_instituicao = 6
('Universidade do Vale do Rio dos Sinos', 'Unisinos', 'Privada', 'Porto Alegre', 'RS'),                              -- Gerará id_instituicao = 7
('Universidade Federal de Minas Gerais', 'UFMG', 'Pública', 'Belo Horizonte', 'MG'),                                 -- Gerará id_instituicao = 8
('Universidade de São Paulo', 'USP', 'Pública', 'São Paulo', 'SP'),                                                  -- Gerará id_instituicao = 9
('Universidade de Fortaleza', 'Unifor', 'Privada', 'Fortaleza', 'CE'),                                               -- Gerará id_instituicao = 10
('Pontifícia Universidade Católica do Rio Grande do Sul', 'PUC-RS', 'Privada', 'Porto Alegre', 'RS'),               -- Gerará id_instituicao = 11
('Universidade de Cuiabá', 'UNIC', 'Privada', 'Cuiabá', 'MT'),                                                      -- Gerará id_instituicao = 12
('Universidade Federal de Mato Grosso', 'UFMT', 'Pública', 'Barra do Garças', 'MT'),                                 -- Gerará id_instituicao = 13
('Universidade Estadual Paulista', 'UNESP', 'Pública', 'Registro', 'SP'),                                           -- Gerará id_instituicao = 14
('Universidade Federal do Paraná', 'UFPR', 'Pública', 'Curitiba', 'PR'),                                             -- Gerará id_instituicao = 15
('Universidade do Estado de Santa Catarina', 'Udesc', 'Pública', 'Florianópolis', 'SC'),                             -- Gerará id_instituicao = 16
('Universidade de Pernambuco', 'UPE', 'Pública', 'Recife', 'PE'),                                                   -- Gerará id_instituicao = 17
('Universidade Presbiteriana Mackenzie', 'Mackenzie', 'Privada', 'São Paulo', 'SP'),                                -- Gerará id_instituicao = 18
('Universidade Federal do Espírito Santo', 'UFES', 'Pública', 'Vitória', 'ES'),                                      -- Gerará id_instituicao = 19
('Pontifícia Universidade Católica do Rio de Janeiro', 'PUC-Rio', 'Privada', 'Rio de Janeiro', 'RJ'),               -- Gerará id_instituicao = 20
('Faculdade SENAI', 'UniSENAI', 'Privada', 'Florianópolis', 'SC');                                                 -- Gerará id_instituicao = 21

SELECT * from instituicao;
GO

-- SCRIPT DE INSERÇÃO DE DADOS (DML): Tabela curso
-- Popula a tabela curso com graduações vinculadas às instituições cadastradas (Como id_curso é IDENTITY(1,1), os IDs serão gerados automaticamente, de 1 a 91).
INSERT INTO curso (nome, id_instituicao)
VALUES
    -- ID 1: UNISATC (Criciúma/SC)
    ('Engenharia de Computação', 1),            -- id_curso = 1
    ('Engenharia de Software', 1),              -- id_curso = 2
    ('Engenharia Mecânica', 1),                 -- id_curso = 3
    ('Engenharia Elétrica', 1),                 -- id_curso = 4
    ('Psicologia', 1),                          -- id_curso = 5
    ('Design', 1),                              -- id_curso = 6

    -- ID 2: UNESC (Criciúma/SC)
    ('Enfermagem', 2),                          -- id_curso = 7
    ('Administração', 2),                       -- id_curso = 8
    ('Direito', 2),                             -- id_curso = 9
    ('Psicologia', 2),                          -- id_curso = 10
    ('Fisioterapia', 2),                        -- id_curso = 11

    -- ID 3: Unicamp (Campinas/SP)
    ('Medicina', 3),                            -- id_curso = 12
    ('Engenharia de Computação', 3),            -- id_curso = 13
    ('Ciências Econômicas', 3),                 -- id_curso = 14
    ('Farmácia', 3),                            -- id_curso = 15

    -- ID 4: UFRGS (Porto Alegre/RS)
    ('Ciência da Computação', 4),               -- id_curso = 16
    ('Engenharia Civil', 4),                    -- id_curso = 17
    ('Medicina', 4),                            -- id_curso = 18
    ('Direito', 4),                             -- id_curso = 19
    ('Nutrição', 4),                            -- id_curso = 20

    -- ID 5: UFSC (Florianópolis/SC)
    ('Ciência da Computação', 5),               -- id_curso = 21
    ('Engenharia de Controle e Automação', 5),  -- id_curso = 22
    ('Medicina', 5),                            -- id_curso = 23
    ('Psicologia', 5),                          -- id_curso = 24

    -- ID 6: UFRJ (Rio de Janeiro/RJ)
    ('Medicina', 6),                            -- id_curso = 25
    ('Engenharia Civil', 6),                    -- id_curso = 26
    ('Ciência da Computação', 6),               -- id_curso = 27
    ('Direito', 6),                             -- id_curso = 28

    -- ID 7: Unisinos (Porto Alegre/RS)
    ('Ciência da Computação', 7),               -- id_curso = 29
    ('Engenharia de Software', 7),              -- id_curso = 30
    ('Administração', 7),                       -- id_curso = 31
    ('Psicologia', 7),                          -- id_curso = 32

    -- ID 8: UFMG (Belo Horizonte/MG)
    ('Medicina', 8),                            -- id_curso = 33
    ('Engenharia Civil', 8),                    -- id_curso = 34
    ('Ciência da Computação', 8),               -- id_curso = 35
    ('Direito', 8),                             -- id_curso = 36

    -- ID 9: USP (São Paulo/SP)
    ('Medicina', 9),                            -- id_curso = 37
    ('Engenharia Elétrica', 9),                 -- id_curso = 38
    ('Ciência da Computação', 9),               -- id_curso = 39
    ('Direito', 9),                             -- id_curso = 40

    -- ID 10: Unifor (Fortaleza/CE)
    ('Medicina', 10),                           -- id_curso = 41
    ('Direito', 10),                            -- id_curso = 42
    ('Engenharia Civil', 10),                   -- id_curso = 43
    ('Administração', 10),                      -- id_curso = 44

    -- ID 11: PUC-RS (Porto Alegre/RS)
    ('Medicina', 11),                           -- id_curso = 45
    ('Direito', 11),                            -- id_curso = 46
    ('Engenharia Civil', 11),                   -- id_curso = 47
    ('Psicologia', 11),                         -- id_curso = 48

    -- ID 12: UNIC (Cuiabá/MT)
    ('Enfermagem', 12),                         -- id_curso = 49
    ('Administração', 12),                      -- id_curso = 50
    ('Direito', 12),                            -- id_curso = 51
    ('Psicologia', 12),                         -- id_curso = 52

    -- ID 13: UFMT (Barra do Garças/MT)
    ('Agronomia', 13),                          -- id_curso = 53
    ('Ciência da Computação', 13),              -- id_curso = 54
    ('Enfermagem', 13),                         -- id_curso = 55
    ('Engenharia de Alimentos', 13),            -- id_curso = 56
    ('Jornalismo', 13),                         -- id_curso = 57

    -- ID 14: UNESP (Registro/SP)
    ('Medicina', 14),                           -- id_curso = 58
    ('Engenharia de Pesca', 14),                -- id_curso = 59
    ('Engenharia Agronômica', 14),              -- id_curso = 60
    ('Zootecnia', 14),                          -- id_curso = 61
    ('Ciências Biológicas', 14),                -- id_curso = 62

    -- ID 15: UFPR (Curitiba/PR)
    -- Cursos de saúde, comunicação, design, zootecnia e turismo
    ('Informática Biomédica', 15),              -- id_curso = 63
    ('Jornalismo', 15),                         -- id_curso = 64
    ('Design Gráfico', 15),                     -- id_curso = 65
    ('Zootecnia', 15),                          -- id_curso = 66
    ('Turismo', 15),                            -- id_curso = 67

    -- ID 16: Udesc (Florianópolis/SC)
    ('Engenharia de Petróleo', 16),             -- id_curso = 68
    ('Engenharia de Pesca', 16),                -- id_curso = 69
    ('Biblioteconomia', 16),                    -- id_curso = 70
    ('Design', 16),                             -- id_curso = 71
    ('Medicina Veterinária', 16),               -- id_curso = 72

    -- ID 17: UPE (Recife/PE)
    ('Engenharia de Controle e Automação', 17), -- id_curso = 73
    ('Engenharia Mecânica Industrial', 17),     -- id_curso = 74
    ('Física de Materiais', 17),                -- id_curso = 75
    ('Administração Pública', 17),              -- id_curso = 76

    -- ID 18: Mackenzie (São Paulo/SP)
    ('Publicidade e Propaganda', 18),           -- id_curso = 77
    ('Arquitetura e Urbanismo', 18),            -- id_curso = 78
    ('Ciências Contábeis', 18),                 -- id_curso = 79
    ('Relações Internacionais', 18),            -- id_curso = 80

    -- ID 19: UFES (Vitória/ES)
    ('Oceanografia', 19),                       -- id_curso = 81
    ('Nutrição', 19),                           -- id_curso = 82
    ('Farmácia', 19),                           -- id_curso = 83
    ('Arquitetura e Urbanismo', 19),            -- id_curso = 84

    -- ID 20: PUC-Rio (Rio de Janeiro/RJ)
    ('Design', 20),                             -- id_curso = 85
    ('Engenharia Ambiental', 20),               -- id_curso = 86
    ('Relações Internacionais', 20),            -- id_curso = 87
    ('Comunicação Social', 20),                 -- id_curso = 88

    -- ID 21: Faculdade SENAI / UniSENAI (Florianópolis/SC)
    ('Ciência de Dados e Inteligência Artificial', 21), -- id_curso = 89
    ('Análise e Desenvolvimento de Sistemas', 21),       -- id_curso = 90
    ('Gestão da Produção Industrial', 21);               -- id_curso = 91


-- Exibe todos os cursos cadastrados em ordem crescente de id_curso, facilitando a conferência da numeração gerada automaticamente.

SELECT * FROM curso
ORDER BY id_curso;
GO


-- SCRIPT DE INSERÇÃO DE DADOS (DML): Tabela disciplina
-- Popula a tabela disciplina com matérias vinculadas aos cursos principais (A carga horária representa a carga da disciplina, não a carga total do curso).
INSERT INTO disciplina (nome, carga_horaria, id_curso)
VALUES

    -- Curso 1: Engenharia de Computação — UniSATC
    ('Banco de Dados', 60, 1),                          -- id_disciplina = 1
    ('Arquitetura de Computadores', 100, 1),            -- id_disciplina = 2
    ('Circuitos Digitais', 100, 1),                     -- id_disciplina = 3
    ('Redes de Computadores I', 100, 1),                -- id_disciplina = 4
    ('Sistema de Controle', 60, 1),                     -- id_disciplina = 5
    
    -- Curso 2: Engenharia de Software — UniSATC
    ('Front-End', 60, 2),                               -- id_disciplina = 6
    ('Banco de Dados I', 60, 2),                        -- id_disciplina = 7
    ('Estruturas de Dados', 60, 2),                     -- id_disciplina = 8
    ('Engenharia de Software', 60, 2),                  -- id_disciplina = 9
    ('Programação para Engenharia', 60, 2),             -- id_disciplina = 10

    -- Curso 5: Psicologia — UniSATC
    ('Sociologia e Antropologia', 60, 5),              -- id_disciplina = 11
    ('Neuropsicologia', 60, 5),                        -- id_disciplina = 12
    ('Psicopatologia I', 60, 5),                       -- id_disciplina = 13
    ('Saúde Mental Coletiva', 60, 5),                  -- id_disciplina = 14
    ('Método Clínico', 60, 5),                         -- id_disciplina = 15

    -- Curso 9: Direito — UNESC
    ('Direito Constitucional', 80, 9),                 -- id_disciplina = 16
    ('Direito Civil', 80, 9),                          -- id_disciplina = 17
    ('Direito Penal', 72, 9),                          -- id_disciplina = 18
    ('Direito do Trabalho', 60, 9),                    -- id_disciplina = 19
    ('Direito Processual Civil', 80, 9),               -- id_disciplina = 20

    -- Curso 12: Medicina — Unicamp
    ('Anatomia Humana', 120, 12),                      -- id_disciplina = 21
    ('Bioquímica', 80, 12),                            -- id_disciplina = 22
    ('Fisiologia Humana', 120, 12),                    -- id_disciplina = 23
    ('Histologia e Embriologia', 80, 12),              -- id_disciplina = 24
    ('Farmacologia', 80, 12),                          -- id_disciplina = 25

    -- Curso 89: Ciência de Dados e Inteligência Artificial — UniSENAI
    ('Fundamentos de Programação', 72, 89),            -- id_disciplina = 26
    ('Estatística Aplicada', 60, 89),                  -- id_disciplina = 27
    ('Banco de Dados', 60, 89),                        -- id_disciplina = 28
    ('Aprendizado de Máquina', 80, 89),                -- id_disciplina = 29
    ('Visualização de Dados', 60, 89);                 -- id_disciplina = 30


-- Exibe as disciplinas cadastradas em ordem crescente de id_disciplina.
SELECT *FROM disciplina
ORDER BY id_disciplina;
GO

-- SCRIPT DE INSERÇÃO DE DADOS (DML): Tabela usuario
-- Popula a tabela usuario com estudantes vinculados aos cursos principais (Os IDs de usuário serão gerados automaticamente de 1 a 27).
-- Os usuários 24, 25, 26 e 27 (curso de Ciência de Dados e IA) não receberão atividades recentes nas próximas tabelas, simulando estudantes inativos.
INSERT INTO usuario (nome, nome_usuario, email, senha_hash, id_curso, fase, data_cadastro)
VALUES

    -- Alunos do curso 1: Engenharia de Computação — UNISATC (id_usuario 1 a 5)
    ('Felipe Costa', 'felipe.costa', 'felipe.costa@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e600e86f7f7a27ae3', 1, 3, '2026-09-03T08:00:00'),  -- Colocar 'T' no espaço para o SQL entender que 03 é um dia e não mês
    ('Gabriela Martins', 'gabriela.martins', 'gabriela.martins@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e700e86f7f7a27ae3', 1, 5, '2026-09-06T11:30:00'),
    ('Henrique Silva', 'henrique.silva', 'henrique.silva@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e800e86f7f7a27ae3', 1, 1, '2026-09-09T13:45:00'),
    ('Isabela Rocha', 'isabela.rocha', 'isabela.rocha@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e900e86f7f7a27ae3', 1, 4, '2026-09-11T15:10:00'),
    ('João Pedro Alves', 'joao.alves', 'joao.alves@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e150e86f7f7a27ae3', 1, 6, '2026-09-12T17:25:00'),

    -- Alunos do curso 2: Engenharia de Software — UNISATC (id_usuario 6 a 10)
    ('Ana Beatriz Souza', 'ana.souza', 'ana.souza@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e100e86f7f7a27ae3', 2, 3, '2026-09-01T08:30:00'),
    ('Bruno Almeida', 'bruno.almeida', 'bruno.almeida@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e200e86f7f7a27ae3', 2, 5, '2026-09-02T09:15:00'),
    ('Carla Menezes', 'carla.menezes', 'carla.menezes@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e300e86f7f7a27ae3', 2, 2, '2026-09-05T14:20:00'),
    ('Diego Ferreira', 'diego.ferreira', 'diego.ferreira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e400e86f7f7a27ae3', 2, 4, '2026-09-08T10:45:00'),
    ('Eduarda Ramos', 'eduarda.ramos', 'eduarda.ramos@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e500e86f7f7a27ae3', 2, 6, '2026-09-10T16:00:00'),

    -- Alunos do curso 5: Psicologia — UNISATC (id_usuario 11 a 15)
    ('Maria de Lurdes da Silva', 'marialurdes.silva', 'marialurdes.silva@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e100e86f7f7a27ae3', 5, 2, '2026-09-01T08:30:00'),
    ('Rafael de Souza', 'rafael.souza', 'rafael.souza@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e200e86f7f7a27ae3', 5, 1, '2026-09-02T09:15:00'),
    ('Julia Ribeiro', 'julia.ribeiro', 'julia.ribeiro@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e300e86f7f7a27ae3', 5, 7, '2026-09-05T14:20:00'),
    ('Pedro Gomes', 'pedro.gomes', 'pedro.gomes@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e400e86f7f7a27ae3', 5, 5, '2026-09-08T10:45:00'),
    ('Carla Teixeira', 'carla.teixeira', 'carla.teixeira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e500e86f7f7a27ae3', 5, 3, '2026-09-10T16:00:00'),

    -- Alunos do curso 9: Direito — UNESC (id_usuario 16 a 19)
    ('Karolina Vieira', 'karolina.vieira', 'karolina.vieira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 9, 2, '2026-09-04T09:00:00'),
    ('Lucas Pereira', 'lucas.pereira', 'lucas.pereira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 9, 4, '2026-09-07T10:30:00'),
    ('Mariana Duarte', 'mariana.duarte', 'mariana.duarte@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 9, 6, '2026-09-10T14:00:00'),
    ('Nicolas Barbosa', 'nicolas.barbosa', 'nicolas.barbosa@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 9, 3, '2026-09-13T16:15:00'), 

    -- Alunos do curso 12: Medicina — Unicamp (id_usuario 20 a 23)
    ('Olivia Cardoso', 'olivia.cardoso', 'olivia.cardoso@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 12, 1, '2026-09-05T08:45:00'),
    ('Pedro Henrique Lima', 'pedro.lima', 'pedro.lima@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 12, 3, '2026-09-08T11:00:00'),
    ('Rafaela Nogueira', 'rafaela.nogueira', 'rafaela.nogueira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 12, 5, '2026-09-11T13:30:00'),
    ('Samuel Oliveira', 'samuel.oliveira', 'samuel.oliveira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 12, 2, '2026-09-14T15:45:00'),

    -- Alunos do curso 89: Ciência de Dados e IA — UniSENAI (id_usuario 24 a 27)
    ('Tatiane Ribeiro', 'tatiane.ribeiro', 'tatiane.ribeiro@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 89, 1, '2026-09-06T09:30:00'), -- Usuário inativo (id 24): não receberá publicações, comentários ou curtidas recentes
    ('Vitor Hugo Santos', 'vitor.santos', 'vitor.santos@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 89, 2, '2026-08-10T10:00:00'),     -- Usuário inativo (id 25): não receberá publicações, comentários ou curtidas recentes
    ('Yasmin Ferreira', 'yasmin.ferreira', 'yasmin.ferreira@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 89, 3, '2026-08-15T11:30:00'), -- Usuário inativo (id 26): não receberá publicações, comentários ou curtidas recentes
    ('Zeca Monteiro', 'zeca.monteiro', 'zeca.monteiro@email.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 89, 4, '2026-08-20T12:00:00');       -- Usuário inativo (id 27): não receberá publicações, comentários ou curtidas recentes


-- Exibe os usuários cadastrados em ordem crescente de id_usuario, permitindo conferir os IDs que serão usados nas próximas tabelas.
SELECT *FROM usuario
ORDER BY id_usuario;
GO

-- 1) PUBLICACAO (38 linhas -> id_publicacao 1 a 38)
INSERT INTO publicacao (id_autor, conteudo, data_publicacao)
VALUES
    -- Autor 1 (Eng. Computacao) - 4 posts
    (1, 'Alguém tem material de revisão de Circuitos Digitais? A prova é na semana que vem.', '2026-09-15T10:20:00'),   -- id 1 (antiga)
    (1, 'Terminei o laboratório de Arquitetura de Computadores. Pipeline fica bem mais claro quando desenhado no papel.', '2026-10-20T14:05:00'), -- id 2
    (1, 'Dica: simular o circuito antes de montar no protoboard economiza muito tempo.', '2026-11-03T09:40:00'),       -- id 3
    (1, 'Alguém quer montar um grupo para estudar para a prova de Redes?', '2026-11-10T19:15:00'),                    -- id 4

    -- Autor 2 (Eng. Computacao) - 3 posts
    (2, 'Primeira semana usando SQL Server e já estou gostando. Comandos DDL são bem diretos.', '2026-10-16T11:30:00'), -- id 5
    (2, 'Finalmente entendi a diferenca entre INNER JOIN e LEFT JOIN, vou compartilhar meu resumo.', '2026-10-28T16:45:00'), -- id 6
    (2, 'Quem mais está fazendo o trabalho de Banco de Dados em dupla?', '2026-11-07T20:10:00'),                      -- id 7

    -- Autor 3 (Eng. Computacao) - 2 posts
    (3, 'Estou com dificuldade em mapas de Karnaugh com 4 variáveis. Dicas?', '2026-10-22T13:00:00'),                 -- id 8
    (3, 'Consegui resolver a lista de Sistemas de Controle. Posso ajudar quem ficou com dúvida.', '2026-11-05T08:50:00'), -- id 9

    -- Autor 4 (Eng. Computacao) - 1 post
    (4, 'Alguém sabe se o laboratorio de Redes abre no sábado para revisão?', '2026-11-01T15:35:00'),                 -- id 10

    -- Autor 6 (Eng. Software) - 4 posts
    (6, 'Comecei a estudar estruturas de dados em Python. Pilha e fila são mais simples do que imaginei.', '2026-09-20T09:10:00'), -- id 11 (antiga)
    (6, 'Publiquei meu resumo de listas encadeadas, quem quiser é só pedir.', '2026-10-15T10:00:00'),                 -- id 12
    (6, 'Maratona de programação confirmada para o fim do mês. Quem topa formar time?', '2026-10-30T17:20:00'),       -- id 13
    (6, 'Dica de estudo: resolver um exercicio de complexidade por dia já faz diferença.', '2026-11-09T12:40:00'),     -- id 14

    -- Autor 7 (Eng. Software) - 3 posts
    (7, 'Normalizção de banco de dados finalmente fez sentido depois de montar um exemplo real.', '2026-10-17T14:30:00'), -- id 15
    (7, 'Alguém recomenda um bom curso de Git para iniciantes?', '2026-10-31T18:00:00'),                              -- id 16
    (7, 'Compartilhei no grupo o diagrama de classes do nosso projeto.', '2026-11-08T21:05:00'),                      -- id 17

    -- Autor 8 (Eng. Software) - 2 posts
    (8, 'Flexbox ou Grid? Estou testando os dois no projeto de Front-End.', '2026-10-21T10:50:00'),                   -- id 18
    (8, 'Primeira vez que consegui deixar uma página totalmente responsiva!', '2026-11-04T16:15:00'),                 -- id 19

    -- Autor 9 (Eng. Software) - 1 post
    (9, 'Alguém têm exemplos de diagramas UML para Engenharia de Software?', '2026-11-02T11:20:00'),                  -- id 20

    -- Autor 11 (Psicologia) - 3 posts
    (11, 'Estou lendo sobre neuroplasticidade para a aula de Neuropsicologia. Conteúdo fascinante.', '2026-09-18T15:00:00'), -- id 21 (antiga)
    (11, 'Organizei um resumo sobre as funções do lobo frontal, posso compartilhar.', '2026-10-25T10:30:00'),          -- id 22
    (11, 'Quem está indo no seminário de Saúde Mental na próxima semana?', '2026-11-06T14:20:00'),                    -- id 23

    -- Autor 12 (Psicologia) - 2 posts
    (12, 'Estudo de caso de Psicopatologia I foi desafiador, mas aprendi muito.', '2026-10-18T09:45:00'),             -- id 24
    (12, 'Alguém tem indicação de livros sobre Método Clínico?', '2026-11-02T17:10:00'),                              -- id 25

    -- Autor 13 (Psicologia) - 1 post
    (13, 'Comecei a montar fichamentos de Sociologia e Antropologia, ajuda bastante na revisão.', '2026-10-29T13:25:00'), -- id 26

    -- Autor 16 (Direito) - 3 posts
    (16, 'Revisando príncipios constitucionais para a prova. Legalidade é o mais cobrado.', '2026-09-25T08:40:00'),    -- id 27 (antiga)
    (16, 'Formei um grupo de estudos de Direito Constitucional, entrem lá!', '2026-10-24T19:00:00'),                  -- id 28
    (16, 'Alguém pode explicar a diferença entre controle difuso e concentrado?', '2026-11-08T10:35:00'),             -- id 29

    -- Autor 17 (Direito) - 2 posts
    (17, 'Resumo de Direito Penal sobre excludentes de ilicitude disponível para quem precisar.', '2026-10-19T15:50:00'), -- id 30
    (17, 'Prova de Direito Penal amanhã. Boa sorte para todos!', '2026-11-05T22:10:00'),                              -- id 31

    -- Autor 18 (Direito) - 1 post
    (18, 'Prescrição e decadência ainda me confundem. Alguém tem um esquema?', '2026-10-27T12:15:00'),                -- id 32

    -- Autor 20 (Medicina) - 3 posts
    (20, 'Montei flashcards de Anatomia Humana sobre ossos do carpo. Quem quer?', '2026-10-05T09:30:00'),             -- id 33 (fora dos 30 dias)
    (20, 'Aula pratica de Anatomia hoje foi incrivel. Muito diferente de estudar so pelo atlas.', '2026-10-26T18:40:00'), -- id 34
    (20, 'Grupo de resumos de Anatomia aberto, fiquem a vontade para participar.', '2026-11-09T14:00:00'),            -- id 35

    -- Autor 21 (Medicina) - 2 posts
    (21, 'Ciclo de Krebs decorado, agora falta entender a regulação.', '2026-10-08T11:05:00'),                        -- id 36 (fora dos 30 dias)
    (21, 'Alguém tem boas questões de Fisiologia Humana para treinar?', '2026-11-04T20:30:00'),                       -- id 37

    -- Autor 22 (Medicina) - 1 post
    (22, 'Histologia e Embriologia exigem muita memorização visual. Estou usando laminas digitais.', '2026-10-23T16:55:00'); -- id 38

SELECT * FROM publicacao 
ORDER BY id_publicacao;
GO

-- 2) PERGUNTA (30 linhas -> id_pergunta 1 a 30)
-- Coerencia: cada aluno pergunta em disciplina do proprio curso
--   Curso 1 -> disciplinas 1-5 | Curso 2 -> 6-10 | Curso 5 -> 11-15
--   Curso 9 -> 16-20 | Curso 12 -> 21-25
INSERT INTO pergunta (id_autor, id_disciplina, titulo, descricao, data_pergunta)
VALUES
    -- Eng. Computacao
    (1, 3, 'Minimização com mapas de Karnaugh', 'Como agrupar corretamente os uns em um mapa de Karnaugh de 4 variáveis quando existem condições irrelevantes (dont care)?', '2026-10-14T10:15:00'),     -- id 1
    (2, 1, 'Diferença entre INNER JOIN e LEFT JOIN', 'Em quais situações devo usar LEFT JOIN em vez de INNER JOIN? Um exemplo com duas tabelas ajudaria.', '2026-10-18T14:30:00'),                         -- id 2
    (3, 2, 'Como funciona o pipeline de instruções?', 'Quais sao os estágios do pipeline clássico e como o processador lida com hazards de dados?', '2026-10-22T09:50:00'),                                 -- id 3
    (4, 4, 'Switch ou roteador?', 'Qual a diferença prática entre um switch e um roteador dentro de uma rede local?', '2026-10-26T16:20:00'),                                                           -- id 4
    (5, 5, 'Interpretação de função de transferencia', 'Como identificar polos e zeros em uma função de transferência e o que isso diz sobre a estabilidade?', '2026-11-02T11:00:00'),                   -- id 5
    (1, 1, 'Quando criar índices no banco de dados?', 'Índices sempre melhoram o desempenho? Em que casos eles podem atrapalhar?', '2026-11-06T15:40:00'),                                              -- id 6
    (3, 3, 'Funcionamento do flip-flop JK', 'Qual a diferença entre o flip-flop JK e o flip-flop D, e o que acontece quando J e K valem 1?', '2026-11-09T08:45:00'),                                    -- id 7

    -- Eng. Software
    (6, 8, 'Diferença entre pilha e fila', 'Pilha e fila sao implementadas de formas parecidas, mas qual a diferença de uso em problemas reais?', '2026-10-15T13:10:00'),                              -- id 8
    (7, 7, 'Normalização: 2FN e 3FN', 'Como identificar dependência parcial e dependência transitiva em uma tabela?', '2026-10-19T17:25:00'),                                                          -- id 9
    (8, 6, 'Flexbox versus Grid', 'Quando e melhor usar Flexbox e quando e melhor usar CSS Grid para montar o layout de uma página?', '2026-10-24T10:05:00'),                                           -- id 10
    (9, 9, 'Quando usar diagrama de classes?', 'Em que fase do projeto o diagrama de classes é mais útil e qual nível de detalhe devo colocar?', '2026-10-29T19:35:00'),                                -- id 11
    (10, 10, 'Organizando módulos em Python', 'Como dividir um projeto Python em módulos e pacotes sem gerar importação circular?', '2026-11-03T12:50:00'),                                              -- id 12
    (6, 8, 'Complexidade da busca binária', 'Por que a busca binária tem complexidade O(log n) e qual a condição para usá-la?', '2026-11-07T09:20:00'),                                                -- id 13
    (7, 7, 'Chave estrangeira e integridade', 'O que acontece ao tentar excluir um registro que é referenciado por uma chave estrangeira?', '2026-11-10T14:15:00'),                                     -- id 14

    -- Psicologia
    (11, 12, 'Funções do lobo frontal', 'Quais funções executivas estão ligadas ao lobo frontal e como elas podem ser avaliadas?', '2026-10-17T10:40:00'),                                            -- id 15
    (12, 13, 'Critérios diagnósticos em Psicopatologia', 'Qual a diferença entre sintoma, síndrome e transtorno na prática clínica?', '2026-10-21T15:30:00'),                                          -- id 16
    (13, 11, 'Conceito de fato social', 'Como o conceito de fato social de Durkheim se aplica na análise de comportamentos coletivos?', '2026-10-28T11:25:00'),                                         -- id 17
    (14, 15, 'Estrutura da entrevista clínica', 'Quais são as etapas básicas de uma entrevista clínica inicial?', '2026-11-04T16:00:00'),                                                             -- id 18
    (15, 14, 'Reforma psiquiatrica no Brasil', 'Quais foram os marcos principais da reforma psiquiatrica e seu impacto nos serviços de saúde mental?', '2026-11-08T13:45:00'),                         -- id 19

    -- Direito
    (16, 16, 'Princípio da legalidade', 'Qual a diferença entre o princípio da legalidade para o particular e para a administração pública?', '2026-10-16T09:30:00'),                                    -- id 20
    (17, 18, 'Excludentes de ilicitude', 'Quais são as excludentes de ilicitude previstas no Codigo Penal e como diferenciar legítima defesa de estado de necessidade?', '2026-10-23T18:10:00'),        -- id 21
    (18, 17, 'Prescrição e decadência', 'Como diferenciar prescrição de decadência e quais os prazos mais comuns no Direito Civil?', '2026-10-30T10:55:00'),                                         -- id 22
    (19, 19, 'Horas extras e banco de horas', 'Como funciona a compensação de horas no banco de horas e qual o limite previsto na CLT?', '2026-11-05T14:40:00'),                                       -- id 23
    (16, 20, 'Contagem de prazos processuais', 'Como contar prazos no Processo Civil: dias úteis, inicio e termo final?', '2026-11-09T11:30:00'),                                                      -- id 24

    -- Medicina
    (20, 21, 'Ossos do carpo', 'Existe alguma técnica para memorizar os oito ossos do carpo na ordem correta?', '2026-10-14T19:20:00'),                                                                -- id 25
    (21, 22, 'Regulção do ciclo de Krebs', 'Quais enzimas regulam o ciclo de Krebs e como a célula controla essa via?', '2026-10-20T08:35:00'),                                                       -- id 26
    (22, 23, 'Potencial de ação', 'Quais são as fases do potencial de ação em um neurônio e o papel dos canais de sódio e potássio?', '2026-10-27T15:15:00'),                                           -- id 27
    (23, 25, 'Conceitos de farmacocinetica', 'Qual a diferença entre absorção, distribuição, metabolismo e excreção de um farmaco?', '2026-11-01T12:00:00'),                                           -- id 28
    (20, 24, 'Tecido epitelial de revestimento', 'Como classificar os epitelios de revestimento quanto ao número de camadas e ao formato das células?', '2026-11-06T09:10:00'),                       -- id 29
    (21, 21, 'Músculos do manguito rotador', 'Quais são os quatro músculos do manguito rotador e qual a função de cada um?', '2026-11-10T17:45:00');                                                  -- id 30

SELECT * FROM pergunta 
ORDER BY id_pergunta;
GO

-- 3) GRUPO_ESTUDO (20 linhas -> id_grupo 1 a 20)
-- Todas as datas sao posteriores ao cadastro do criador
INSERT INTO grupo_estudo (nome, descricao, id_criador, data_criacao)
VALUES
    ('Grupo de Estudos T-SQL e Banco de Dados', 'Troca de exercícios e revisão de comandos SQL Server, joins e modelagem.', 2, '2026-10-10T19:00:00'),                       -- id 1
    ('Maratona de Programação UniSATC', 'Treino semanal de problemas de algoritmos e estruturas de dados para competições.', 6, '2026-10-12T18:30:00'),                    -- id 2
    ('Circuitos Digitais na Prática', 'Resolução de listas, simulações e montagens de circuitos combinacionais e sequenciais.', 1, '2026-10-14T20:00:00'),                  -- id 3
    ('Revisão de Direito Penal', 'Encontros para revisar teoria do crime, excludentes e penas com questões de provas.', 17, '2026-10-15T17:45:00'),                        -- id 4
    ('Anatomia Humana - Resumos', 'Compartilhamento de resumos, flashcards e roteiros de estudo de anatomia.', 20, '2026-10-16T21:00:00'),                                 -- id 5
    ('Estruturas de Dados em Python', 'Implementação de listas, pilhas, filas e árvores em Python com exercícios guiados.', 7, '2026-10-18T19:30:00'),                      -- id 6
    ('Neuropsicologia Descomplicada', 'Leitura de artigos e discussão de casos sobre funções cognitivas e cérebro.', 11, '2026-10-19T16:00:00'),                           -- id 7
    ('Redes de Computadores - Laboratório', 'Práticas de configuração de redes, endereçamento IP e simulações de topologias.', 4, '2026-10-21T20:15:00'),                   -- id 8
    ('Direito Constitucional em Debate', 'Discussão de princípios constitucionais e jurisprudência dos tribunais superiores.', 16, '2026-10-22T18:00:00'),                  -- id 9
    ('Fisiologia e Bioquímica Integradas', 'Estudo integrado de metabolismo, fisiologia de sistemas e casos clínicos.', 21, '2026-10-23T19:45:00'),                        -- id 10
    ('Front-End com HTML, CSS e JavaScript', 'Troca de projetos, revisao de layouts responsivos e boas praticas de front-end.', 8, '2026-10-25T15:30:00'),                 -- id 11
    ('Psicopatologia - Estudos de Caso', 'Análise de casos fictícios para treinar racíocinio diagnóstico e clínico.', 12, '2026-10-26T17:00:00'),                          -- id 12
    ('Engenharia de Software e Metodologias Ágeis', 'Discussão sobre Scrum, UML, requisitos e boas práticas de desenvolvimento.', 9, '2026-10-28T20:00:00'),               -- id 13
    ('Direito do Trabalho - Casos Práticos', 'Resolução de casos sobre jornada, rescisão, horas extras e direitos trabalhistas.', 16, '2026-10-29T18:30:00'),              -- id 14
    ('Farmacologia Clinica', 'Estudo de classes de farmacos, mecanismos de acao e interacoes medicamentosas.', 23, '2026-10-30T21:15:00'),                                 -- id 15
    ('Arquitetura de Computadores - Revisão', 'Revisão de pipeline, memória cache e conjunto de instruções para as provas.', 3, '2026-11-01T19:00:00'),                      -- id 16
    ('Saude Mental Coletiva', 'Debates sobre politicas publicas, reforma psiquiatrica e atuacao em servicos de saude.', 14, '2026-11-02T16:30:00'),                         -- id 17
    ('Direito Civil - Resolucao de Questoes', 'Pratica de questoes sobre obrigacoes, contratos, prescricao e decadencia.', 17, '2026-11-04T18:45:00'),                      -- id 18
    ('Histologia e Embriologia', 'Estudo de laminas, classificação de tecidos e etapas do desenvolvimento embrionário.', 22, '2026-11-05T20:30:00'),                       -- id 19
    ('Python para Engenharia', 'Aplicações de Python em cálculos, automação e resolução de problemas de engenharia.', 10, '2026-11-07T17:15:00');                          -- id 20

SELECT * FROM grupo_estudo 
ORDER BY id_grupo;
GO


-- 4) SEGUIDOR (48 pares, sem repeticao e sem auto-seguir)
-- Alguns usuarios sao mais seguidos (1, 6, 2, 11, 16, 20) para dar variedade ao ranking
-- Pares inversos como (6,11) e (11,6) sao permitidos
INSERT INTO seguidor (id_seguidor, id_seguido, data_inicio)
VALUES
    -- Seguindo o usuario 1
    (2, 1, '2026-09-18T10:00:00'), (3, 1, '2026-09-20T11:30:00'), (4, 1, '2026-09-25T09:15:00'), (5, 1, '2026-10-02T14:00:00'),
    (6, 1, '2026-10-05T16:20:00'), (7, 1, '2026-10-12T18:40:00'), (8, 1, '2026-10-20T12:10:00'),
    -- Seguindo o usuario 2
    (1, 2, '2026-09-19T13:00:00'), (3, 2, '2026-09-28T15:45:00'), (4, 2, '2026-10-08T10:30:00'), (9, 2, '2026-10-15T19:20:00'), (6, 2, '2026-10-22T08:50:00'),
    -- Seguindo o usuario 6
    (1, 6, '2026-09-22T17:00:00'), (7, 6, '2026-09-26T09:30:00'), (8, 6, '2026-10-03T11:15:00'), (9, 6, '2026-10-10T20:00:00'),
    (10, 6, '2026-10-18T14:25:00'), (2, 6, '2026-10-27T16:40:00'),
    -- Seguindo o usuario 7
    (6, 7, '2026-09-24T12:00:00'), (8, 7, '2026-10-06T18:10:00'), (1, 7, '2026-10-14T10:45:00'), (10, 7, '2026-11-01T13:35:00'),
    -- Seguindo o usuario 11
    (12, 11, '2026-09-21T09:00:00'), (13, 11, '2026-09-29T15:20:00'), (14, 11, '2026-10-07T11:50:00'), (15, 11, '2026-10-16T17:30:00'), (6, 11, '2026-11-03T10:10:00'),
    -- Seguindo o usuario 12
    (11, 12, '2026-09-23T14:40:00'), (13, 12, '2026-10-09T16:15:00'), (14, 12, '2026-10-24T19:05:00'),
    -- Seguindo o usuario 16
    (17, 16, '2026-09-27T10:20:00'), (18, 16, '2026-10-04T13:55:00'), (19, 16, '2026-10-13T08:40:00'), (2, 16, '2026-11-05T21:00:00'),
    -- Seguindo o usuario 17
    (16, 17, '2026-09-30T18:30:00'), (18, 17, '2026-10-11T12:25:00'), (19, 17, '2026-10-21T15:50:00'),
    -- Seguindo os usuarios 20, 21 e 22
    (21, 20, '2026-09-26T11:00:00'), (22, 20, '2026-10-01T09:45:00'), (23, 20, '2026-10-17T20:10:00'), (1, 20, '2026-11-02T14:30:00'),
    (20, 21, '2026-10-19T17:15:00'), (22, 21, '2026-10-25T10:05:00'), (23, 21, '2026-11-04T16:45:00'),
    (20, 22, '2026-10-28T13:20:00'),
    -- Conexoes extras
    (5, 3, '2026-10-23T09:55:00'), (9, 8, '2026-10-30T18:25:00'), (11, 6, '2026-11-06T12:30:00');

SELECT * FROM seguidor 
ORDER BY id_seguido, id_seguidor;
GO

-- 5) MENSAGEM (36 linhas -> id_mensagem 1 a 36)
-- lida: 1 = lida, 0 = não lida | remetente sempre diferente do destinatario
-- Conversas em ida e volta + algumas mensagens recentes não lidas
INSERT INTO mensagem (id_remetente, id_destinatario, conteudo, data_envio, lida)
VALUES
    -- Conversa 1 <-> 2 (Banco de Dados)
    (1, 2, 'Oi! Você já começou o trabalho de Banco de Dados?', '2026-10-17T20:10:00', 1),                       -- id 1
    (2, 1, 'Comecei ontem, já fiz o modelo conceitual. Quer ver?', '2026-10-17T20:25:00', 1),                    -- id 2
    (1, 2, 'Quero sim! Me manda por aqui quando terminar.', '2026-10-17T20:30:00', 1),                           -- id 3
    (2, 1, 'Enviei o arquivo no grupo, dá uma olhada amanhã.', '2026-10-18T09:00:00', 0),                        -- id 4

    -- Conversa 6 <-> 7 (Maratona e Estruturas de Dados)
    (6, 7, 'Você vai participar da maratona de programação?', '2026-10-20T18:15:00', 1),                         -- id 5
    (7, 6, 'Vou sim! Preciso treinar mais árvores e grafos.', '2026-10-20T18:40:00', 1),                         -- id 6
    (6, 7, 'Vamos treinar juntos na sexta, às 19h?', '2026-10-20T18:45:00', 1),                                  -- id 7
    (7, 6, 'Fechado, combinado!', '2026-10-20T19:00:00', 1),                                                     -- id 8

    -- Conversa 11 <-> 12 (Psicologia)
    (11, 12, 'Você têm o resumo de Neuropsicologia da última aula?', '2026-10-22T14:00:00', 1),                  -- id 9
    (12, 11, 'Tenho sim, te envio hoje à noite.', '2026-10-22T14:20:00', 1),                                     -- id 10
    (11, 12, 'Obrigada! Me salvou.', '2026-10-22T14:25:00', 1),                                                  -- id 11

    -- Conversa 16 <-> 17 (Direito)
    (16, 17, 'Vai estudar Direito Penal hoje à noite?', '2026-10-25T17:30:00', 1),                               -- id 12
    (17, 16, 'Vou, as 20h. Pode entrar no grupo.', '2026-10-25T17:50:00', 1),                                    -- id 13
    (16, 17, 'Perfeito, já estou entrando.', '2026-10-25T17:55:00', 1),                                          -- id 14

    -- Conversa 20 <-> 21 (Medicina)
    (20, 21, 'Você já viu os flashcards de Anatomia que postei?', '2026-10-27T21:00:00', 1),                     -- id 15
    (21, 20, 'Vi sim, estão muito bons! Posso copiar para meu caderno?', '2026-10-27T21:20:00', 1),              -- id 16
    (20, 21, 'Claro, fique a vontade.', '2026-10-27T21:25:00', 1),                                               -- id 17

    -- Mensagens soltas entre cursos e colegas
    (3, 1, 'Pode me explicar mapas de Karnaugh amanhã na faculdade?', '2026-10-29T22:00:00', 1),                 -- id 18
    (1, 3, 'Posso, nos encontramos no intervalo.', '2026-10-30T07:30:00', 1),                                    -- id 19
    (8, 6, 'Vi seu post sobre listas encadeadas, pode compartilhar o resumo?', '2026-10-31T15:10:00', 1),        -- id 20
    (6, 8, 'Claro, te mando agora.', '2026-10-31T15:30:00', 1),                                                  -- id 21
    (13, 11, 'Posso entrar no grupo de Neuropsicologia?', '2026-11-01T10:00:00', 1),                             -- id 22
    (11, 13, 'Pode sim, acabei de te adicionar.', '2026-11-01T10:15:00', 1),                                     -- id 23
    (18, 16, 'Obrigado pelo convite para o grupo de Direito Constitucional.', '2026-11-02T19:00:00', 1),         -- id 24
    (22, 20, 'Você tem o roteiro de estudo de Histologia?', '2026-11-03T16:45:00', 0),                           -- id 25
    (9, 2, 'Oi! Vi que você entende de SQL, pode me ajudar com uma consulta?', '2026-11-04T13:20:00', 1),        -- id 26
    (2, 9, 'Posso sim, me manda o enunciado.', '2026-11-04T13:45:00', 1),                                        -- id 27
    (9, 2, 'Enviei! Qualquer coisa me avisa.', '2026-11-04T14:00:00', 0),                                        -- id 28

    -- Mensagens recentes ainda nao lidas
    (4, 1, 'O laboratório de Redes abre no sábado mesmo?', '2026-11-08T09:30:00', 0),                            -- id 29
    (7, 6, 'Nosso time da maratona ainda precisa de mais uma pessoa.', '2026-11-09T18:10:00', 0),                -- id 30
    (23, 21, 'Tem questões de Fisiologia para compartilhar?', '2026-11-10T20:00:00', 0),                         -- id 31
    (19, 17, 'Pode me passar o resumo de excludentes de ilicitude?', '2026-11-10T21:30:00', 0),                  -- id 32
    (14, 12, 'Vi que você indicou livros de Método Clínico, qual o título?', '2026-11-11T11:15:00', 0),          -- id 33
    (5, 3, 'Oi, vamos estudar Sistemas de Controle juntos?', '2026-11-11T14:40:00', 0),                          -- id 34
    (10, 7, 'Você pode revisar meu codigo em Python do trabalho?', '2026-11-11T16:20:00', 1),                    -- id 35
    (7, 10, 'Posso sim, me envia por aqui.', '2026-11-11T16:50:00', 0);                                          -- id 36

SELECT * FROM mensagem 
ORDER BY id_mensagem;
GO

-- 5) CURTIDA (80 linhas) | PK composta (id_usuario, id_publicacao): sem pares repetidos
-- Publicacoes "virais": 2 (9 curtidas), 6 (8), 13 (10), 22 (7), 28 (8), 35 (6)
-- Publicacoes com 1 ou 2 curtidas: 22 posts | Sem nenhuma curtida: 1, 8, 10, 11, 20, 21, 26, 27, 32, 36
INSERT INTO curtida (id_usuario, id_publicacao, data_curtida)
VALUES
    -- Publicacao 2 (autor 1, 20/10 14:05) - 9 curtidas
    (2, 2, '2026-10-20T15:10:00'), (3, 2, '2026-10-20T18:30:00'), (4, 2, '2026-10-21T09:00:00'),
    (5, 2, '2026-10-21T12:45:00'), (6, 2, '2026-10-21T20:15:00'), (7, 2, '2026-10-22T08:30:00'),
    (8, 2, '2026-10-22T19:10:00'), (9, 2, '2026-10-23T10:00:00'), (10, 2, '2026-10-24T14:20:00'),

    -- Publicacao 6 (autor 2, 28/10 16:45) - 8 curtidas
    (1, 6, '2026-10-28T18:00:00'), (3, 6, '2026-10-28T21:30:00'), (4, 6, '2026-10-29T08:15:00'),
    (6, 6, '2026-10-29T13:40:00'), (7, 6, '2026-10-29T20:05:00'), (8, 6, '2026-10-30T09:50:00'),
    (9, 6, '2026-10-30T15:25:00'), (12, 6, '2026-10-31T11:10:00'),

    -- Publicacao 13 (autor 6, 30/10 17:20) - 10 curtidas
    (1, 13, '2026-10-30T18:05:00'), (2, 13, '2026-10-30T19:40:00'), (3, 13, '2026-10-31T08:20:00'),
    (4, 13, '2026-10-31T10:55:00'), (7, 13, '2026-10-31T14:30:00'), (8, 13, '2026-10-31T21:00:00'),
    (9, 13, '2026-11-01T09:35:00'), (10, 13, '2026-11-01T16:45:00'), (11, 13, '2026-11-02T10:10:00'),
    (16, 13, '2026-11-03T12:25:00'),

    -- Publicacao 22 (autor 11, 25/10 10:30) - 7 curtidas
    (12, 22, '2026-10-25T12:00:00'), (13, 22, '2026-10-25T15:40:00'), (14, 22, '2026-10-26T09:30:00'),
    (15, 22, '2026-10-26T18:20:00'), (1, 22, '2026-10-27T11:15:00'), (7, 22, '2026-10-28T13:50:00'),
    (16, 22, '2026-10-29T10:05:00'),

    -- Publicacao 28 (autor 16, 24/10 19:00) - 8 curtidas
    (17, 28, '2026-10-24T20:15:00'), (18, 28, '2026-10-25T08:40:00'), (19, 28, '2026-10-25T14:25:00'),
    (2, 28, '2026-10-26T10:30:00'), (11, 28, '2026-10-26T17:55:00'), (12, 28, '2026-10-27T09:20:00'),
    (20, 28, '2026-10-28T12:35:00'), (6, 28, '2026-10-29T15:10:00'),

    -- Publicacao 35 (autor 20, 09/11 14:00) - 6 curtidas
    (21, 35, '2026-11-09T15:30:00'), (22, 35, '2026-11-09T19:45:00'), (23, 35, '2026-11-10T08:10:00'),
    (1, 35, '2026-11-10T13:20:00'), (7, 35, '2026-11-11T09:40:00'), (16, 35, '2026-11-11T18:00:00'),

    -- Demais publicacoes com 1 ou 2 curtidas
    (5, 3, '2026-11-03T12:00:00'),
    (2, 4, '2026-11-10T21:00:00'), (6, 4, '2026-11-11T08:30:00'),
    (1, 5, '2026-10-16T14:00:00'), (7, 5, '2026-10-17T09:20:00'),
    (8, 7, '2026-11-08T10:00:00'),
    (1, 9, '2026-11-05T12:30:00'),
    (7, 12, '2026-10-16T08:15:00'), (1, 12, '2026-10-18T19:00:00'),
    (8, 14, '2026-11-09T20:30:00'),
    (6, 15, '2026-10-17T18:00:00'), (2, 15, '2026-10-19T11:45:00'),
    (6, 16, '2026-11-01T09:10:00'),
    (6, 17, '2026-11-09T10:20:00'), (10, 17, '2026-11-09T22:15:00'),
    (6, 18, '2026-10-22T08:00:00'),
    (9, 19, '2026-11-05T09:30:00'),
    (12, 23, '2026-11-06T16:50:00'), (13, 23, '2026-11-07T10:25:00'),
    (11, 24, '2026-10-18T14:10:00'),
    (13, 25, '2026-11-03T09:00:00'),
    (19, 29, '2026-11-08T14:00:00'), (18, 29, '2026-11-09T08:45:00'),
    (16, 30, '2026-10-19T18:30:00'), (18, 30, '2026-10-20T09:15:00'),
    (16, 31, '2026-11-06T08:00:00'),
    (21, 33, '2026-10-05T20:00:00'),
    (21, 34, '2026-10-26T21:30:00'), (22, 34, '2026-10-27T08:50:00'),
    (23, 37, '2026-11-05T10:15:00'),
    (20, 38, '2026-10-24T09:05:00'), (21, 38, '2026-10-24T20:40:00');

SELECT * FROM curtida 
ORDER BY id_publicacao, data_curtida;
GO

-- 6) COMENTARIO (41 linhas) | concentrado nas publicações mais curtidas (2, 6, 13, 22, 28, 35)
-- Colunas: id_publicacao, id_usuario, texto, data_comentario
INSERT INTO comentario (id_publicacao, id_usuario, texto, data_comentario)
VALUES
    -- Publicacao 2
    (2, 3, 'Boa dica! Desenhar os estágios no papel ajuda muito a visualizar o pipeline.', '2026-10-20T16:30:00'),
    (2, 5, 'Também achei o laboratório bem tranquilo depois de entender os hazards.', '2026-10-21T10:15:00'),
    (2, 1, 'Valeu pessoal! Se quiserem, posso compartilhar o esquema que fiz.', '2026-10-21T14:00:00'),
    (2, 8, 'Compartilha sim, vai ajudar no estudo para a prova.', '2026-10-22T09:40:00'),

    -- Publicacao 6
    (6, 1, 'Resumo ficou muito claro, principalmente a parte do LEFT JOIN.', '2026-10-28T19:10:00'),
    (6, 4, 'Salvou meu trabalho de Banco de Dados, obrigado!', '2026-10-29T09:00:00'),
    (6, 2, 'Fico feliz que ajudou! Qualquer dúvida é só chamar.', '2026-10-29T10:30:00'),
    (6, 9, 'Dá para usar esse resumo também em Banco de Dados I?', '2026-10-30T11:20:00'),

    -- Publicacao 13
    (13, 7, 'Já estou dentro! Vamos montar o time no grupo da maratona.', '2026-10-30T18:30:00'),
    (13, 8, 'Eu topo, só preciso revisar grafos antes.', '2026-10-31T09:15:00'),
    (13, 6, 'Ótimo, o time já tem três pessoas. Falta mais uma vaga!', '2026-10-31T12:00:00'),
    (13, 10, 'Posso entrar? Ainda estou aprendendo, mas quero participar.', '2026-11-01T10:45:00'),
    (13, 2, 'Se tiver vaga, também quero participar da próxima edição.', '2026-11-01T20:10:00'),
    (13, 1, 'Boa iniciativa! Vou acompanhar pelo grupo.', '2026-11-02T14:35:00'),

    -- Publicacao 22
    (22, 12, 'Muito útil esse resumo, principalmente sobre planejamento e controle.', '2026-10-25T13:20:00'),
    (22, 13, 'Pode compartilhar o arquivo por mensagem?', '2026-10-26T10:40:00'),
    (22, 11, 'Claro, te envio ainda hoje!', '2026-10-26T11:30:00'),
    (22, 14, 'Ajudou muito na revisão para a prova de Neuropsicologia.', '2026-10-27T17:05:00'),

    -- Publicacao 28
    (28, 17, 'Já entrei no grupo, vamos começar pelos princípios fundamentais?', '2026-10-24T21:00:00'),
    (28, 18, 'Ótima ideia, obrigada pelo convite!', '2026-10-25T09:45:00'),
    (28, 16, 'De nada! Encontro na quarta às 18h.', '2026-10-25T10:20:00'),
    (28, 19, 'Vou participar, preciso revisar controle de constitucionalidade.', '2026-10-26T15:30:00'),
    (28, 12, 'Interessante, gostaria de acompanhar as discussões também.', '2026-10-27T11:00:00'),

    -- Publicacao 35
    (35, 21, 'Entrei no grupo, os resumos estão muito bem organizados.', '2026-11-09T16:15:00'),
    (35, 22, 'Perfeito! Vou postar meus flashcards de Histologia lá também.', '2026-11-10T09:20:00'),
    (35, 20, 'Excelente, quanto mais material melhor para todo mundo.', '2026-11-10T10:00:00'),
    (35, 23, 'Pode me adicionar? Quero estudar Farmacologia junto.', '2026-11-11T12:40:00'),

    -- Demais publicacoes (1 comentario ou poucos)
    (3, 5, 'Boa dica, vou testar no laboratório de Circuitos.', '2026-11-03T13:10:00'),
    (4, 2, 'Eu topo! Podemos estudar pelo grupo de Redes.', '2026-11-10T21:20:00'),
    (4, 3, 'Também quero participar, qual horário?', '2026-11-11T09:00:00'),
    (5, 1, 'Também comecei agora, os comandos DDL são bem lógicos.', '2026-10-16T15:00:00'),
    (12, 8, 'Pode me enviar o resumo de listas encadeadas?', '2026-10-16T11:30:00'),
    (15, 6, 'Normalização é difícil no começo, mas com exemplo real fica claro.', '2026-10-17T19:00:00'),
    (17, 10, 'Vou olhar o diagrama e comento o que achar.', '2026-11-09T22:30:00'),
    (19, 6, 'Parabéns! Responsividade é um dos assuntos mais cobrados.', '2026-11-05T08:15:00'),
    (23, 13, 'Eu vou! Alguém tem a programação do seminário?', '2026-11-07T11:10:00'),
    (25, 11, 'Recomendo começar pelos materiais indicados em aula.', '2026-11-03T10:00:00'),
    (29, 17, 'A diferença está em quem pode declarar a inconstitucionalidade.', '2026-11-08T15:20:00'),
    (30, 16, 'Resumo excelente, obrigado por compartilhar!', '2026-10-19T19:00:00'),
    (34, 21, 'Concordo, a aula prática faz toda a diferença.', '2026-10-26T22:00:00'),
    (38, 20, 'As lâminas digitais ajudam bastante, vou testar também.', '2026-10-24T10:30:00');

SELECT * FROM comentario 
ORDER BY id_publicacao, data_comentario;
GO

-- 7) RESPOSTA (40 linhas) | perguntas SEM resposta (em aberto): 5, 12, 19, 24 e 29
-- Colunas: id_pergunta, id_usuario, texto, data_resposta
-- Respondem principalmente colegas do mesmo curso; alguns de cursos proximos
INSERT INTO resposta (id_pergunta, id_usuario, texto, data_resposta)
VALUES
    -- Pergunta 1 (Karnaugh)
    (1, 3, 'Agrupe em potências de 2 e use os dont care como 1 sempre que ajudarem a formar grupos maiores.', '2026-10-14T14:00:00'),
    (1, 2, 'Complementando: comece pelos grupos maiores e só depois feche os menores.', '2026-10-15T09:30:00'),

    -- Pergunta 2 (INNER JOIN x LEFT JOIN)
    (2, 7, 'INNER JOIN traz só registros com correspondência nas duas tabelas; LEFT JOIN mantém todos da tabela da esquerda.', '2026-10-18T16:00:00'),
    (2, 1, 'Exemplo: listar todos os cursos, mesmo os sem disciplinas cadastradas, exige LEFT JOIN.', '2026-10-19T10:20:00'),

    -- Pergunta 3 (pipeline)
    (3, 1, 'Os estágios clássicos são busca, decodificação, execução, memória e escrita. Hazards de dados são tratados com forwarding ou bolhas.', '2026-10-22T12:30:00'),

    -- Pergunta 4 (switch x roteador)
    (4, 2, 'O switch conecta dispositivos na mesma rede; o roteador liga redes diferentes e decide o caminho dos pacotes.', '2026-10-26T19:00:00'),

    -- Pergunta 6 (indices)
    (6, 7, 'Índices aceleram buscas, mas deixam inserções e atualizações mais lentas e ocupam espaço.', '2026-11-06T18:10:00'),
    (6, 2, 'Vale criar índice em colunas muito usadas em WHERE e JOIN, e evitar em tabelas pequenas.', '2026-11-07T08:45:00'),

    -- Pergunta 7 (flip-flop JK)
    (7, 1, 'Com J=K=1 o flip-flop JK inverte a saída a cada pulso de clock (toggle); o D apenas copia a entrada.', '2026-11-09T10:30:00'),

    -- Pergunta 8 (pilha x fila)
    (8, 7, 'Pilha é LIFO (último a entrar é o primeiro a sair) e fila é FIFO. Ex: desfazer ações usa pilha, fila de impressão usa fila.', '2026-10-15T15:00:00'),
    (8, 10, 'Em Python dá para usar list como pilha e collections.deque como fila.', '2026-10-16T09:20:00'),

    -- Pergunta 9 (normalizacao)
    (9, 2, 'Dependência parcial acontece quando um atributo depende só de parte da chave composta (2FN).', '2026-10-19T20:00:00'),
    (9, 6, 'A transitiva é quando um atributo não chave depende de outro não chave (3FN).', '2026-10-20T08:30:00'),

    -- Pergunta 10 (Flexbox x Grid)
    (10, 6, 'Flexbox funciona melhor em uma dimensão (linha ou coluna); Grid é ideal para layouts em duas dimensões.', '2026-10-24T12:15:00'),

    -- Pergunta 11 (diagrama de classes)
    (11, 7, 'O diagrama de classes é mais útil na fase de projeto, antes de começar a codificar. Comece só com classes e relacionamentos principais.', '2026-10-29T21:00:00'),

    -- Pergunta 13 (busca binaria)
    (13, 8, 'A cada comparação o espaço de busca cai pela metade, por isso O(log n).', '2026-11-07T11:40:00'),
    (13, 7, 'E a lista precisa estar ordenada para a busca binária funcionar.', '2026-11-07T14:10:00'),

    -- Pergunta 14 (chave estrangeira)
    (14, 2, 'O SQL Server bloqueia a exclusão e retorna erro de conflito com a constraint de chave estrangeira.', '2026-11-10T16:45:00'),
    (14, 6, 'Dá para usar ON DELETE CASCADE, mas só vale se fizer sentido para o negócio.', '2026-11-11T09:00:00'),

    -- Pergunta 15 (lobo frontal)
    (15, 12, 'Planejamento, tomada de decisão, controle inibitório e memória de trabalho são funções executivas ligadas ao lobo frontal.', '2026-10-17T13:00:00'),
    (15, 13, 'Dá para avaliar com testes como Torre de Londres e Stroop.', '2026-10-17T18:30:00'),

    -- Pergunta 16 (sintoma, sindrome, transtorno)
    (16, 11, 'Sintoma é uma queixa isolada, síndrome é um conjunto de sintomas e transtorno exige critérios diagnósticos definidos.', '2026-10-21T17:45:00'),

    -- Pergunta 17 (fato social)
    (17, 12, 'Para Durkheim, fato social é uma forma de agir, pensar e sentir exterior ao indivíduo e que exerce coerção sobre ele.', '2026-10-28T14:30:00'),

    -- Pergunta 18 (entrevista clinica)
    (18, 11, 'Em geral: acolhimento, queixa principal, história da queixa, histórico pessoal e familiar e devolutiva.', '2026-11-04T18:20:00'),
    (18, 15, 'Vale lembrar do contrato terapêutico no início do atendimento.', '2026-11-05T09:10:00'),

    -- Pergunta 20 (legalidade)
    (20, 17, 'Para o particular vale o que a lei não proíbe; para a administração só vale o que a lei autoriza.', '2026-10-16T11:50:00'),
    (20, 18, 'Está no art. 5º, II, e no art. 37 da Constituição Federal.', '2026-10-16T20:15:00'),

    -- Pergunta 21 (excludentes de ilicitude)
    (21, 16, 'O art. 23 do Código Penal prevê estado de necessidade, legítima defesa, estrito cumprimento do dever legal e exercício regular de direito.', '2026-10-23T20:00:00'),
    (21, 18, 'Na legítima defesa há agressão injusta; no estado de necessidade existe perigo atual que não foi provocado.', '2026-10-24T09:40:00'),

    -- Pergunta 22 (prescricao e decadencia)
    (22, 17, 'Prescrição atinge a pretensão (o direito de exigir); decadência atinge o próprio direito potestativo.', '2026-10-30T13:00:00'),

    -- Pergunta 23 (banco de horas)
    (23, 17, 'O banco de horas precisa de acordo e a compensação deve ocorrer dentro do prazo previsto em lei ou na convenção.', '2026-11-05T16:30:00'),
    (23, 16, 'Vale conferir a reforma trabalhista, que ampliou as regras de compensação.', '2026-11-06T08:20:00'),

    -- Pergunta 25 (ossos do carpo)
    (25, 21, 'Use uma frase mnemônica com as iniciais: escafoide, semilunar, piramidal, pisiforme, trapézio, trapezoide, capitato e hamato.', '2026-10-14T21:15:00'),
    (25, 22, 'Desenhar a mão e nomear cada osso também ajuda bastante.', '2026-10-15T10:00:00'),

    -- Pergunta 26 (ciclo de Krebs)
    (26, 20, 'As principais enzimas reguladoras são citrato sintase, isocitrato desidrogenase e alfa-cetoglutarato desidrogenase.', '2026-10-20T11:00:00'),

    -- Pergunta 27 (potencial de acao)
    (27, 21, 'As fases são repouso, despolarização (entrada de sódio), repolarização (saída de potássio) e hiperpolarização.', '2026-10-27T18:30:00'),
    (27, 23, 'Os canais de sódio abrem primeiro e inativam; depois os de potássio terminam a repolarização.', '2026-10-28T09:15:00'),

    -- Pergunta 28 (farmacocinetica)
    (28, 22, 'Absorção é a entrada na circulação, distribuição é o transporte aos tecidos, metabolismo é a transformação (fígado) e excreção é a eliminação.', '2026-11-01T15:00:00'),

    -- Pergunta 30 (manguito rotador)
    (30, 20, 'Supraespinhal, infraespinhal, redondo menor e subescapular, os músculos do SIRS.', '2026-11-10T19:30:00'),
    (30, 22, 'O supraespinhal inicia a abdução e o subescapular faz a rotação medial do ombro.', '2026-11-11T08:50:00');

SELECT * FROM resposta 
ORDER BY id_pergunta, data_resposta;
GO

-- 8) PARTICIPANTE_GRUPO (74 linhas) | PK composta (id_grupo, id_usuario)
-- O criador de cada grupo entra com data_entrada = data_criacao do grupo
-- Grupos grandes: 1 (8 membros), 2 (7), 5 (7) e 6 (6) | Pequenos: 1 a 4 membros
INSERT INTO participante_grupo (id_grupo, id_usuario, data_entrada)
VALUES
    -- Grupo 1: T-SQL e Banco de Dados (criador 2) - 8 membros
    (1, 2, '2026-10-10T19:00:00'), (1, 1, '2026-10-11T09:30:00'), (1, 3, '2026-10-11T14:20:00'),
    (1, 4, '2026-10-12T10:00:00'), (1, 6, '2026-10-13T18:45:00'), (1, 7, '2026-10-14T20:10:00'),
    (1, 9, '2026-10-16T11:25:00'), (1, 10, '2026-10-18T16:40:00'),

    -- Grupo 2: Maratona de Programacao (criador 6) - 7 membros
    (2, 6, '2026-10-12T18:30:00'), (2, 7, '2026-10-12T20:00:00'), (2, 8, '2026-10-13T09:15:00'),
    (2, 9, '2026-10-13T19:30:00'), (2, 10, '2026-10-14T12:40:00'), (2, 1, '2026-10-15T18:20:00'),
    (2, 2, '2026-10-17T21:05:00'),

    -- Grupo 3: Circuitos Digitais (criador 1) - 3 membros
    (3, 1, '2026-10-14T20:00:00'), (3, 3, '2026-10-15T10:30:00'), (3, 2, '2026-10-16T14:15:00'),

    -- Grupo 4: Revisao de Direito Penal (criador 17) - 2 membros
    (4, 17, '2026-10-15T17:45:00'), (4, 16, '2026-10-16T09:50:00'),

    -- Grupo 5: Anatomia Humana (criador 20) - 7 membros
    (5, 20, '2026-10-16T21:00:00'), (5, 21, '2026-10-17T10:20:00'), (5, 22, '2026-10-17T18:35:00'),
    (5, 23, '2026-10-18T09:10:00'), (5, 11, '2026-10-19T20:45:00'), (5, 12, '2026-10-20T15:30:00'),
    (5, 14, '2026-10-21T11:00:00'),

    -- Grupo 6: Estruturas de Dados em Python (criador 7) - 6 membros
    (6, 7, '2026-10-18T19:30:00'), (6, 6, '2026-10-19T08:50:00'), (6, 8, '2026-10-19T21:15:00'),
    (6, 10, '2026-10-20T17:00:00'), (6, 9, '2026-10-22T10:30:00'), (6, 2, '2026-10-23T19:20:00'),

    -- Grupo 7: Neuropsicologia (criador 11) - 3 membros
    (7, 11, '2026-10-19T16:00:00'), (7, 12, '2026-10-20T10:00:00'), (7, 14, '2026-10-21T18:30:00'),

    -- Grupo 8: Redes de Computadores (criador 4) - 3 membros
    (8, 4, '2026-10-21T20:15:00'), (8, 1, '2026-10-22T12:00:00'), (8, 3, '2026-10-22T19:40:00'),

    -- Grupo 9: Direito Constitucional (criador 16) - 2 membros
    (9, 16, '2026-10-22T18:00:00'), (9, 17, '2026-10-23T09:15:00'),

    -- Grupo 10: Fisiologia e Bioquimica (criador 21) - 4 membros
    (10, 21, '2026-10-23T19:45:00'), (10, 20, '2026-10-24T10:30:00'), (10, 22, '2026-10-24T16:20:00'),
    (10, 23, '2026-10-25T09:00:00'),

    -- Grupo 11: Front-End (criador 8) - 4 membros
    (11, 8, '2026-10-25T15:30:00'), (11, 6, '2026-10-26T10:00:00'), (11, 9, '2026-10-26T20:15:00'),
    (11, 10, '2026-10-27T14:40:00'),

    -- Grupo 12: Psicopatologia (criador 12) - 2 membros
    (12, 12, '2026-10-26T17:00:00'), (12, 11, '2026-10-27T09:30:00'),

    -- Grupo 13: Engenharia de Software e Metodologias Ageis (criador 9) - 4 membros
    (13, 9, '2026-10-28T20:00:00'), (13, 6, '2026-10-29T08:45:00'), (13, 7, '2026-10-29T19:10:00'),
    (13, 8, '2026-10-30T13:30:00'),

    -- Grupo 14: Direito do Trabalho (criador 16 apos o ajuste) - 2 membros
    (14, 16, '2026-10-29T18:30:00'), (14, 17, '2026-10-30T10:00:00'),

    -- Grupo 15: Farmacologia Clinica (criador 23) - 4 membros
    (15, 23, '2026-10-30T21:15:00'), (15, 20, '2026-10-31T10:00:00'), (15, 21, '2026-11-01T14:25:00'),
    (15, 22, '2026-11-02T09:50:00'),

    -- Grupo 16: Arquitetura de Computadores (criador 3) - 3 membros
    (16, 3, '2026-11-01T19:00:00'), (16, 1, '2026-11-02T10:15:00'), (16, 4, '2026-11-02T20:30:00'),

    -- Grupo 17: Saude Mental Coletiva (criador 14) - 3 membros
    (17, 14, '2026-11-02T16:30:00'), (17, 11, '2026-11-03T09:00:00'), (17, 12, '2026-11-03T18:20:00'),

    -- Grupo 18: Direito Civil (criador 17 apos o ajuste) - 1 membro
    (18, 17, '2026-11-04T18:45:00'),

    -- Grupo 19: Histologia e Embriologia (criador 22) - 3 membros
    (19, 22, '2026-11-05T20:30:00'), (19, 20, '2026-11-06T10:10:00'), (19, 21, '2026-11-06T19:00:00'),

    -- Grupo 20: Python para Engenharia (criador 10) - 3 membros
    (20, 10, '2026-11-07T17:15:00'), (20, 6, '2026-11-08T09:30:00'), (20, 7, '2026-11-08T20:45:00');

SELECT * FROM participante_grupo 
ORDER BY id_grupo, data_entrada;
GO

-- 5) MATERIAL (24 linhas) | tipo aceito: 'PDF', 'Slide', 'Vídeo', 'Link', 'Resumo'
-- Cada material pertence a uma disciplina do curso do usuario que compartilhou
--   Curso 1 -> disciplinas 1-5 | Curso 2 -> 6-10 | Curso 5 -> 11-15
--   Curso 9 -> 16-20 | Curso 12 -> 21-25
INSERT INTO material (titulo, descricao, tipo, url, id_usuario, id_disciplina, data_compartilhamento)
VALUES
    ('Lista resolvida de Circuitos Digitais', 'Exercícios resolvidos de mapas de Karnaugh e circuitos combinacionais.', 'PDF', 'https://uniconnect.edu.br/materiais/circuitos-digitais-lista.pdf', 1, 3, '2026-10-19T20:00:00'),
    ('Resumo de SQL Server - DDL e DML', 'Resumo com comandos CREATE, INSERT, UPDATE e DELETE com exemplos.', 'Resumo', 'https://uniconnect.edu.br/materiais/resumo-sql-server.pdf', 2, 1, '2026-10-27T18:30:00'),
    ('Slides de Arquitetura - Pipeline', 'Apresentação sobre estágios do pipeline e tratamento de hazards.', 'Slide', 'https://uniconnect.edu.br/materiais/arquitetura-pipeline.pptx', 3, 2, '2026-10-23T09:00:00'),
    ('Simulador de redes online', 'Link para simulador gratuito de topologias de redes.', 'Link', 'https://uniconnect.edu.br/materiais/simulador-redes', 4, 4, '2026-10-29T14:10:00'),
    ('Videoaula de funções de transferência', 'Explicação em vídeo sobre polos, zeros e estabilidade.', 'Vídeo', 'https://uniconnect.edu.br/materiais/funcao-transferencia-video', 5, 5, '2026-11-03T21:00:00'),
    ('Estruturas de dados - Listas Encadeadas', 'Resumo em PDF sobre listas encadeadas com exemplos em Python.', 'PDF', 'https://uniconnect.edu.br/materiais/listas-encadeadas.pdf', 6, 8, '2026-10-15T16:30:00'),
    ('Resumo de Normalização', 'Primeira, segunda e terceira forma normal com exemplos.', 'Resumo', 'https://uniconnect.edu.br/materiais/resumo-normalizacao.pdf', 7, 7, '2026-10-19T21:30:00'),
    ('Guia de CSS Flexbox e Grid', 'Link com guia visual de Flexbox e Grid.', 'Link', 'https://uniconnect.edu.br/materiais/guia-flexbox-grid', 8, 6, '2026-10-25T11:20:00'),
    ('Slides de UML', 'Diagramas de classes, casos de uso e sequência.', 'Slide', 'https://uniconnect.edu.br/materiais/uml-slides.pptx', 9, 9, '2026-10-31T10:00:00'),
    ('Videoaula de módulos em Python', 'Vídeo sobre organização de projetos Python em módulos e pacotes.', 'Vídeo', 'https://uniconnect.edu.br/materiais/python-modulos-video', 10, 10, '2026-11-04T19:45:00'),
    ('Resumo de lobos cerebrais e funções', 'Resumo sobre funções dos lobos frontal, parietal, temporal e occipital.', 'Resumo', 'https://uniconnect.edu.br/materiais/lobos-cerebrais.pdf', 11, 12, '2026-10-25T12:00:00'),
    ('Casos clínicos de Psicopatologia I', 'Casos fictícios para treino de raciocínio diagnóstico.', 'PDF', 'https://uniconnect.edu.br/materiais/casos-psicopatologia.pdf', 12, 13, '2026-10-30T15:30:00'),
    ('Textos de Durkheim comentados', 'Link com textos comentados para Sociologia e Antropologia.', 'Link', 'https://uniconnect.edu.br/materiais/durkheim-comentado', 13, 11, '2026-11-02T08:50:00'),
    ('Roteiro de entrevista clínica', 'Modelo de roteiro com etapas da entrevista clínica inicial.', 'PDF', 'https://uniconnect.edu.br/materiais/roteiro-entrevista-clinica.pdf', 14, 15, '2026-11-05T17:10:00'),
    ('Resumo de Princípios Constitucionais', 'Resumo dos principais princípios da Constituição Federal.', 'Resumo', 'https://uniconnect.edu.br/materiais/principios-constitucionais.pdf', 16, 16, '2026-10-24T20:30:00'),
    ('Esquema de Excludentes de Ilicitude', 'Mapa resumido com as excludentes de ilicitude do Código Penal.', 'PDF', 'https://uniconnect.edu.br/materiais/excludentes-ilicitude.pdf', 17, 18, '2026-10-19T16:30:00'),
    ('Slides de Prescrição e Decadência', 'Comparativo entre prescrição e decadência com prazos.', 'Slide', 'https://uniconnect.edu.br/materiais/prescricao-decadencia.pptx', 18, 17, '2026-10-30T13:20:00'),
    ('Súmulas do TST comentadas', 'Link com súmulas do TST sobre jornada e horas extras.', 'Link', 'https://uniconnect.edu.br/materiais/sumulas-tst', 19, 19, '2026-11-06T09:00:00'),
    ('Slides de Anatomia - Membro Superior', 'Apresentação com ossos, músculos e articulações do membro superior.', 'Slide', 'https://uniconnect.edu.br/materiais/anatomia-membro-superior.pptx', 20, 21, '2026-10-17T20:00:00'),
    ('Videoaula do Ciclo de Krebs', 'Explicação em vídeo sobre etapas e regulação do ciclo de Krebs.', 'Vídeo', 'https://uniconnect.edu.br/materiais/ciclo-krebs-video', 21, 22, '2026-10-21T19:30:00'),
    ('Atlas de Histologia', 'Atlas em PDF com imagens de lâminas de tecidos.', 'PDF', 'https://uniconnect.edu.br/materiais/atlas-histologia.pdf', 22, 24, '2026-10-24T16:00:00'),
    ('Resumo de Farmacocinética', 'Resumo sobre absorção, distribuição, metabolismo e excreção.', 'Resumo', 'https://uniconnect.edu.br/materiais/farmacocinetica.pdf', 23, 25, '2026-11-02T10:30:00'),
    ('Slides de Banco de Dados - Joins', 'Apresentação sobre INNER, LEFT, RIGHT e FULL JOIN com exemplos.', 'Slide', 'https://uniconnect.edu.br/materiais/joins-slides.pptx', 2, 1, '2026-11-08T14:00:00'),
    ('Resumo de Complexidade de Algoritmos', 'Resumo sobre notação Big O e exemplos de busca e ordenação.', 'Resumo', 'https://uniconnect.edu.br/materiais/complexidade-algoritmos.pdf', 6, 8, '2026-11-10T11:15:00');

SELECT * FROM material 
ORDER BY id_material;
GO

