import 'package:http/http.dart' as http;
import 'package:one/Domain/models/userList_model.dart';
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/user_repository_impl.dart';
import 'package:one/presentation/Events/userList_event.dart';
import 'dart:convert';

class userListApi {
  static const String baseUrl = 'http://localhost:3000';

  static Future<void> updateRole(String id, userList updatedRole) async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    print("userRepository $userRepository");
    var token = await userRepository.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${token!}"
      },
      body: jsonEncode(updatedRole.toJson()),
    );
    print("put response body ${response.body}");
    print(
        "jsonEncode(updatedRole.toJson()) ${jsonEncode(updatedRole.toJson())}");

    if (response.statusCode != 200) {
      throw Exception('Failed to update role');
    }
  }

  static Future<List<userList>> fetchUserList() async {
    var userRepository = UserRepositoryImpl(apiService: AuthApiService());
    var token = await userRepository.getToken();
    final response = await http.get(Uri.parse('$baseUrl/users/All'),
        headers: {"Authorization": "Bearer ${token!}"});

    if (response.statusCode == 200) {
      print("response.body ${response.body}");
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => userList.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch userLists');
    }
  }
}
