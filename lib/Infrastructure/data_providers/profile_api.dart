import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Domain/models/profile.dart';
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/repositories/profile_impl.dart';
import 'package:one/Infrastructure/user_repository_impl.dart';

class ProfileApi {
  static const String baseUrl = 'http://localhost:3000';

  static Future<void> updateProfile(String id, Profile profile) async {
    try {
      var profileRepository = UserRepositoryImpl(apiService: AuthApiService());
      var token = await profileRepository.getToken();
      
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<void> deleteProfile(String id) async {
    try {
      var profileRepository = UserRepositoryImpl(apiService: AuthApiService());
      var token = await profileRepository.getToken();
      
      final response = await http.delete(
        Uri.parse('$baseUrl/users/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  static Future<List<Profile>> fetchProfile() async {
    try {
      var profileRepository = UserRepositoryImpl(apiService: AuthApiService());
      var token = await profileRepository.getToken();
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/one'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return [Profile.fromJson(data)];
      } else {
        throw Exception('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }
}
