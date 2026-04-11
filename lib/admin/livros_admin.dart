import 'package:flutter/material.dart';
import 'package:library_school/admin/cadastrar_livros.dart';

class LivrosAdmin extends StatefulWidget {
  const LivrosAdmin({super.key});

  @override
  State<LivrosAdmin> createState() => _LivrosAdminState();
}

class _LivrosAdminState extends State<LivrosAdmin> {
  final List<String> categorias = [
    'Todas as Categorias',
    'Romance',
    'Tecnologia',
    'História',
  ];
  final List<String> disponivel = [
    'Disponibilidade',
    'Disponivel',
    'Emprestado'
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CadastrarLivros()));
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
              
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Título, autor ou ISBN...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),

              Container(
                width: 1,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: const Color.fromARGB(75, 158, 158, 158),
              ),

              DropdownButton<String>(
                focusColor: Colors.transparent,
                value: categoriaSelecionada,
                hint: const Text('Todas Categorias'),

                underline: const SizedBox(),

                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),

                items: categorias.map((categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    categoriaSelecionada = value;
                  });
                },
              ),


              Container(
                width: 1,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: const Color.fromARGB(75, 158, 158, 158),
              ),

              DropdownButton<String>(
                focusColor: Colors.transparent,
                value: disponibilidadeSelecionada,
                hint: const Text('Disponibilidade'),

                underline: const SizedBox(),

                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),

                items: disponivel.map((disponivel) {
                  return DropdownMenuItem<String>(
                    value: disponivel,
                    child: Text(disponivel),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    disponibilidadeSelecionada = value;
                  });
                },
              ),
Padding(padding: EdgeInsetsGeometry.only(left: 10),),
Expanded(
  child: Container(
    
  decoration: BoxDecoration(color: Color(0xffE7E8EA),borderRadius: BorderRadius.circular(10),),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.file_download_outlined ,color:Color(0xff191C1E)),
        Text('Exportar',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Color(0xff191C1E),))
      ],),
    )
  
  
  
  ),
)
            ],
          ),
        ],
      ),
    );
  }
}
