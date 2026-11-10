UniConnect — Escopo e Regras de Negócio

1. Apresentação da Plataforma

O UniConnect é uma plataforma digital voltada à comunidade universitária, desenvolvida com o objetivo de conectar estudantes e incentivar a colaboração acadêmica. A proposta combina funcionalidades de redes sociais, como compartilhamento de publicações, curtidas, comentários e mensagens privadas, com recursos educacionais, como perguntas e respostas, compartilhamento de materiais e formação de grupos de estudo.

O objetivo central da plataforma busca proporcionar um ambiente no qual estudantes de diferentes instituições, cursos e fases possam compartilhar conhecimentos, trocar experiências e estabelecer conexões acadêmicas.

2. Objetivo Geral

Desenvolver uma rede social acadêmica que facilite a comunicação entre estudantes e estimule o aprendizado colaborativo, permitindo o compartilhamento de conteúdos, dúvidas, materiais e experiências universitárias.

3. Público-alvo

Estudantes universitários de instituições públicas e privadas.

Alunos de diferentes cursos e fases.

Estudantes interessados em compartilhar conhecimentos e materiais.


4. Escopo do sistema

4.1 Funcionalidades disponíveis

- Cadastro e perfil de usuário;

- Cadastro de usuários com nome, e-mail, senha e informações acadêmicas;

- Identificação da instituição, curso e fase do estudante;

- Edição das informações do perfil;

- Publicações e interação social;

- Criação de publicações com textos e conteúdos;

- Visualização de publicações em um feed;

- Curtidas e comentários;

- Possibilidade de seguir outros usuários;

- Perguntas e respostas;

- Publicação de dúvidas acadêmicas;

- Associação de perguntas a disciplinas;

- Respostas às dúvidas publicadas por outros estudantes;

- Grupos de estudo;

- Criação de grupos de estudo;

- Entrada e participação de usuários nos grupos;

- Organização de estudantes por interesses acadêmicos;

- Mensagens privadas;

- Envio e recebimento de mensagens entre usuários;

- Compartilhamento de materiais;

- Cadastro e compartilhamento de materiais de estudo;

- Associação dos materiais às respectivas disciplinas.


5. Regras de negócio

As regras de negócio determinam como as funcionalidades da plataforma devem funcionar e quais condições precisam ser respeitadas pelo sistema.

RN01

Cada usuário deve possuir um identificador único.

RN02

O e-mail e o nome de usuário devem ser únicos na plataforma.

RN03

Cada usuário deve estar associado a um curso.

RN04

Cada curso deve pertencer a uma instituição.

RN05

Cada disciplina deve estar vinculada a um curso.

RN06

Um usuário pode realizar diversas publicações.

RN07

Cada publicação deve possuir apenas um autor.

RN08

Um usuário pode curtir uma publicação apenas uma vez.

RN09

Um usuário pode comentar diversas publicações.

RN10

Um usuário não pode seguir a si mesmo.

RN11

Um usuário pode seguir diversos outros usuários.

RN12

Toda pergunta deve possuir um autor responsável.

RN13

Uma pergunta pode receber diversas respostas.

RN14

Cada resposta deve estar vinculada a uma pergunta e ao usuário que a publicou.

RN15

Todo grupo de estudo deve possuir um usuário responsável pela criação.

RN16

Um grupo de estudo pode possuir diversos participantes.

RN17

Um usuário pode participar de diversos grupos, mas não pode participar duas vezes do mesmo grupo.

RN18

Toda mensagem deve possuir um remetente e um destinatário.

RN19

Todo material de estudo deve possuir um usuário responsável pelo compartilhamento.

RN20

Todo material de estudo deve estar associado a uma disciplina.


6. Considerações finais

O UniConnect tem como finalidade unir interação social e colaboração acadêmica em uma única plataforma.

O escopo e as regras definidos neste documento servirão como base para a modelagem do banco de dados, a construção do diagrama físico, a aplicação das formas normais e o desenvolvimento das consultas SQL.

As funcionalidades poderão ser ampliadas futuramente, conforme as necessidades do projeto e a evolução do sistema.
