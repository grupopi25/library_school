import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:library_school/admin/cadastrar_livros.dart';
import 'package:library_school/api/models/livro_model.dart';
import 'package:library_school/api/repositores/livro_repository.dart';

class LivrosAdmin extends StatefulWidget {
  const LivrosAdmin({super.key});

  @override
  State<LivrosAdmin> createState() => _LivrosAdminState();
}

class _LivrosAdminState extends State<LivrosAdmin> {
  final TextEditingController buscaController = TextEditingController();
  
  int currentPage = 1;
  int totalPages = 1;
  final repo = LivroRepository();
  List<LivroModel> livros = [];
  int page = 1;
  bool loading = false;
  Timer? timer;
  late IO.Socket socket;








  

  @override
  void initState() {
    super.initState();

    carregarLivros();
    // esculta o banco quando tiver alguma auteracao
    socket = IO.io(
      "http://localhost:8081",
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();

    socket.on("livroAtualizado", (_) {
      setState(() {
        livros.clear();
        page = 1;
      });

      carregarLivros();
    });
  }

  @override
  void dispose() {
    socket.dispose();
    timer?.cancel();
    super.dispose();
  }

bool pesquisando = false;
void aplicarFiltros() async {
  final busca = buscaController.text;

  // se tiver qualquer filtro ativo → modo pesquisa
  if (busca.isNotEmpty ||
      categoriaSelecionada != null ||
      disponibilidadeSelecionada != null) {
    
    pesquisando = true;

    final resultado = await repo.findFiltrar(
  buscaController.text,
  categoriaSelecionada,
  disponibilidadeSelecionada,
);
setState(() {
  livros = resultado;
});

    // FILTRO LOCAL (categoria + status)
   final filtrado = resultado.where((livro) {
  final categoriaSelecionadaNormalizada = categoriaSelecionada?.trim().toLowerCase();
  final matchCategoria = categoriaSelecionadaNormalizada == null ||
      categoriaSelecionadaNormalizada == 'todas as categorias' ||
      livro.categoria.toLowerCase() == categoriaSelecionadaNormalizada;

  final disponibilidadeNormalizada = disponibilidadeSelecionada?.trim().toLowerCase();
  final matchStatus = disponibilidadeNormalizada == null ||
      disponibilidadeNormalizada == 'disponibilidade' ||
      (disponibilidadeNormalizada == 'disponivel' && livro.status) ||
      (disponibilidadeNormalizada == 'emprestado' && !livro.status);

  return matchCategoria && matchStatus;
}).toList();

    setState(() {
      livros = filtrado;
    });

  } else {
    // sem filtro → volta paginação normal
    pesquisando = false;
    currentPage = 1;
    carregarLivros();
  }
}

  void mudarPagina(int novaPagina) {
    if (novaPagina < 1 || novaPagina > totalPages) return;

    setState(() {
      currentPage = novaPagina;
    });

    carregarLivros();
  }

  void carregarLivros() async {
    if (loading) return;

    setState(() => loading = true);

    final response = await repo.findAll(currentPage);

    setState(() {
      livros = response.livros; // substitui lista (não acumula)
      totalPages = response.totalPages;
      loading = false;
    });
  }

  final List<String> categorias = [
    'Todas as Categorias',
    'Romance',
    'Tecnologia',
    'História',
  ];
  final List<String> disponivel = [
    'Disponibilidade',
    'Disponivel',
    'Emprestado',
  ];
  String? disponibilidadeSelecionada;
  String? categoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "CATÁLOGO DIGITAL",
                    style: TextStyle(
                      color: Color(0xff2563EB),
                      fontSize: 10.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Livros",
                    style: TextStyle(
                      color: Color(0xff191C1E),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Botão Cadastro
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastrarLivros()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff004AC6), Color(0xff2563EB)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Adicionar Livros",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Campo de busca
        Row(
  children: [
    // 🔎 BUSCA
    Expanded(
      child: TextFormField(
        controller: buscaController,
        onChanged: (_) => aplicarFiltros(),
        decoration: InputDecoration(
          hintText: 'Título, autor ou ISBN...',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          prefixIcon: const Icon(Icons.search),
          // BOTÃO LIMPAR
          suffixIcon: buscaController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    buscaController.clear();
                    aplicarFiltros();
                    setState(() {});
                  },
                )
              : null,
        ),
      ),
    ),

    const SizedBox(width: 10),

   

    // DIVISOR
    Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: const Color.fromARGB(75, 158, 158, 158),
    ),

    // 📂 CATEGORIA
    Flexible(
  child: DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      isExpanded: true, // permite que ocupe todo o espaço disponível
      focusColor: Colors.transparent,
      value: categoriaSelecionada,
      hint: const Text('Todas Categorias'),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      items: categorias.map((categoria) {
        return DropdownMenuItem<String>(
          value: categoria,
          child: Text(
            categoria,
            overflow: TextOverflow.ellipsis, // evita overflow de texto longo
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          categoriaSelecionada = value;
        });
        aplicarFiltros();
      },
    ),
  ),
),

