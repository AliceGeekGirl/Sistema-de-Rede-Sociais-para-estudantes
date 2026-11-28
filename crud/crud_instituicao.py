"""
=============================================================================
CRUD de Instituições - UniConnect

Interface gráfica para cadastrar, editar, excluir e listar instituições
(tabela instituicao).

Como executar:
	python crud_instituicao.py

Organização do código:
	1. Dados: classe que guarda e altera as instituições.
	   Nesta etapa (issue 19) os dados ficam em memória, só para testar a
	   tela. Na próxima etapa (issue 20) essa classe será trocada por uma
	   que chama as procedures do SQL Server.
	2. Tela: classe que monta a janela (formulário, botões e listagem) e
	   chama a classe de dados quando o usuário clica nos botões.
=============================================================================
"""

import tkinter as tk
from tkinter import ttk, messagebox


# Valores aceitos pelo banco (CHECK da coluna tipo e siglas dos estados)
TIPOS = ["Pública", "Privada"]
ESTADOS = [
	"AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA",
	"PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",
]


# =============================================================================
# 1. DADOS (temporário, em memória)
# =============================================================================
class DadosMemoria:
	"""Guarda as instituições em uma lista, só para testar a interface."""

	def __init__(self):
		# A lista começa vazia. Os dados reais vêm do banco na etapa da issue 20.
		self.instituicoes = []
		self.proximo_id = 1

	def listar(self, filtro=""):
		# Devolve as instituições cujo nome ou sigla contém o texto do filtro
		filtro = filtro.lower()
		return [i for i in self.instituicoes
		        if filtro in i["nome"].lower() or filtro in i["sigla"].lower()]

	def inserir(self, nome, sigla, tipo, cidade, estado):
		# Mesma regra da restrição UNIQUE do banco: não pode repetir o nome
		if any(i["nome"].lower() == nome.lower() for i in self.instituicoes):
			raise ValueError("Já existe uma instituição com esse nome.")
		self.instituicoes.append({"id": self.proximo_id, "nome": nome, "sigla": sigla,
		                          "tipo": tipo, "cidade": cidade, "estado": estado})
		self.proximo_id += 1

	def atualizar(self, id_instituicao, nome, sigla, tipo, cidade, estado):
		if any(i["nome"].lower() == nome.lower() and i["id"] != id_instituicao for i in self.instituicoes):
			raise ValueError("Já existe outra instituição com esse nome.")
		for i in self.instituicoes:
			if i["id"] == id_instituicao:
				i.update(nome=nome, sigla=sigla, tipo=tipo, cidade=cidade, estado=estado)
				return
		raise ValueError("Instituição não encontrada.")

	def excluir(self, id_instituicao):
		self.instituicoes = [i for i in self.instituicoes if i["id"] != id_instituicao]


# =============================================================================
# 2. TELA
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
	TelaInstituicao(janela, DadosMemoria())
	janela.mainloop()
