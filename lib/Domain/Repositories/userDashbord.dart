import '../../Domain/models/userDashboard_model.dart';

abstract class UserDashboardRepository {
  
  Future<void> updateUserOpportunity(UserOpportunity opportunity);
  Future<void> deleteUserOpportunity(String id);
  Future<List<UserOpportunity>> fetchUserOpportunities();
}
