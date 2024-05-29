// // lib/application/user_service.dart
// import '../domain/entities/user.dart';
// import '../domain/repositories/user_repository.dart';

// class UserService {
//   final UserRepository userRepository;

//   UserService({required this.userRepository});

//   Future<bool> signup(String name, String email, String password, String phoneNumber) {
//     final user = User(name: name, email: email, phoneNumber: phoneNumber);
//     return userRepository.signup(user, password);
//   }

//   Future<bool> login(String email, String password) {
//     return userRepository.login(email, password);
//   }

//   Future<void> logout() {
//     return userRepository.logout();
//   }

//   Future<User?> getCurrentUser() {
//     return userRepository.getCurrentUser();
//   }
// }
