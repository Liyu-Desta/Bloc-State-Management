import '../../domain/models/opportunities.dart';
import '../../domain/repositories/adminDashboard_repository.dart';
import '../../infrastructure/data_providers/adminDashboard_api.dart';
import '../../domain/models/opportunities.dart';
import '../../domain/repositories/adminDashboard_repository.dart';
import '../../infrastructure/data_providers/adminDashboard_api.dart';

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
