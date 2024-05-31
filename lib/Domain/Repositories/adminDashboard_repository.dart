import '../../Domain/models/opportunities.dart';

abstract class AdminDashboardRepository {
  Future<void> addOpportunity(Opportunity opportunity);
  Future<void> updateOpportunity(Opportunity opportunity);
  Future<void> deleteOpportunity(String id);
  Future<List<Opportunity>> fetchOpportunities();
}
