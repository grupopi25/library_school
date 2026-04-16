import 'dart:typed_data';
import 'package:library_school/api/repositores/user_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'dart:io';

class UserService {
  final UserRepository _repository = UserRepository();

  Future<UserResponse> listarUsuarios(int page) async {
    return await _repository.findAll(page);
  }

  Future<void> atualizarStatus(int id, bool status) async {
    await _repository.atualizarStatus(id, status);
  }

  Future<void> baixarPdfUsuarios() async {
    final bytes = await _repository.baixarPdfUsuarios();

    // ⚠️ opcional: salvar localmente
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/usuarios.pdf');
    await file.writeAsBytes(bytes);

    // compartilhar PDF
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'usuarios.pdf',
    );
  }
}