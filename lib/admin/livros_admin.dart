import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:library_school/admin/cadastrar_livros.dart';
import 'package:library_school/api/models/livro_model.dart';
import 'package:library_school/api/repositores/livro_repository.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  // livros: lista de LivroModel que você já tem

  Future<void> exportarPdf(List<LivroModel> livros) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text(
            'Catálogo de Livros',
            style: pw.TextStyle(font: ttf, fontSize: 24),
          ),

          pw.SizedBox(height: 20),

          pw.TableHelper.fromTextArray(
            headers: [
              'Título',
              'Autor',
              'Categoria',
              'Tombo',
              'ISBN',
              'Status',
            ],
            data: livros.map((l) {
              return [
                l.titulo,
                l.autor,
                l.categoria,
                l.tombo.toString(),
                l.isbn,
                l.status ? "Disponível" : "Emprestado",
              ];
            }).toList(),
            headerStyle: pw.TextStyle(font: ttf),
            cellStyle: pw.TextStyle(font: ttf),
          ),
        ],
      ),
    );

    final bytes = await pdf.save();

    // SALVAR NO DISPOSITIVO
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/catalogo_livros.pdf");

    await file.writeAsBytes(bytes);

    // 📥 DOWNLOAD / COMPARTILHAR
    await Printing.sharePdf(bytes: bytes, filename: "catalogo_livros.pdf");
  }

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
        final categoriaSelecionadaNormalizada = categoriaSelecionada
            ?.trim()
            .toLowerCase();
        final matchCategoria =
            categoriaSelecionadaNormalizada == null ||
            categoriaSelecionadaNormalizada == 'todas as categorias' ||
            livro.categoria.toLowerCase() == categoriaSelecionadaNormalizada;

        final disponibilidadeNormalizada = disponibilidadeSelecionada
            ?.trim()
            .toLowerCase();
        final matchStatus =
            disponibilidadeNormalizada == null ||
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
      livros = response.livros; 
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
    //  BUSCA
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

    Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: const Color.fromARGB(75, 158, 158, 158),
    ),

    // CATEGORIA
    SizedBox(
      width: 180,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: categoriaSelecionada,
          hint: const Text('Categorias'),
          items: categorias.map((categoria) {
            return DropdownMenuItem(
              value: categoria,
              child: Text(
                categoria,
                overflow: TextOverflow.ellipsis,
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

    const SizedBox(width: 10),

    Container(
      width: 1,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: const Color.fromARGB(75, 158, 158, 158),
    ),

    //  DISPONIBILIDADE
    SizedBox(
      width: 160,
      child: DropdownButton<String>(
        isExpanded: true,
        value: disponibilidadeSelecionada,
        hint: const Text('Status'),
        underline: const SizedBox(),
        items: disponivel.map((item) {
          return DropdownMenuItem(
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
    ),

    const SizedBox(width: 10),

    //  LIMPAR
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

    //  EXPORTAR 
    InkWell(
      onTap: () async {
        final todos = await repo.findAllNoPagination();
        await exportarPdf(todos);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xffE7E8EA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.file_download_outlined,
                color: Color(0xff191C1E)),
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
      itemCount: livros.length + 1,
      itemBuilder: (context, index) {
        
        // ================= HEADER =================
        if (index == 0) {
          return Container(
            color: const Color(0xff374151),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Capa",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Título & Autor",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Categoria",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 1,
                  child: Text("Tombo",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 2,
                  child: Text("ISBN",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Status",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Ações",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        final livro = livros[index - 1];

        // ================= LINHA =================
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
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
              Expanded(
                flex: 1,
                child: Center(
                  child: (livro.capa?.isNotEmpty ?? false)
                      ? Image.network(
                          "http://localhost:8081/uploads/${livro.capa}",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.book,
                                color: Color(0xff9CA3AF));
                          },
                        )
                      : const Icon(Icons.book,
                          color: Color(0xff9CA3AF)),
                ),
              ),

              // TITULO + AUTOR
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        livro.titulo,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: Text(
                        livro.autor,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  livro.categoria,
                  textAlign: TextAlign.center,
                ),
              ),

              Expanded(
                flex: 1,
                child: Text(
                  livro.tombo.toString(),
                  textAlign: TextAlign.center,
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  livro.isbn,
                  textAlign: TextAlign.center,
                ),
              ),

              // STATUS
              Expanded(
                flex: 2,
                child: Center(
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
              ),

              // AÇÕES
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility,
                          color: Color(0xff2563EB)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Color(0xff6B7280)),
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
