import 'package:one/Infrastructure/auth_api_service.dart';

import '../../Domain/models/opportunities.dart';
import '../../Domain/Repositories/adminDashboard_repository.dart';
import '../../Infrastructure/data_providers/adminDashboard_api.dart';
import '../../Domain/models/opportunities.dart';
import '../../Domain/Repositories/adminDashboard_repository.dart';
import '../../Infrastructure/data_providers/adminDashboard_api.dart';

class AdminDashboardRepositoryImpl implements AdminDashboardRepository {

  @override
  Future<void> addOpportunity(Opportunity opportunity) async {
    await AdminDashboardApi.addOpportunity(opportunity);
  }

  @override
  Future<void> updateOpportunity(Opportunity opportunity) async {
    if (opportunity.id == null) {
      throw Exception('Opportunity ID is required for update');
    }
    await AdminDashboardApi.updateOpportunity(opportunity.id!, opportunity);
  }

  @override
  Future<void> deleteOpportunity(String id) async {
    await AdminDashboardApi.deleteOpportunity(id);
  }

  @override
  Future<List<Opportunity>> fetchOpportunities() async {
    return await AdminDashboardApi.fetchOpportunities();
  }
}
