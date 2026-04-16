import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:library_school/admin/reutilizavel/grafico.dart';
import 'package:library_school/admin/reutilizavel/tabela.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Color(0xff191C1E),
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Segunda, 24 Jan de 26',
                      style: TextStyle(
                        color: Color(0xff64748B),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff004AC6), Color(0xff2563EB)],
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(5),

                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),

                    onPressed: () {},
                    child: Row(
                      spacing: 2,
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 14),
                        Text(
                          'Add Livro',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // CARDS
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 4; // Desktop
                if (constraints.maxWidth < 600) {
                  crossAxisCount = 1; // Mobile
                } else if (constraints.maxWidth < 1024) {
                  crossAxisCount = 2; // Tablet
                }

                return GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 2,
                  ),
                  children: [
                    // CARD 1
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFF6FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  'assets/image/icon1.png',
                                  color: const Color(0xff2563EB),
                                ),
                              ),
                              Container(
                                color: const Color(0xffF0FDF4),
                                child: const Text(
                                  '+2.4%',
                                  style: TextStyle(color: Color(0xff16A34A)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Total de Livros',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff64748B),
                                ),
                              ),
                              Text(
                                '12.123',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff191C1E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // CARD 2
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffD4E3FF),
                                ),
                                child: Image.asset(
                                  'assets/image/icon-3.png',
                                  color: const Color(0xff001C39),
                                ),
                              ),
                              Container(
                                color: const Color(0xffF0FDF4),
                                child: const Text(
                                  'ATIVOS',
                                  style: TextStyle(
                                    color: Color(0xff2563EB),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Livros Emprestados',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff64748B),
                                ),
                              ),
                              Text(
                                '1.240',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff191C1E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // CARD 3
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(13, 186, 26, 26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffBA1A1A),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  'assets/image/time.png',
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                color: const Color(0xffF0FDF4),
                                child: const Text(
                                  'urgente',
                                  style: TextStyle(
                                    color: Color(0xffBA1A1A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Livros Atrasados',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(179, 186, 26, 26),
                                ),
                              ),
                              Text(
                                '24',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffBA1A1A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // CARD 4
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFDBCD),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  'assets/image/icon-2.png',
                                  color: const Color.fromARGB(255, 54, 15, 0),
                                ),
                              ),
                              Container(
                                color: const Color.fromARGB(128, 255, 219, 205),
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'Ativos',
                                  style: TextStyle(
                                    color: Color(0xff943700),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Estudantes Ativos',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff64748B),
                                ),
                              ),
                              Text(
                                '24',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff191C1E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            // GRAFICOs
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// GRÁFICO DE BARRAS
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Atividade de Empréstimo',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Últimos 6 meses'),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// GRÁFICO
                        Grafico(
                          valores: [10, 20, 30, 40, 50, 60],
                          campos: ['M1', 'M2', 'M3', 'M4', 'M5', 'M6'],
                          cor: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// GRÁFICO DE CATEGORIAS
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Turma de destaque de leitura",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),

                        GraficoCategorias(
                          titulo: "1º ANO",
                          valor: 0.85,
                          cor: Colors.lightBlueAccent,
                        ),
                        GraficoCategorias(
                          titulo: "2ºANO",
                          valor: 0.64,
                          cor: Colors.blue,
                        ),
                        GraficoCategorias(
                          titulo: "3º ANO",
                          valor: 0.42,
                          cor: Color(0xFF218EC5),
                        ),
                        GraficoCategorias(
                          titulo: "FUNCIONARIOS",
                          valor: 0.42,
                          cor: Colors.lightBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // TABELA DE EMRPESTIMOS
            Tabela(
              colunas: ['Livros', 'Alunos', 'Data', 'Status'],
              dados: [
                {
                  'Livros': 'Dom Casmurro',
                  'Alunos': 'João',
                  'Data': '10/04',
                  'Status': 'Atrasado',
                },
                {
                  'Livros': 'Dom Casmurro',
                  'Alunos': 'João',
                  'Data': '10/04',
                  'Status': 'Emprestado',
                },
                {
                  'Livros': 'Dom Casmurro',
                  'Alunos': 'João',
                  'Data': '10/04',
                  'Status': 'Atrasado',
                },
                {
                  'Livros': 'Dom Casmurro',
                  'Alunos': 'João',
                  'Data': '10/04',
                  'Status': 'Disponível',
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
