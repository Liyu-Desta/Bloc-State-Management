// lib/infrastructure/userprofile_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:one/Domain/models/userProfile_model.dart';
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserProfileRepositoryImpl {
  final AuthApiService _apiService;

  UserProfileRepositoryImpl({required AuthApiService apiService})
      : _apiService = apiService;

  Future<UserProfile> fetchUserProfile(String userId) async {
    try {
      String? token = await _apiService.getToken();
      final response = await http.get(
        Uri.parse('http://localhost:3000/user-profiles/$userId'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UserProfile.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      String? token = await _apiService.getToken();
      final response = await http.put(
        Uri.parse('http://localhost:3000/user-profiles/${userProfile.userId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(userProfile.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }
}
