import 'package:one/Domain/models/menu_opportunity_model.dart';
//import 'package:one/presentation/Events/menu_opportunity_event.dart';

abstract class MenuOpportunityRepository {
  Future<void> registerOpportunity(MenuOpportunity menuOpportunity);
  Future<List<MenuOpportunity>> fetchOpportunity();
}
