import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:library_school/api/models/user_model.dart';
import 'package:library_school/api/utils/custom_dio.dart';

class UserResponse {
  final List<UserModel> users;
  final int totalPages;
  final int totalItems;

  UserResponse({
    required this.users,
    required this.totalPages,
    required this.totalItems,
  });
}

class UserRepository {
  final dio = CustomDio.withAuthentication().instance;

  Future<UserResponse> findAll(int page) async {
    final res = await dio.get(
      '/usuarios/listar-usuario?page=$page&limit=100',
    );

    final data = res.data;

    return UserResponse(
      users: (data['data'] as List)
          .map((u) => UserModel.fromMap(u))
          .toList(),
      totalPages: data['totalPages'] ?? 1,
      totalItems: data['totalItems'] ?? 0,
    );
  }

  Future<void> atualizarStatus(int id, bool status) async {
    await dio.patch(
      "/usuarios/atualizar-status/$id",
      data: {"status": status},
    );
  }

  Future<Uint8List> baixarPdfUsuarios() async {
    final response = await dio.get(
      '/usuarios/pdf',
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    return Uint8List.fromList(response.data);
  }
}