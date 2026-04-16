import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_school/api/models/user_model.dart';
import 'package:library_school/api/repositores/user_repository.dart';
import 'package:library_school/api/services/user_service.dart';
import 'package:flutter/services.dart';
import 'package:library_school/api/utils/custom_dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GestaoAlunoAdmin extends StatefulWidget {
  const GestaoAlunoAdmin({super.key});

  @override
  State<GestaoAlunoAdmin> createState() => _GestaoAlunoAdminState();
}

class _GestaoAlunoAdminState extends State<GestaoAlunoAdmin> {
  bool loadingPdf = false;
  List<UserModel> lista = [];
  List<UserModel> listaFiltrada = [];
  bool loading = true;
  int totalUsuarios = 0;
  int ativos = 0;
  int bloqueados = 0;
  int currentPage = 1;
  int totalPages = 1;
  final service = UserService();
 Future<void> exportarPdfUsuarios(List<UserModel> listaFiltrada) async {
  final pdf = pw.Document();

  // Carrega a fonte personalizada
  final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (context) => [
        pw.Text(
          'RELATÓRIO DE USUÁRIOS',
          style: pw.TextStyle(
            font: ttf,
            fontSize: 22,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 20),
        pw.TableHelper.fromTextArray(
          headers: ['Nome', 'Email', 'Ano', 'Status'],
          data: listaFiltrada.map((u) {
            return [
              u.name,
              u.email,
              u.ano?.toString() ?? "-",
              u.status ? "Ativo" : "Bloqueado",
            ];
          }).toList(),
          headerStyle: pw.TextStyle(
            font: ttf,
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
          ),
          headerDecoration: const pw.BoxDecoration(
            color: PdfColors.blue800,
          ),
          cellStyle: pw.TextStyle(
            font: ttf,
            fontSize: 10,
          ),
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.centerLeft,
          cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
        ),
      ],
    ),
  );

  final bytes = await pdf.save();

