// lib/domain/repositories/user_repository.dart
import 'package:one/Domain/entities/user.dart';
import 'package:one/Domain/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> signup(User user, String password);
  Future<UserModel?> login(String email, String password);
  Future<void> logout();
  Future<String?> getToken();
}
