import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Domain/models/adminProfile_model.dart';


class AdminProfileApiProvider {
  final AuthApiService _apiService;

  AdminProfileApiProvider({required AuthApiService apiService})
      : _apiService = apiService;

  Future<void> updateProfilePicture(Uint8List profileImageBytes) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/picture'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'profileImage': base64Encode(profileImageBytes)}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile picture');
      }
    } catch (e) {
      throw Exception('Failed to update profile picture');
    }
  }

  Future<void> updateAdminName(String adminName) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/name'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'adminName': adminName}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update admin name');
      }
    } catch (e) {
      throw Exception('Failed to update admin name');
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/email'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update email');
      }
    } catch (e) {
      throw Exception('Failed to update email');
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/phone'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update phone number');
      }
    } catch (e) {
      throw Exception('Failed to update phone number');
    }
  }

  Future<void> saveAdminProfile({
    required String adminName,
    required String email,
    required String phoneNumber,
    Uint8List? profileImageBytes,
  }) async {
    try {
      String? token = await _apiService.getToken();
      var profileData = {
        'adminName': adminName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profileImage': profileImageBytes != null
            ? base64Encode(profileImageBytes)
            : null, // Convert image bytes to base64 string if available
      };

      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(profileData),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save admin profile');
      }
    } catch (e) {
      throw Exception('Failed to save admin profile');
    }
  }
   Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Failed to change password');
    }
  }
}

