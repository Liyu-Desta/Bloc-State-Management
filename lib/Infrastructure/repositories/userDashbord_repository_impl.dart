//import '../../Domain/models/userDashboard_model.dart';
import 'package:one/Infrastructure/auth_api_service.dart';

import '../../Domain/Repositories/userDashbord.dart';
import '../../Infrastructure/data_providers/userDashboard_api.dart';
import '../../Domain/models/userDashboard_model.dart';
//import '../../Domain/Repositories/userDashbord.dart';


class UserDashboardRepositoryImpl implements UserDashboardRepository {

  

  @override
  Future<void> updateUserOpportunity(UserOpportunity userOpportunity) async {
    if (userOpportunity.id == null) {
      throw Exception('Opportunity ID is required for update');
    }
    await UserdashboardApi.updateUserOpportunity(userOpportunity.id!, userOpportunity);
  }

  @override
  Future<void> deleteUserOpportunity(String id) async {
    await UserdashboardApi.deleteUserOpportunity(id);
  }

  @override
  Future<List<UserOpportunity>> fetchUserOpportunities() async {
    return await UserdashboardApi.fetchUserOpportunities();
  }
}
