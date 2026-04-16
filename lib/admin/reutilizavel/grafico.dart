import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Grafico extends StatelessWidget {
  final List<double> valores;
  final List<String> campos;
  final Color cor;

  const Grafico({
    super.key,
    required this.valores,
    required this.campos,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    campos[value.toInt()],
                    style: TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
          ),
          // Barras
          barGroups: List.generate(valores.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: valores[index],
                  width: 10,
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [cor, cor],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class GraficoCategorias extends StatelessWidget {
  final String titulo;
  final double valor; // 0.0 até 1.0
  final Color cor;

  const GraficoCategorias({
    super.key,
    required this.titulo,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TEXTO + %
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("${(valor * 100).toInt()}%"),
            ],
          ),

          const SizedBox(height: 6),

          /// BARRA
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: valor,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(cor),
            ),
          ),
        ],
      ),
    );
  }
}
