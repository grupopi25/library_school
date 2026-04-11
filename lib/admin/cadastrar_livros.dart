import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CadastrarLivros extends StatefulWidget {
  const CadastrarLivros({super.key});

  @override
  State<CadastrarLivros> createState() => _CadastrarLivrosState();
}

class _CadastrarLivrosState extends State<CadastrarLivros> {
  final List<String> categoriasCadastro = [
    'Todas as Categorias',
    'Romance',
    'Tecnologia',
    'História',
  ];

  String? categoriaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F4F6),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: SizedBox(
            width: 600,

            child:
                // header
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // voltar
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text(
                          'Voltar',
                          style: TextStyle(
                            color: Color(0xff004AC6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Registrar Novo Livro',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff191C1E),
                        ),
                      ),
                      Text(
                        'Preencha os detalhes técnicos para catalogar o item no sistema.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff434655),
                        ),
                      ),
                      SizedBox(height: 10),
                      // UPLOAD DE IMAGENS
                      DottedBorder(
                        color: Colors.grey.shade400,
                        strokeWidth: 2,
                        dashPattern: const [6, 4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(16),
                          // camera
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined),
                              SizedBox(height: 8),
                              Text('Capa do Livro'),
                              SizedBox(height: 4),
                              Text(
                                'PNG, JPG até 10MB (Proporção 3:4 recomendada)',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // CADASTRO
                      Text(
                        'Informações Gerais',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff004AC6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'TÍTULO DO LIVRO *',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff434655),
                        ),
                      ),

                      SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0x1D8C8D91),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Ex: O Pequeno Príncipe',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      Row(
                        children: [
                          // AUTOR
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AUTOR(A)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff434655),
                                  ),
                                ),

                                SizedBox(height: 6),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0x1D8C8D91),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Ex: Romance',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),

                          // CATEGORIA
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CATEGORIA",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff434655),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1D8C8D91),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: categoriaSelecionada,
                                    hint: const Text('Todas Categorias'),

                                    isExpanded:
                                        true, // 🔥 faz ocupar toda largura

                                    underline: const SizedBox(),

                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    ),

                                    items: categoriasCadastro.map((categoria) {
                                      return DropdownMenuItem<String>(
                                        value: categoria,
                                        child: Center(child: Text(categoria)),
                                      );
                                    }).toList(),

                                    onChanged: (value) {
                                      setState(() {
                                        categoriaSelecionada = value;
                                      });
                                    },

                                    selectedItemBuilder: (context) {
                                      return categoriasCadastro.map((
                                        categoria,
                                      ) {
                                        return Center(child: Text(categoria));
                                      }).toList();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 12),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Especificações Técnicas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff004AC6),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          // TOMBO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOMBO",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff434655),
                                  ),
                                ),

                                SizedBox(height: 6),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0x1D8C8D91),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: '123456789',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          // ANO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "ANO DE PUBLICAÇÃO",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff434655),
                                  ),
                                ),

                                const SizedBox(height: 6),

                                GestureDetector(
                                  onTap: () async {
                                    DateTime? dataSelecionada =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );

                                    if (dataSelecionada != null) {
                                      print(dataSelecionada);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0x1D8C8D91),
                                    ),
                                    child: const Text(
                                      "Selecionar data",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // ISBN
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ISBN",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff434655),
                                    ),
                                  ),

                                  SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0x1D8C8D91),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: '978-3-16-148410-0',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),

                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xffFFDBCD),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Color(0xff943700),
                                size: 20,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'INFORMAÇÃO',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff360F00),
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text(
                                      'Certifique-se de que a categoria selecionada reflete a taxonomia atual da biblioteca para facilitar a busca editorial dos alunos.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff360F00),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0x1D8C8D91),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Center(
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Color(0xff191C1E),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff004AC6),
                                      Color(0xff2563EB),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Center(
                                    child: Text(
                                      "Salvar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
