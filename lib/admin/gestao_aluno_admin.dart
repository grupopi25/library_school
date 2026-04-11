import 'package:flutter/material.dart';

class GestaoAlunoAdmin extends StatefulWidget {
  const GestaoAlunoAdmin({super.key});

  @override
  State<GestaoAlunoAdmin> createState() => _GestaoAlunoAdminState();
}

class _GestaoAlunoAdminState extends State<GestaoAlunoAdmin> {
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
                child:  TextFormField(
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
                    children: const [
                      Text(
                        '1,248',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xff191C1E),
                        ),
                      ),
                      Text(
                        'TOTAL ATIVOS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xff94A3B8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(width: 16),

                  Column(
                    children: const [
                      Text(
                        '1,248',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xff191C1E),
                        ),
                      ),
                      Text(
                        'PENDENTES',
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.file_download_outlined,
                                  size: 17,
                                  color: Color(0xff0060AC),
                                ),
                              ),
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