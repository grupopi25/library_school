import 'package:library_school/api/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  login(){
    var dio = CustomDio().instance;

    dio.post('http://localhost:8081/login',data: {
      'username': 'eduardo',
      'password':123
    }).then((res) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', res.data['token']);
    }).catchError((error){
      throw Exception('Login ou senha Invalida.');
    });
  }
}