    // DIVISOR
    Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: const Color.fromARGB(75, 158, 158, 158),
    ),

    // 📊 DISPONIBILIDADE
    DropdownButton<String>(
      focusColor: Colors.transparent,
      value: disponibilidadeSelecionada,
      hint: const Text('Disponibilidade'),
      underline: const SizedBox(),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      items: disponivel.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          disponibilidadeSelecionada = value;
        });
        aplicarFiltros();
      },
    ),

    const SizedBox(width: 10),

    // 🧹 LIMPAR FILTROS
    IconButton(
      tooltip: "Limpar filtros",
      icon: const Icon(Icons.refresh, color: Colors.grey),
      onPressed: () {
        setState(() {
          buscaController.clear();
          categoriaSelecionada = null;
          disponibilidadeSelecionada = null;
        });
        aplicarFiltros();
      },
    ),

    const SizedBox(width: 10),

    // 📤 EXPORTAR
    Expanded(
      child: InkWell(
        onTap: () {
          // futura implementação exportar
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffE7E8EA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_download_outlined,
                  color: Color(0xff191C1E),
                ),
                SizedBox(width: 8),
                Text(
                  'Exportar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff191C1E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
),







          
          // TABELA DE LIVROS
          SizedBox(height: 20),
          

      Expanded(
  child: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ListView.builder(
      itemCount: livros.length + 1, // +1 para header
      itemBuilder: (context, index) {
        // HEADER FIXO
        if (index == 0) {
          return Container(
            color: const Color(0xff374151),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  SizedBox(
                    width: 80,
                    child: Text(
                      "Capa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "Título & Autor",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      "Categoria",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      "Tombo",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      "ISBN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      "Status",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      "Ações",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final livro = livros[index - 1];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: index % 2 == 0 ? const Color(0xffF9FAFB) : Colors.white,
            border: const Border(
              bottom: BorderSide(color: Color(0xffE5E7EB)),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // CAPA
                SizedBox(
                  width: 80,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xffE5E7EB),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: (livro.capa?.isNotEmpty ?? false)
                        ? Image.network(
                            "http://localhost:8081/uploads/${livro.capa}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.book,
                                  color: Color(0xff9CA3AF),
                                  size: 28,
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Icon(
                              Icons.book,
                              color: Color(0xff9CA3AF),
                              size: 28,
                            ),
                          ),
                  ),
                ),

                // TITULO + AUTOR
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        livro.titulo,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        livro.autor,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff6B7280),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 120, child: Text(livro.categoria)),
                SizedBox(width: 80, child: Text(livro.tombo.toString())),
                SizedBox(width: 120, child: Text(livro.isbn)),

                // STATUS
                SizedBox(
                  width: 120,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: livro.status
                          ? const Color(0xffDCFCE7)
                          : const Color(0xffFEE2E2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      livro.status ? "Disponível" : "Emprestado",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: livro.status
                            ? const Color(0xff16A34A)
                            : const Color(0xffDC2626),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // AÇÕES
                SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.visibility,
                          color: Color(0xff2563EB),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color(0xff6B7280),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  ),
),




          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: currentPage > 1
                      ? () => mudarPagina(currentPage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),

                Text(
                  "Página $currentPage de $totalPages",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),

                IconButton(
                  onPressed: currentPage < totalPages
                      ? () => mudarPagina(currentPage + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
