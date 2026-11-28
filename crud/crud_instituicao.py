"""
=============================================================================
CRUD de Instituições - UniConnect

Interface gráfica para cadastrar, editar, excluir e listar instituições
(tabela instituicao), ligada ao banco SQL Server do projeto.

Antes de executar:
	1. Rodar no SSMS o script scripts/ddl/procedure/sp_instituicao.sql
	   (cria as procedures usadas por este programa).
	2. Instalar a biblioteca de conexão com o SQL Server:
	   python -m pip install pyodbc

Como executar:
	python crud_instituicao.py

	Ao abrir, aparece a tela de conexão com o servidor e o banco já
	preenchidos. Se no computador o nome for diferente, é só trocar ali.

Organização do código:
	1. Configuração: valores que já vêm preenchidos na tela de conexão.
	2. Dados: classe que chama as procedures do banco (listar, inserir,
	   atualizar e excluir). O programa não escreve INSERT, UPDATE ou DELETE,
	   ele só chama as procedures.
	3. Tela de conexão: janela que aparece ao abrir o programa, para
	   informar o servidor e o banco.
	4. Tela do CRUD: classe que monta a janela (formulário, botões e
	   listagem) e chama a classe de dados quando o usuário clica nos botões.
=============================================================================
"""

import os
import re
import tkinter as tk
from tkinter import ttk, messagebox


# Valores aceitos pelo banco (CHECK da coluna tipo e siglas dos estados)
TIPOS = ["Pública", "Privada"]
ESTADOS = [
	"AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA",
	"PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",
]


# =============================================================================
# 1. CONFIGURAÇÃO DA CONEXÃO
# =============================================================================
# Valores que já vêm preenchidos na tela de conexão. Podem ser trocados na
# própria tela, sem mexer no código.
SERVIDOR = os.environ.get("CRUD_SERVIDOR", r"localhost\SQLEXPRESS")
BANCO = os.environ.get("CRUD_BANCO", "BD2Trabalho")

# Sem usuário e senha, a conexão usa o login do Windows (Autenticação do Windows),
# o mesmo usado no SSMS.
USUARIO = os.environ.get("CRUD_USUARIO", "")
SENHA = os.environ.get("CRUD_SENHA", "")


# =============================================================================
# 2. DADOS (procedures do SQL Server)
# =============================================================================
class DadosSQLServer:
	"""Faz as operações do CRUD chamando as procedures do banco."""

	def __init__(self, servidor, banco, usuario="", senha=""):
		import pyodbc
		self.pyodbc = pyodbc
		self.servidor = servidor
		self.banco = banco
		self.usuario = usuario
		self.senha = senha
		self.conexao = pyodbc.connect(self.montar_string_conexao(), autocommit=True, timeout=5)

	def montar_string_conexao(self):
		# Escolhe o driver ODBC mais novo que estiver instalado no computador
		drivers = self.pyodbc.drivers()
		preferidos = ["ODBC Driver 18 for SQL Server", "ODBC Driver 17 for SQL Server", "SQL Server"]
		driver = next((d for d in preferidos if d in drivers), None)
		if driver is None:
			raise RuntimeError("Nenhum driver ODBC do SQL Server foi encontrado neste computador.")

		partes = [f"DRIVER={{{driver}}}", f"SERVER={self.servidor}", f"DATABASE={self.banco}"]
		if self.usuario:
			partes += [f"UID={self.usuario}", f"PWD={self.senha}"]
		else:
			partes.append("Trusted_Connection=yes")
		if driver != "SQL Server":
			partes.append("TrustServerCertificate=yes")  # mesmo que marcar "Confiar no certificado" no SSMS
		return ";".join(partes)

	def executar(self, sql, parametros=()):
		# Executa a procedure e transforma o erro do banco em uma mensagem simples
		try:
			cursor = self.conexao.cursor()
			cursor.execute(sql, parametros)
			return cursor
		except self.pyodbc.Error as erro:
			raise ValueError(self.mensagem_do_banco(erro)) from None

	@staticmethod
	def mensagem_do_banco(erro):
		# O erro vem assim: [Microsoft][ODBC Driver 18 ...][SQL Server]Mensagem (50104) (SQLExecDirectW)
		# Aqui fica só a parte "Mensagem"
		texto = str(erro.args[-1]) if erro.args else str(erro)
		texto = texto.split("]")[-1]
		texto = re.sub(r"\s*\(\d+\)\s*\(SQL\w+\)\s*$", "", texto)
		return texto.strip()

	def listar(self, filtro=""):
		cursor = self.executar("EXEC dbo.sp_instituicao_listar @filtro = ?", (filtro,))
		return [{"id": r.id_instituicao, "nome": r.nome, "sigla": r.sigla,
		         "tipo": r.tipo, "cidade": r.cidade, "estado": r.estado}
		        for r in cursor.fetchall()]

	def inserir(self, nome, sigla, tipo, cidade, estado):
		self.executar("EXEC dbo.sp_instituicao_inserir ?, ?, ?, ?, ?",
		              (nome, sigla, tipo, cidade, estado))

	def atualizar(self, id_instituicao, nome, sigla, tipo, cidade, estado):
		self.executar("EXEC dbo.sp_instituicao_atualizar ?, ?, ?, ?, ?, ?",
		              (id_instituicao, nome, sigla, tipo, cidade, estado))

	def excluir(self, id_instituicao):
		self.executar("EXEC dbo.sp_instituicao_excluir ?", (id_instituicao,))


