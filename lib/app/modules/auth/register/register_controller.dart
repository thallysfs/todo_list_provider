import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_services.dart';

class RegisterController extends ChangeNotifier {
  final UserServices _userServices;
  String? error;
  bool success = false;

  RegisterController({required UserServices userServices})
      : _userServices = userServices;

  Future<void> registerUser(String email, String password) async {
    try {
      error = null;
      success = false;
      notifyListeners();

      final user = await _userServices.register(email, password);
      if (user != null) {
        // success
        success = true;
      } else {
        // Erro
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
