import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> values = [10, 20, 30, 40, 50, 60];

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: Row(
        children: [
          /// SIDEBAR
          Container(
            width: 230,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Lumina Library",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                menuItem("Dashboard", true),
                menuItem("Livros", false),
                menuItem("Alunos", false),
                menuItem("Empréstimos", false),
                menuItem("Relatórios", false),
              ],
            ),
          ),

          /// CONTEÚDO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("+ New Loan"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// CARDS
                  Row(
                    children: [
                      statCard("Total Books", "12,482"),
                      const SizedBox(width: 12),
                      statCard("Borrowed Books", "1,240"),
                      const SizedBox(width: 12),
                      statCard("Late Books", "42", Colors.red.shade50),
                      const SizedBox(width: 12),
                      statCard("Active Students", "3,120"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// GRÁFICO + CATEGORIAS
                  Expanded(
                    child: Row(
                      children: [
                        /// GRÁFICO
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: cardDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Loan Activity",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: BarChart(
                                    BarChartData(
                                      borderData: FlBorderData(show: false),
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              const months = [
                                                'M1',
                                                'M2',
                                                'M3',
                                                'M4',
                                                'M5',
                                                'M6',
                                              ];
                                              return Text(
                                                months[value.toInt()],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      barGroups: List.generate(values.length, (
                                        i,
                                      ) {
                                        return BarChartGroupData(
                                          x: i,
                                          barRods: [
                                            BarChartRodData(
                                              toY: values[i],
                                              width: 10,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.blue.shade200,
                                                  Colors.blue,
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// CATEGORIAS
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: cardDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Popular Categories",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                categoryBar("Literature", 0.85),
                                categoryBar("Science", 0.64),
                                categoryBar("Philosophy", 0.42),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// COMPONENTES

  Widget menuItem(String title, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: active ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.blue : Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget statCard(String title, String value, [Color? customColor]) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: cardDecoration(customColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryBar(String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          const SizedBox(height: 4),
          Text("${(value * 100).toInt()}%"),
        ],
      ),
    );
  }

  BoxDecoration cardDecoration([Color? color]) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
