import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_services.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserServices _userServices;

  RegisterController({required UserServices userServices})
      : _userServices = userServices;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userServices.register(email, password);
      if (user != null) {
        // success
        success();
      } else {
        // Erro
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
