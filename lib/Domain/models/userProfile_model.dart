// lib/data/models/user_profile.dart

import 'dart:typed_data';

class UserProfile {
  final String userName;
  final String email;
  final String phoneNumber;
  final String bio;
  final String location;
  final String interests;
  final String socialMedia;
  final Uint8List? profileImageBytes; // Optional profile image bytes

  UserProfile({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.location,
    required this.interests,
    required this.socialMedia,
    this.profileImageBytes,
  });

  get userId => null;

  UserProfile copyWith({
    String? userName,
    String? email,
    String? phoneNumber,
    String? bio,
    String? location,
    String? interests,
    String? socialMedia,
    Uint8List? profileImageBytes,
  }) {
    return UserProfile(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      interests: interests ?? this.interests,
      socialMedia: socialMedia ?? this.socialMedia,
      profileImageBytes: profileImageBytes ?? this.profileImageBytes,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      bio: json['bio'] ?? '',
      location: json['location'] ?? '',
      interests: json['interests'] ?? '',
      socialMedia: json['socialMedia'] ?? '',
      profileImageBytes: json['profileImageBytes'] != null
          ? Uint8List.fromList(List<int>.from(json['profileImageBytes']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'location': location,
      'interests': interests,
      'socialMedia': socialMedia,
      'profileImageBytes': profileImageBytes?.toList(),
    };
  }
}
