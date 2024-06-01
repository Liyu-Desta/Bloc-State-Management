import 'dart:convert';

class Profile {
  final String id; // Adding id field
  final String email;
  final String password;
  final String phoneNumber;
  

  Profile({
    required this.id, // Initializing id in the constructor
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['_id'], // Make sure to adjust according to your API response
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'password':password,
     
    };
  }
}