  // Compartilha o PDF (funciona em Mobile e Web)
  await Printing.sharePdf(
    bytes: bytes,
    filename: 'usuarios.pdf',
  );
}
  void aplicarFiltros({String? busca}) {
    List<UserModel> temp = List.from(lista);

    // STATUS
    if (statusSelecionado == 'ATIVOS') {
      temp = temp.where((u) => u.status == true).toList();
    } else if (statusSelecionado == 'BLOQUEADOS') {
      temp = temp.where((u) => u.status == false).toList();
    }

    // TURMA
    if (categoriaDaTurmaSelecionada != null &&
        categoriaDaTurmaSelecionada != 'Todas as Turmas') {
      temp = temp.where((u) {
        return "${u.ano}° ANO" == categoriaDaTurmaSelecionada;
      }).toList();
    }

    // BUSCA
    if (busca != null && busca.isNotEmpty) {
      temp = temp.where((u) {
        return u.name.toLowerCase().contains(busca.toLowerCase()) ||
            u.email.toLowerCase().contains(busca.toLowerCase());
      }).toList();
    }

    setState(() {
      listaFiltrada = temp;
    });
  }

  Future<void> carregarUsuarios() async {
    final response = await service.listarUsuarios(currentPage);

    final usuarios = response.users;

    setState(() {
      lista = usuarios;
      totalPages = response.totalPages;
      listaFiltrada = usuarios;
      totalUsuarios = usuarios.length;
      ativos = usuarios.where((u) => u.status == true).length;
      bloqueados = usuarios.where((u) => u.status == false).length;

      loading = false;
    });
  }

  Future<void> mudarPagina(int page) async {
    setState(() {
      currentPage = page;
      loading = true;
    });

    await carregarUsuarios();
  }

  @override
  void initState() {
    super.initState();
    carregarUsuarios();
  }

  String? statusSelecionado = 'TODOS';
  final List<String> categoriasDaTurma = [
    'Todas as Turmas',
    '1° ANO',
    '2° ANO',
    '3° ANO',
  ];

  String? categoriaDaTurmaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  PESQUISA
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  onChanged: (value) {
                    aplicarFiltros(busca: value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Color(0xff2563EB)),
                    border: InputBorder.none,
                    hintText:
                        'Pesquisar Estudante por Nome, E-mail ou Matrícula',
                  ),
                ),
              ),
            ),
          ),

          //  HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "GESTÃO ESCOLAR",
                    style: TextStyle(
                      color: Color(0xff004AC6),
                      fontSize: 16,
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

              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '$ativos',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xff191C1E),
                        ),
                      ),
                      const Text(
                        'ATIVOS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xff94A3B8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  Container(width: 1, height: 40, color: Colors.grey.shade300),

                  const SizedBox(width: 16),

                  Column(
                    children: [
                      Text(
                        '$bloqueados',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xff191C1E),
                        ),
                      ),
                      const Text(
                        'BLOQUEADOS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xffBA1A1A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          //  FILTRO + RELATÓRIO
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //  FILTRO
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'FILTRAR POR TURMA',
                                style: TextStyle(
                                  color: Color(0xff94A3B8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              SizedBox(
                                width: 180,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1D8C8D91),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: categoriaDaTurmaSelecionada,
                                    hint: const Text('Todas Categorias'),
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),
                                    items: categoriasDaTurma.map((categoria) {
                                      return DropdownMenuItem<String>(
                                        value: categoria,
                                        child: Text(categoria),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        categoriaDaTurmaSelecionada = value;
                                      });
                                      aplicarFiltros();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'STATUS DA CONTA',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff94A3B8),
                                ),
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  _status('TODOS'),
                                  const SizedBox(width: 8),
                                  _status('ATIVOS'),
                                  const SizedBox(width: 8),
                                  _status('BLOQUEADOS'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // RELATÓRIO
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Relatórios Rápidos',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF191C1E),
                                ),
                              ),
                              Text(
                                'Exportar dados dos alunos',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF191C1E),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 10),

                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(50, 100, 168, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
  onPressed: loadingPdf
      ? null
      : () async {
          setState(() => loadingPdf = true);
          try {
            await exportarPdfUsuarios(listaFiltrada);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("PDF exportado com sucesso!"),
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Erro ao exportar PDF: $e"),
                backgroundColor: Colors.red,
              ),
            );
          } finally {
            setState(() => loadingPdf = false);
          }
        },
  icon: loadingPdf
      ? const CircularProgressIndicator(strokeWidth: 2)
      : const Icon(
          Icons.file_download_outlined,
          size: 17,
          color: Color(0xff0060AC),
        ),
)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // TABELA DE LIVROS
          SizedBox(height: 20),

          Expanded(
            child: Container(
              width: double.infinity,
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
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: listaFiltrada.length + 1,
                      itemBuilder: (context, index) {
                        // ================= HEADER =================
                        if (index == 0) {
                          return Container(
                            color: const Color(0xff374151),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: const Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Nome",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Email",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Ano",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Status",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Ações",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final usuario = listaFiltrada[index - 1];

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                              // NOME
                              Expanded(
                                flex: 3,
                                child: Text(
                                  usuario.name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              // EMAIL
                              Expanded(
                                flex: 3,
                                child: Text(
                                  usuario.email,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff6B7280),
                                  ),
                                ),
                              ),

                              // ANO
                              Expanded(
                                flex: 2,
                                child: Text(
                                  usuario.ano != null
                                      ? "${usuario.ano}º ANO"
                                      : "-",
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
                                      color: usuario.status
                                          ? const Color(0xffDCFCE7)
                                          : const Color(0xffFEE2E2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      usuario.status ? "Ativo" : "Bloqueado",
                                      style: TextStyle(
                                        color: usuario.status
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
                                      onPressed: () async {
                                        bool status = usuario.status;

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setStateDialog) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Alterar Status",
                                                  ),

                                                  content: SwitchListTile(
                                                    value: status,
                                                    title: Text(
                                                      status
                                                          ? "Ativo"
                                                          : "Bloqueado",
                                                    ),
                                                    onChanged: (value) {
                                                      setStateDialog(() {
                                                        status = value;
                                                      });
                                                    },
                                                  ),

                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                            context,
                                                          ),
                                                      child: const Text(
                                                        "Cancelar",
                                                      ),
                                                    ),

                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await service.atualizarStatus(
                                                          usuario
                                                              .id, // 👈 ID do usuário
                                                          status, // 👈 novo status
                                                        );

                                                        Navigator.pop(context);

                                                        await carregarUsuarios(); // atualiza lista

                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              status
                                                                  ? "Usuário ativado"
                                                                  : "Usuário bloqueado",
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Salvar",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
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

  Widget _status(String text) {
    final ativo = statusSelecionado == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          statusSelecionado = text;
        });
        aplicarFiltros();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ativo ? const Color(0XFF004AC6) : const Color(0XFFF3F4F6),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ativo ? Colors.white : const Color(0xff434655),
          ),
        ),
      ),
    );
  }
}