# =============================================================================
# 3. TELA DE CONEXÃO
# =============================================================================
class TelaConexao:
	"""Janela que aparece ao abrir o programa, para escolher servidor e banco."""

	def __init__(self, janela, ao_conectar):
		self.ao_conectar = ao_conectar  # função chamada quando a conexão der certo
		self.janela = tk.Toplevel(janela)
		self.janela.title("UniConnect - Conectar ao banco")
		self.janela.resizable(False, False)
		self.janela.protocol("WM_DELETE_WINDOW", janela.destroy)  # fechar aqui fecha o programa

		quadro = ttk.Frame(self.janela, padding=15)
		quadro.pack(fill="both", expand=True)

		self.var_servidor = tk.StringVar(value=SERVIDOR)
		self.var_banco = tk.StringVar(value=BANCO)
		self.var_usuario = tk.StringVar(value=USUARIO)
		self.var_senha = tk.StringVar(value=SENHA)

		ttk.Label(quadro, text="Servidor").grid(row=0, column=0, sticky="w")
		campo_servidor = ttk.Entry(quadro, textvariable=self.var_servidor, width=35)
		campo_servidor.grid(row=0, column=1, pady=3)

		ttk.Label(quadro, text="Banco").grid(row=1, column=0, sticky="w")
		ttk.Entry(quadro, textvariable=self.var_banco, width=35).grid(row=1, column=1, pady=3)

		ttk.Label(quadro, text="Usuário").grid(row=2, column=0, sticky="w")
		ttk.Entry(quadro, textvariable=self.var_usuario, width=35).grid(row=2, column=1, pady=3)

		ttk.Label(quadro, text="Senha").grid(row=3, column=0, sticky="w")
		ttk.Entry(quadro, textvariable=self.var_senha, width=35, show="*").grid(row=3, column=1, pady=3)

		ttk.Label(quadro, text="Deixe usuário e senha em branco para usar o login do Windows.",
		          foreground="#555555").grid(row=4, column=0, columnspan=2, sticky="w", pady=(4, 8))

		self.btn_conectar = ttk.Button(quadro, text="Conectar", command=self.conectar)
		self.btn_conectar.grid(row=5, column=0, columnspan=2)

		self.janela.bind("<Return>", lambda _e: self.conectar())  # Enter também conecta
		campo_servidor.focus()

	def conectar(self):
		servidor = self.var_servidor.get().strip()
		banco = self.var_banco.get().strip()
		if not servidor or not banco:
			messagebox.showwarning("Campos obrigatórios", "Informe o servidor e o banco.", parent=self.janela)
			return

		self.btn_conectar.state(["disabled"])
		self.janela.config(cursor="watch")
		self.janela.update()
		try:
			dados = DadosSQLServer(servidor, banco, self.var_usuario.get().strip(), self.var_senha.get())
		except Exception as erro:
			messagebox.showerror("Erro de conexão",
			                     f"Não foi possível conectar no banco {banco} do servidor {servidor}.\n\n"
			                     "Confira se o SQL Server está ligado e se o nome do servidor e do banco "
			                     "estão certos (são os mesmos usados no SSMS).\n\n"
			                     f"Detalhe: {erro}", parent=self.janela)
			return
		finally:
			self.btn_conectar.state(["!disabled"])
			self.janela.config(cursor="")

		self.janela.destroy()
		self.ao_conectar(dados)


