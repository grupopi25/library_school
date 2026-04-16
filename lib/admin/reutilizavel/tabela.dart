import 'package:flutter/material.dart';

class Tabela extends StatelessWidget {
  final List<String> colunas;
  final List<Map<String, String>> dados;

  const Tabela({super.key, required this.colunas, required this.dados});
  Color _getStatusColor(String status) {
    switch (status) {
      case "Disponível":
        return Colors.green;

      case "Emprestado":
        return Colors.amber; // amarelo

      case "Atrasado":
        return Colors.red;

      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ultimos Emprestimos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Ver todos',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: colunas.map((coluna) {
                return Expanded(
                  child: Center(
                    child: Text(
                      coluna,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            /// LINHAS
            ...dados.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: colunas.map((coluna) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          item[coluna] ?? '',
                          style: TextStyle(
                            color: coluna == "Status"
                                ? _getStatusColor(item[coluna] ?? '')
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
