import 'package:http/http.dart' as http;
import 'package:one/Infrastructure/user_repository_impl.dart';
import 'dart:convert';
import '../../Domain/models/userDashboard_model.dart';
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/repositories/userDashbord_repository_impl.dart';

class UserdashboardApi {
  static const String baseUrl = 'http://localhost:3000';

  static Future<void> updateUserOpportunity(String id, UserOpportunity userOpportunity) async {
    print("here");
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/volunteer-opportunities/bookings/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(BookModel(userId: userOpportunity.userId, opportunityId:userOpportunity.opportunityId.id, selectedDate: userOpportunity.selectedDate).toJson())
    );
    print(response.statusCode);

    if (response.statusCode != 200) {
      throw Exception('Failed to update opportunity');
    }
  }

  static Future<void> deleteUserOpportunity(String id) async {
    var userDashboardRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userDashboardRepository.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/volunteer-opportunities/bookings/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete opportunity');
    }
  }
  static Future<List<UserOpportunity>> fetchUserOpportunities() async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    print('Token: $token');
    
    final url = '$baseUrl/volunteer-opportunities/my-bookings';
    print('Request URL: $url');
    
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('Authorization Header: ${'Bearer $token'}');
    
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      for (var d in data){
        print('${d["id"]}');

      }
      
      // print(data);
      
      return data.map((json) => UserOpportunity.fromJson(json)).toList();
    }
      
     else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch opportunities');
    }
 }

}


class BookModel {
  final String userId;
  final String opportunityId;
  final DateTime? selectedDate;

  const BookModel({required this.userId,required this.opportunityId,required this.selectedDate});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'opportunityId': opportunityId,
      'selectedDate':selectedDate==null?null:selectedDate!.toIso8601String()
    };
  }
}