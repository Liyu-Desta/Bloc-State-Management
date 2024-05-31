// lib/infrastructure/userprofile_api_provider.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:one/Domain/models/userProfile_model.dart';
import 'package:one/Infrastructure/auth_api_service.dart';


class UserProfileApiProvider {
  final AuthApiService _apiService;

  UserProfileApiProvider({required AuthApiService apiService})
      : _apiService = apiService;

  Future<UserProfile> fetchUserProfile() async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.get(
        Uri.parse('http://localhost:3000/auth/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        return UserProfile.fromJson(userData);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      String? token = await _apiService.getToken();
      var response = await http.put(
        Uri.parse('http://localhost:3000/auth/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(userProfile.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      throw Exception('Failed to update user profile');
    }
  }
}
