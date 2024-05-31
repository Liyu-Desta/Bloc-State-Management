import 'package:http/http.dart' as http;
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/user_repository_impl.dart';
import 'dart:convert';
import '../../Domain/models/opportunities.dart';

class AdminDashboardApi {
  static const String baseUrl = 'http://localhost:3000';

  static Future<void> addOpportunity(Opportunity opportunity) async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    final response = await http.post(
      Uri.parse(
          '$baseUrl/volunteer-opportunities'), // Sending POST request to base path /volunteer-opportunities
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${token!}"
      },
      body: jsonEncode(opportunity.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add opportunity');
    }
  }

  static Future<void> updateOpportunity(
      String id, Opportunity opportunity) async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/volunteer-opportunities/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${token!}"
      },
      body: jsonEncode(opportunity.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update opportunity');
    }
  }

  static Future<void> deleteOpportunity(String id) async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/volunteer-opportunities/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${token!}"
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete opportunity');
    }
  }

  static Future<List<Opportunity>> fetchOpportunities() async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    final response = await http.get(
        Uri.parse('$baseUrl/volunteer-opportunities'),
        headers: {"Authorization": "Bearer ${token!}"});

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Opportunity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch opportunities');
    }
  }
}
