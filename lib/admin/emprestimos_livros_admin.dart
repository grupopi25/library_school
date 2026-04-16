import 'package:flutter/material.dart';

class EmprestimosLivrosAdmin extends StatelessWidget {
  const EmprestimosLivrosAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Empréstimos',
                style: TextStyle(
                  color: Color(0xff191C1E),
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'Gestão de circulação e controle de acervo',
                style: TextStyle(
                  color: Color(0xff64748B),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
                crossAxisCount = 2;
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
                              child: Icon(Icons.check),
                            ),
                            Container(
                              color: const Color(0xffF0FDF4),
                              child: const Text(
                                'ATIVOS',
                                style: TextStyle(color: Color(0xff16A34A)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Total',
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
                              child: Icon(
                                Icons.warning_amber_rounded,
                                color: const Color(0xff001C39),
                              ),
                            ),
                            Container(
                              color: const Color(0xffF0FDF4),
                              child: const Text(
                                'ATRASADOS',
                                style: TextStyle(
                                  color: Color(0xff2563EB),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Livros Atrasados',
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
                              child: Icon(
                                Icons.hourglass_bottom,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF0FDF4),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'PENDENTES',
                                  style: TextStyle(
                                    color: Color(0xffBA1A1A),
                                    fontWeight: FontWeight.bold,
                                  ),
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
                              child: Icon(Icons.today_outlined),
                            ),
                            Container(
                              color: const Color.fromARGB(128, 255, 219, 205),
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                'DEVOLVIDOS HOJE',
                                style: TextStyle(
                                  color: Color(0xff943700),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Total',
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
        ],
      ),
    );
  }
}
