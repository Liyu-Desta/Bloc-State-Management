import 'dart:convert';

class userList {
  final String id;
  final String email;
  final String phoneNumber;
  late final String role;

  userList(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.role});

  factory userList.fromJson(Map<String, dynamic> json) {
    print(json);
    return userList(
      id: json['_id'],
      role: json['roles'][0],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
    };
  }

  userList copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? role,
  }) {
    return userList(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
    );
  }

  clone() {}
}
