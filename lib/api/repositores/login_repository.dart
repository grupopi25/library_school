import 'package:library_school/api/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      var dio = CustomDio().instance;

      final res = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', res.data['token']);
    } catch (error) {
      throw Exception('Login ou senha inválida.');
    }
  }
}