# =============================================================================
# 4. TELA DO CRUD
# =============================================================================
class TelaInstituicao:

	def __init__(self, janela, dados):
		self.janela = janela
		self.dados = dados
		self.id_selecionado = None  # None = cadastrando uma nova instituição

		janela.title("UniConnect - Cadastro de Instituições")
		janela.geometry("900x560")
		janela.minsize(760, 480)

		self.montar_formulario()
		self.montar_botoes()
		self.montar_listagem()
		self.montar_barra_status()

		self.carregar_listagem()
		self.limpar_formulario()

	# -----------------------------------------------------------------
	# Montagem da tela
	# -----------------------------------------------------------------
	def montar_formulario(self):
		quadro = ttk.LabelFrame(self.janela, text="Dados da instituição", padding=10)
		quadro.pack(fill="x", padx=10, pady=(10, 5))

		# Variáveis ligadas aos campos do formulário
		self.var_nome = tk.StringVar()
		self.var_sigla = tk.StringVar()
		self.var_tipo = tk.StringVar()
		self.var_cidade = tk.StringVar()
		self.var_estado = tk.StringVar()

		# Linha 1: Nome
		ttk.Label(quadro, text="Nome *").grid(row=0, column=0, sticky="w")
		self.campo_nome = ttk.Entry(quadro, textvariable=self.var_nome)
		self.campo_nome.grid(row=0, column=1, columnspan=5, sticky="ew", pady=3)

		# Linha 2: Sigla e Tipo
		ttk.Label(quadro, text="Sigla *").grid(row=1, column=0, sticky="w")
		ttk.Entry(quadro, textvariable=self.var_sigla, width=20).grid(row=1, column=1, sticky="w", pady=3)

		ttk.Label(quadro, text="Tipo *").grid(row=1, column=2, sticky="e", padx=(15, 5))
		ttk.Combobox(quadro, textvariable=self.var_tipo, values=TIPOS,
		             state="readonly", width=12).grid(row=1, column=3, sticky="w")

		# Linha 3: Cidade e Estado
		ttk.Label(quadro, text="Cidade *").grid(row=2, column=0, sticky="w")
		ttk.Entry(quadro, textvariable=self.var_cidade, width=40).grid(row=2, column=1, sticky="w", pady=3)

		ttk.Label(quadro, text="Estado *").grid(row=2, column=2, sticky="e", padx=(15, 5))
		ttk.Combobox(quadro, textvariable=self.var_estado, values=ESTADOS,
		             state="readonly", width=5).grid(row=2, column=3, sticky="w")

		# Texto que mostra se está cadastrando ou editando
		self.lbl_modo = ttk.Label(quadro, foreground="#1a5fb4")
		self.lbl_modo.grid(row=3, column=0, columnspan=6, sticky="w", pady=(6, 0))

		quadro.columnconfigure(4, weight=1)  # a coluna vazia da direita estica, o resto fica junto

	def montar_botoes(self):
		quadro = ttk.Frame(self.janela, padding=(10, 0))
		quadro.pack(fill="x")

		ttk.Button(quadro, text="Novo", command=self.limpar_formulario).pack(side="left")
		ttk.Button(quadro, text="Salvar", command=self.salvar).pack(side="left", padx=5)
		self.btn_excluir = ttk.Button(quadro, text="Excluir", command=self.excluir)
		self.btn_excluir.pack(side="left")

		# Campo de pesquisa na direita
		self.var_pesquisa = tk.StringVar()
		self.var_pesquisa.trace_add("write", lambda *_: self.carregar_listagem())
		ttk.Entry(quadro, textvariable=self.var_pesquisa, width=30).pack(side="right")
		ttk.Label(quadro, text="Pesquisar (nome ou sigla):").pack(side="right", padx=5)

	def montar_listagem(self):
		quadro = ttk.Frame(self.janela, padding=10)
		quadro.pack(fill="both", expand=True)

		colunas = ("id", "nome", "sigla", "tipo", "cidade", "estado")
		self.tabela = ttk.Treeview(quadro, columns=colunas, show="headings", selectmode="browse")

		titulos = {"id": "ID", "nome": "Nome", "sigla": "Sigla", "tipo": "Tipo",
		           "cidade": "Cidade", "estado": "UF"}
		larguras = {"id": 45, "nome": 360, "sigla": 90, "tipo": 80, "cidade": 140, "estado": 45}
		for coluna in colunas:
			self.tabela.heading(coluna, text=titulos[coluna])
			self.tabela.column(coluna, width=larguras[coluna],
			                   anchor="w" if coluna in ("nome", "cidade") else "center")

		barra = ttk.Scrollbar(quadro, orient="vertical", command=self.tabela.yview)
		self.tabela.configure(yscrollcommand=barra.set)
		self.tabela.pack(side="left", fill="both", expand=True)
		barra.pack(side="right", fill="y")

		# Ao clicar em uma linha, os dados vão para o formulário para edição
		self.tabela.bind("<<TreeviewSelect>>", self.selecionar_linha)

	def montar_barra_status(self):
		self.var_status = tk.StringVar()
		ttk.Label(self.janela, textvariable=self.var_status, relief="sunken",
		          anchor="w", padding=(8, 3)).pack(fill="x", side="bottom")

	# -----------------------------------------------------------------
	# Listagem
	# -----------------------------------------------------------------
	def carregar_listagem(self):
		# Limpa a tabela e preenche de novo com os dados atuais
		self.tabela.delete(*self.tabela.get_children())
		registros = self.dados.listar(self.var_pesquisa.get().strip())
		for r in registros:
			self.tabela.insert("", "end", iid=r["id"],
			                   values=(r["id"], r["nome"], r["sigla"], r["tipo"], r["cidade"], r["estado"]))
		self.var_status.set(f"{len(registros)} instituição(ões) encontrada(s).")

	def selecionar_linha(self, _evento=None):
		selecao = self.tabela.selection()
		if not selecao:
			return
		valores = self.tabela.item(selecao[0], "values")
		self.id_selecionado = int(valores[0])
		self.var_nome.set(valores[1])
		self.var_sigla.set(valores[2])
		self.var_tipo.set(valores[3])
		self.var_cidade.set(valores[4])
		self.var_estado.set(valores[5])
		self.lbl_modo.config(text=f"Editando a instituição ID {self.id_selecionado}")
		self.btn_excluir.state(["!disabled"])

	# -----------------------------------------------------------------
	# Ações dos botões
	# -----------------------------------------------------------------
	def limpar_formulario(self):
		self.id_selecionado = None
		for var in (self.var_nome, self.var_sigla, self.var_tipo, self.var_cidade, self.var_estado):
			var.set("")
		self.tabela.selection_remove(self.tabela.selection())
		self.lbl_modo.config(text="Cadastrando uma nova instituição")
		self.btn_excluir.state(["disabled"])  # só dá para excluir com uma linha selecionada
		self.campo_nome.focus()

	def validar_campos(self):
		# Confere os campos antes de enviar, seguindo os tamanhos da tabela instituicao
		nome = self.var_nome.get().strip()
		sigla = self.var_sigla.get().strip()
		tipo = self.var_tipo.get()
		cidade = self.var_cidade.get().strip()
		estado = self.var_estado.get()

		erros = []
		if not nome:
			erros.append("Informe o nome.")
		elif len(nome) > 80:
			erros.append("O nome pode ter no máximo 80 caracteres.")
		if not sigla:
			erros.append("Informe a sigla.")
		elif len(sigla) > 20:
			erros.append("A sigla pode ter no máximo 20 caracteres.")
		if tipo not in TIPOS:
			erros.append("Selecione o tipo (Pública ou Privada).")
		if not cidade:
			erros.append("Informe a cidade.")
		elif len(cidade) > 80:
			erros.append("A cidade pode ter no máximo 80 caracteres.")
		if estado not in ESTADOS:
			erros.append("Selecione o estado.")

		if erros:
			messagebox.showwarning("Campos inválidos", "\n".join(erros))
			return None
		return nome, sigla, tipo, cidade, estado

	def salvar(self):
		campos = self.validar_campos()
		if campos is None:
			return
		try:
			if self.id_selecionado is None:
				self.dados.inserir(*campos)
				mensagem = "Instituição cadastrada com sucesso."
			else:
				self.dados.atualizar(self.id_selecionado, *campos)
				mensagem = "Instituição atualizada com sucesso."
		except Exception as erro:
			# Mostra o motivo quando alguma regra impede a operação
			messagebox.showerror("Não foi possível salvar", str(erro))
			return

		self.carregar_listagem()
		self.limpar_formulario()
		self.var_status.set(mensagem)

	def excluir(self):
		if self.id_selecionado is None:
			return
		nome = self.var_nome.get()
		if not messagebox.askyesno("Confirmar exclusão",
		                           f"Deseja excluir a instituição:\n\n{nome}?"):
			return
		try:
			self.dados.excluir(self.id_selecionado)
		except Exception as erro:
			messagebox.showerror("Não foi possível excluir", str(erro))
			return

		self.carregar_listagem()
		self.limpar_formulario()
		self.var_status.set("Instituição excluída com sucesso.")


# =============================================================================
# INÍCIO DO PROGRAMA
# =============================================================================
if __name__ == "__main__":
	janela = tk.Tk()
	janela.withdraw()  # a tela do CRUD só aparece depois de conectar

	# Confere se a biblioteca de conexão está instalada
	try:
		import pyodbc  # noqa: F401
	except ImportError:
		messagebox.showerror("Biblioteca não instalada",
		                     "A biblioteca pyodbc não está instalada.\n\n"
		                     "Abra o Prompt de Comando e rode:\npython -m pip install pyodbc")
		raise SystemExit(1)

	def abrir_crud(dados):
		janela.deiconify()
		TelaInstituicao(janela, dados)

	TelaConexao(janela, abrir_crud)
	janela.mainloop()
