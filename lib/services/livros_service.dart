import 'package:dio/dio.dart';
import 'package:library_school/api/utils/custom_dio.dart';

class LivrosService {
  final Dio dio = CustomDio.withAuthentication().instance;

 Future<void> cadastrarLivro({
  required String titulo,
  required String autor,
  required String categoria,
  required String tombo,
  required String isbn,
  required String descricao,
  required String imagePath,
}) async {
  try {

   
    if (imagePath.isEmpty) {
      print("Selecione uma imagem");
      return;
    }

    FormData formData = FormData.fromMap({
      "titulo": titulo,
      "autor": autor,
      "categoria": categoria,
      "tombo": tombo,
      "isbn": isbn,
      "descricao": descricao,
      "status": true,
      "ano_publicacao": DateTime.now().year,

      "capa": await MultipartFile.fromFile(imagePath),
    });

    final response = await dio.post(
      "http://localhost:8081/livros/cadLivros",
      data: formData,
    );

    print(response.data);

  } catch (e) {
    print("Erro ao cadastrar livro: $e");
  }
}
}