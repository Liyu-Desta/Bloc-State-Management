import 'package:http/http.dart' as http;
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/user_repository_impl.dart';
import 'dart:convert';
import '../../Domain/models/menu_opportunity_model.dart';
import 'package:one/Domain/models/opportunities.dart';

class MenuDashboardApi {
  static const String baseUrl = 'http://localhost:3000';

  static Future<String> getUserIdFromToken(String token) async {
    try {
      
      // Trim the token to remove leading and trailing whitespace
      String authToken = token.trim();
      
      // Decode the token
      List<String> parts = authToken.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid token format');
      }
      String payload = parts[1];
      String normalized = base64Url.normalize(payload);
      Map<String, dynamic> decodedToken = json.decode(utf8.decode(base64Url.decode(normalized)));
      

      // Extract and return the user ID
      String userId = decodedToken['sub'];
      
      print("token $token");

      return userId;
    } catch (e) {
      throw Exception('Failed to extract userid from token: $e');
    }
  }

static Future<void> registerOpportunity(MenuOpportunity menuOpportunity) async {
    try {
      var userRepository = UserRepositoryImpl(apiService: AuthApiService());
      var token = await userRepository.getToken();

      if (token == null) {
        throw Exception('Token is null');
      }

      String userId = await getUserIdFromToken(token);
      String opportunityId =menuOpportunity.id;
      final response = await http.post(
        
        Uri.parse('$baseUrl/volunteer-opportunities/$opportunityId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          
        },
        
        body: jsonEncode({'userId': userId,'opportunityId':opportunityId}), // Here userId is passed in the body
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add opportunity');
      }
    } catch (e) {
      print('Exception during registerOpportunity: $e');
      rethrow;
    }
  }

  static Future<List<MenuOpportunity>> fetchOpportunity() async {
    try {
      var userRepository = UserRepositoryImpl(apiService: AuthApiService());
      var token = await userRepository.getToken();

      if (token == null) {
        throw Exception('Token is null');
      }

      // print('Fetching opportunities');
    

      final response = await http.get(
        Uri.parse('$baseUrl/volunteer-opportunities'),
        headers: {'Authorization': 'Bearer $token'},
      );

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      // print('Response headers: ${response.headers}');

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MenuOpportunity.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch opportunities: ${response.body}');
      }
    } catch (e) {
      print('Exception during fetchOpportunity: $e');
      rethrow;
    }
  }








//   static Future<List<MenuOpportunity>> fetchOpportunity() async {
//     try {
//       var userRepository = UserRepositoryImpl(apiService: AuthApiService());
//       var token = await userRepository.getToken();

//       if (token == null) {
//         throw Exception('Token is null');
//       }

//       print('Fetching opportunities');
//       print('Token: $token');

//       final response = await http.get(
//         Uri.parse('$baseUrl/volunteer-opportunities'),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       print('Response headers: ${response.headers}');

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => MenuOpportunity.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to fetch opportunities: ${response.body}');
//       }
//     } catch (e) {
//       print('Exception during fetchOpportunity: $e');
//       rethrow;
//     }
//   }
// }
}