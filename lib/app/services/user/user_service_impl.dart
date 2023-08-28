import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepositoryImpl _userRepositoryImpl;

  UserServiceImpl({required userRepository})
      : _userRepositoryImpl = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepositoryImpl.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepositoryImpl.login(email, password);
}
