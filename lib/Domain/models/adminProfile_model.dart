import 'dart:typed_data';

class AdminProfile {
  final String adminName;
  final String email;
  final String phoneNumber;
  final Uint8List? profileImageBytes; // Optional profile image bytes

  AdminProfile({
    required this.adminName,
    required this.email,
    required this.phoneNumber,
    this.profileImageBytes,
  });

  AdminProfile copyWith({
    String? adminName,
    String? email,
    String? phoneNumber,
    Uint8List? profileImageBytes,
  }) {
    return AdminProfile(
      adminName: adminName ?? this.adminName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageBytes: profileImageBytes ?? this.profileImageBytes,
    );
  }

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      adminName: json['adminName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profileImageBytes: json['profileImageBytes'] != null
          ? Uint8List.fromList(List<int>.from(json['profileImageBytes']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminName': adminName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageBytes': profileImageBytes?.toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminProfile &&
          runtimeType == other.runtimeType &&
          adminName == other.adminName &&
          email == other.email &&
          phoneNumber == other.phoneNumber &&
          profileImageBytes == other.profileImageBytes;

  @override
  int get hashCode =>
      adminName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      profileImageBytes.hashCode;

  @override
  String toString() {
    return 'AdminProfile{adminName: $adminName, email: $email, phoneNumber: $phoneNumber, profileImageBytes: $profileImageBytes}';
  }
}
