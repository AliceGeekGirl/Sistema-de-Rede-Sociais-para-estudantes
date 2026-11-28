# UniConnect — Rede Social Acadêmica

## Equipe

- Alice da Cruz Justi
- Beatriz Sartor Perego
- Rafael Cechinel Pacheco
- Wesllen Comel Vargas
- Vinicius Ronchi

## Sobre o projeto

O **UniConnect** é uma plataforma digital voltada à comunidade universitária, desenvolvida com o objetivo de conectar estudantes e incentivar a colaboração acadêmica.

A proposta combina funcionalidades de redes sociais, como publicações, curtidas, comentários e mensagens privadas, com recursos educacionais, como perguntas e respostas, compartilhamento de materiais e formação de grupos de estudo.

O projeto está sendo desenvolvido como atividade acadêmica do curso de Engenharia de Software.

## Objetivo

Desenvolver uma rede social acadêmica que facilite a comunicação entre estudantes e estimule o aprendizado colaborativo, permitindo o compartilhamento de conhecimentos, dúvidas, materiais e experiências universitárias.

## Público-alvo

- Estudantes universitários de instituições públicas e privadas.
- Alunos de diferentes cursos e fases.
- Estudantes interessados em compartilhar conhecimentos e materiais acadêmicos.

## Funcionalidades previstas

- **Cadastro e perfil:** criação e edição de perfis com informações pessoais e acadêmicas.
- **Publicações:** compartilhamento de conteúdos em um feed.
- **Interação social:** curtidas, comentários e possibilidade de seguir outros usuários.
- **Perguntas e respostas:** publicação de dúvidas acadêmicas e respostas associadas a disciplinas.
- **Grupos de estudo:** criação de grupos e participação de estudantes.
- **Mensagens privadas:** comunicação direta entre usuários.
- **Materiais de estudo:** compartilhamento de materiais relacionados às disciplinas.

## Tecnologias utilizadas

- **Microsoft SQL Server:** sistema gerenciador de banco de dados.
- **SQL:** linguagem utilizada para definição, manipulação e consulta dos dados.
- **SQL Server Management Studio (SSMS):** ferramenta de gerenciamento e execução dos scripts SQL.
- **Git e GitHub:** controle de versão, organização e colaboração no desenvolvimento do projeto.

## Banco de dados

O banco de dados do UniConnect será desenvolvido utilizando o Microsoft SQL Server.

A modelagem deverá contemplar as entidades necessárias ao funcionamento da plataforma, seus atributos, chaves primárias, chaves estrangeiras, restrições de integridade e relacionamentos.

O projeto também contempla a aplicação das três primeiras formas normais (1FN, 2FN e 3FN), visando reduzir redundâncias e garantir a organização e consistência dos dados.

## Organização do repositório

A estrutura planejada para organizar os arquivos do projeto é:

```text
uniconnect/
├── docs/                           # Escopo e regras do projeto
├── modelo_fisico/                  # Diagrama Entidade-Relacionamento (DER) 
├── scripts/
│   ├── ddl.sql/                    
|       └── funcao/                 # Função (function) de engajamento
|       └── procedure/              # Procedimentos (stored procedure) dos grupos de estudos
|       └── tabelas/                # Criação das 14 tabelas, chaves e restrições
|       └── visualizacoes/          # Visões (views) e consultas de demonstração     
│   ├── dml.sql/                    # Inserção dos registros iniciais para testes
│   ├── perguntas_negocio/          # 6 Perguntas de Negócio     
└── README.md                       # Apresentação e documentação geral do repositório
```

*Observação: a estrutura será preenchida gradualmente conforme o desenvolvimento das etapas do projeto.*


## Como executar o CRUD de instituições

O CRUD permite listar, cadastrar, editar e excluir registros da tabela `instituicao` por meio de uma interface gráfica feita em Python. Todas as operações no banco são feitas pelas stored procedures do arquivo `scripts/ddl/procedure/sp_instituicao.sql`.

### Passo 1 – Preparar o computador
- Ter o **SQL Server** e o **SQL Server Management Studio (SSMS)** instalados.
- Ter o **Python 3** instalado (pela Microsoft Store ou pelo site [python.org](https://www.python.org/downloads/)).
- Baixar este repositório: botão **Code → Download ZIP** e extrair a pasta.

### Passo 2 – Criar o banco de dados
No SSMS, conectar no servidor e executar:
```sql
CREATE DATABASE BD2Trabalho;
```
Depois, selecionar o banco **BD2Trabalho** na caixa de seleção da barra de ferramentas.

### Passo 3 – Criar as tabelas
Abrir e executar (F5) o arquivo `scripts/ddl/tabelas/tabelas.sql`.

### Passo 4 – Popular as tabelas
Abrir e executar (F5) o arquivo `scripts/dml/popula_tabelas.sql`.

### Passo 5 – Criar as procedures do CRUD
Abrir e executar (F5) o arquivo `scripts/ddl/procedure/sp_instituicao.sql`.

### Passo 6 – Instalar a biblioteca de conexão (somente na primeira vez)
No Prompt de Comando:
```
python -m pip install pyodbc
```

### Passo 7 – Abrir o CRUD
No Prompt de Comando, entrar na pasta `crud` do projeto e executar:
```
python crud_instituicao.py
```

### Passo 8 – Conectar ao banco
Na tela de conexão, conferir o **Servidor** e o **Banco** (os mesmos usados no SSMS, por exemplo `localhost\SQLEXPRESS` e `BD2Trabalho`) e clicar em **Conectar**. Deixando usuário e senha em branco, a conexão usa o login do Windows.

### Problemas comuns

| Problema | Solução |
|---|---|
| `Python was not found` | Usar `py` ou `python3.12` no lugar de `python`, ou ativar o Python em *Configurações → Aplicativos → Configurações avançadas de aplicativos → Aliases de execução de aplicativo*. |
| Mensagem "Biblioteca não instalada" | Executar o passo 6. |
| "Erro de conexão" | Conferir se o SQL Server está ligado e se o servidor e o banco estão iguais aos do SSMS. |
| Erro ao carregar a lista de instituições | Executar o passo 5 (as procedures não foram criadas no banco). |
| "Nome de objeto inválido" no SSMS | Conferir se o banco selecionado é o **BD2Trabalho**, e não o `master`. |


## Referências

* MICROSOFT. *Documentação do SQL Server e Transact-SQL (T-SQL)*. Disponível em: [https://learn.microsoft.com/pt-br/sql/](https://learn.microsoft.com/pt-br/sql/)
* MICROSOFT. *SQL Server Management Studio (SSMS)*. Disponível em: [https://learn.microsoft.com/pt-br/sql/ssms/](https://learn.microsoft.com/pt-br/sql/ssms/)
