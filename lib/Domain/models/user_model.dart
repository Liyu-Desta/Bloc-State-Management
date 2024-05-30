// lib/data/models/user_model.dart

class UserModel {
  final String email;
  final String userId;
  final String role;

  UserModel({required this.email, required this.userId, required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
      role: json['roles'][0],
      userId: json['userId'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'role': role,
    };
  }
}
