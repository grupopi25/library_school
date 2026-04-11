import 'package:flutter/material.dart';
import 'package:library_school/admin/emprestimos_livros_admin.dart';
import 'package:library_school/admin/header_admin.dart';
import 'package:library_school/admin/home_page_admin.dart';
import 'package:library_school/admin/livros_admin.dart';

class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({super.key});

  @override
  State<NavbarAdmin> createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  int indeceSelecionado = 0;

  final List<Widget> pages = [
    HomePageAdmin(),
    LivrosAdmin(),
    Center(child: Text('Página Aluno', style: TextStyle(fontSize: 24))),
    EmprestimosLivrosAdmin(),
    Center(child: Text('Página Relatórios', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width * 0.25;
    double larguraMenu = largura.clamp(200, 250);

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            /// MENU LATERAL
            Container(
              width: larguraMenu,
              child: Column(
                children: [
                  Expanded(
                    child: Drawer(
                      backgroundColor:
                          Color.fromRGBO(248, 250, 252, 0.8),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height,
                          ),
                          child: Column(
                            spacing: 5,
                            children: [
                              Container(
                                margin: EdgeInsets.all(32),
                                child: Text(
                                  'School Library',
                                  style: TextStyle(
                                    color: Color(0xff1E40AF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                              /// Dashboard
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indeceSelecionado = 0;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: indeceSelecionado == 0
                                        ? Color(0xffE2E8F0)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(9),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/icon.png',
                                              color:
                                                  indeceSelecionado == 0
                                                      ? Color(0xff1D4ED8)
                                                      : Color(0xff64748B),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Dashboard',
                                              style: TextStyle(
                                                color:
                                                    indeceSelecionado ==
                                                            0
                                                        ? Color(
                                                            0xff1D4ED8)
                                                        : Color(
                                                            0xff64748B),
                                                fontWeight:
                                                    indeceSelecionado ==
                                                            0
                                                        ? FontWeight.w700
                                                        : FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        height: 50,
                                        color:
                                            indeceSelecionado == 0
                                                ? Color(0xff1D4ED8)
                                                : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// Livros
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indeceSelecionado = 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: indeceSelecionado == 1
                                        ? Color(0xffE2E8F0)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(9),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/icon1.png',
                                              color:
                                                  indeceSelecionado == 1
                                                      ? Color(0xff1D4ED8)
                                                      : Color(0xff64748B),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Livros',
                                              style: TextStyle(
                                                color:
                                                    indeceSelecionado ==
                                                            1
                                                        ? Color(
                                                            0xff1D4ED8)
                                                        : Color(
                                                            0xff64748B),
                                                fontWeight:
                                                    indeceSelecionado ==
                                                            1
                                                        ? FontWeight.w700
                                                        : FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        height: 50,
                                        color:
                                            indeceSelecionado == 1
                                                ? Color(0xff1D4ED8)
                                                : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// Alunos
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indeceSelecionado = 2;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: indeceSelecionado == 2
                                        ? Color(0xffE2E8F0)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(9),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/icon-2.png',
                                              color:
                                                  indeceSelecionado == 2
                                                      ? Color(0xff1D4ED8)
                                                      : Color(0xff64748B),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Alunos',
                                              style: TextStyle(
                                                color:
                                                    indeceSelecionado ==
                                                            2
                                                        ? Color(
                                                            0xff1D4ED8)
                                                        : Color(
                                                            0xff64748B),
                                                fontWeight:
                                                    indeceSelecionado ==
                                                            2
                                                        ? FontWeight.w700
                                                        : FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        height: 50,
                                        color:
                                            indeceSelecionado == 2
                                                ? Color(0xff1D4ED8)
                                                : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// Empréstimos
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indeceSelecionado = 3;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: indeceSelecionado == 3
                                        ? Color(0xffE2E8F0)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(9),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/icon-3.png',
                                              color:
                                                  indeceSelecionado == 3
                                                      ? Color(0xff1D4ED8)
                                                      : Color(0xff64748B),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Empréstimos',
                                              style: TextStyle(
                                                color:
                                                    indeceSelecionado ==
                                                            3
                                                        ? Color(
                                                            0xff1D4ED8)
                                                        : Color(
                                                            0xff64748B),
                                                fontWeight:
                                                    indeceSelecionado ==
                                                            3
                                                        ? FontWeight.w700
                                                        : FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        height: 50,
                                        color:
                                            indeceSelecionado == 3
                                                ? Color(0xff1D4ED8)
                                                : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// Relatórios
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    indeceSelecionado = 4;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: indeceSelecionado == 4
                                        ? Color(0xffE2E8F0)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(9),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/container.png',
                                              color:
                                                  indeceSelecionado == 4
                                                      ? Color(0xff1D4ED8)
                                                      : Color(0xff64748B),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Relatórios',
                                              style: TextStyle(
                                                color:
                                                    indeceSelecionado ==
                                                            4
                                                        ? Color(
                                                            0xff1D4ED8)
                                                        : Color(
                                                            0xff64748B),
                                                fontWeight:
                                                    indeceSelecionado ==
                                                            4
                                                        ? FontWeight.w700
                                                        : FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        height: 50,
                                        color:
                                            indeceSelecionado == 4
                                                ? Color(0xff1D4ED8)
                                                : Colors.transparent,
                                      ),
                                    ],
                                  ),
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
            ),

            /// CONTEÚDO PRINCIPAL
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 300),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width -
                        larguraMenu)
                    .clamp(200, double.infinity),
                child: Column(
                  children: [
                    HeaderAdmin(),
                    Expanded(
                      child: Container(
                        color: Color(0x7EE2E8F0),
                        child: pages[indeceSelecionado],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}