// lib/infrastructure/auth_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  final String baseUrl = 'http://localhost:3000/auth';

  Future<Map<String, dynamic>?> signup(String name, String email, String password, String phoneNumber) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map<String,dynamic>> getUserDetail(String token) async{
    final url = Uri.parse('$baseUrl/user');

    final response =await http.get(url,headers: {
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'

    });
    // print(response.statusCode);

    if(response.statusCode ==200){
      return json.decode(response.body);
    }
    print("reached here");
    throw Exception("Error happened");
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      var result = json.decode(response.body);
      return result;
    } else {
      return null;
    }
  }

  getToken() {}
}
