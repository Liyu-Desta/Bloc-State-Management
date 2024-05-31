import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:one/Domain/models/adminProfile_model.dart';
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/repositories/adminProfile_Repository.dart';


class AdminProfileRepositoryImpl implements AdminProfileRepository {
  final AuthApiService _apiService;

  AdminProfileRepositoryImpl({required AuthApiService apiService})
      : _apiService = apiService;

  @override
  Future<AdminProfile> fetchAdminProfile() async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.get(
        Uri.parse('http://localhost:3000/admin/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var adminProfileData = jsonDecode(response.body);
        return AdminProfile.fromJson(adminProfileData);
      } else {
        throw Exception('Failed to fetch admin profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch admin profile: $e');
    }
  }

  @override
  Future<void> updateProfilePicture(Uint8List profileImageBytes) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/picture'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'profileImageBytes': profileImageBytes}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile picture');
      }
    } catch (e) {
      throw Exception('Failed to update profile picture: $e');
    }
  }

  @override
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
      throw Exception('Failed to update admin name: $e');
    }
  }

  @override
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
      throw Exception('Failed to update email: $e');
    }
  }

  @override
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
      throw Exception('Failed to update phone number: $e');
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/admin/profile/password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'newPassword': newPassword}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to change password');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
