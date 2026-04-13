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
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Título, autor ou ISBN...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),

              Container(
                width: 1,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: const Color.fromARGB(75, 158, 158, 158),
              ),

              DropdownButton<String>(
                focusColor: Colors.transparent,
                value: categoriaSelecionada,
                hint: const Text('Todas Categorias'),

                underline: const SizedBox(),

                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),

                items: categorias.map((categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    categoriaSelecionada = value;
                  });
                },
              ),

              Container(
                width: 1,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: const Color.fromARGB(75, 158, 158, 158),
              ),

              DropdownButton<String>(
                focusColor: Colors.transparent,
                value: disponibilidadeSelecionada,
                hint: const Text('Disponibilidade'),

                underline: const SizedBox(),

                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),

                items: disponivel.map((disponivel) {
                  return DropdownMenuItem<String>(
                    value: disponivel,
                    child: Text(disponivel),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    disponibilidadeSelecionada = value;
                  });
                },
              ),
              Padding(padding: EdgeInsetsGeometry.only(left: 10)),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffE7E8EA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_download_outlined,
                          color: Color(0xff191C1E),
                        ),
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
                itemCount: livros.length + 1, // +1 para header fake
                itemBuilder: (context, index) {
                  // HEADER FIXO
                  if (index == 0) {
                    return Container(
                      color: const Color(0xff374151),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "Capa",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
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
                    );
                  }

                  final livro = livros[index - 1];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? const Color(0xffF9FAFB)
                          : Colors.white,
                      border: const Border(
                        bottom: BorderSide(color: Color(0xffE5E7EB)),
                      ),
                    ),
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
                        Expanded(
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
                        SizedBox(
                          width: 80,
                          child: Text(livro.tombo.toString()),
                        ),
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
