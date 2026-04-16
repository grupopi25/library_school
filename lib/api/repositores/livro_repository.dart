import 'package:library_school/api/models/livro_model.dart';
import 'package:library_school/api/utils/custom_dio.dart';

class LivroResponse {
  final List<LivroModel> livros;
  final int totalPages;
  final int totalItems;

  LivroResponse({
    required this.livros,
    required this.totalPages,
    required this.totalItems,
  });
}

class LivroRepository {
  Future<LivroResponse> findAll(int page) async {
    var dio = CustomDio.withAuthentication().instance;

    final res = await dio.get(
      '/livros/livros?page=$page&limit=5',
    );

    return LivroResponse(
      livros: (res.data['data'] as List)
          .map((t) => LivroModel.fromMap(t))
          .toList(),
      totalPages: res.data['totalPages'] ?? res.data['pages'] ?? 1,
      totalItems: res.data['totalItems'] ?? res.data['total'] ?? 0,
    );
  }

  Future<List<LivroModel>> findFiltrar(
    String nome,
    String? categoria,
    String? status,
  ) async {
    var dio = CustomDio.withAuthentication().instance;

    final res = await dio.get(
      '/livros/pesquisar-livro',
      queryParameters: {
        'nome': nome,
        'categoria': categoria,
        'status': status,
      },
    );

    return (res.data as List)
        .map((t) => LivroModel.fromMap(t))
        .toList();
  }

  Future<List<LivroModel>> findAllNoPagination() async {
    var dio = CustomDio.withAuthentication().instance;

    final res = await dio.get('/livros/livros-todos');

    return (res.data as List)
        .map((t) => LivroModel.fromMap(t))
        .toList();
  }
}