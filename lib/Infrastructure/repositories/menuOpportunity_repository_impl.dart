//import '../../domain/models/menu_opportunity_model.dart';
//import '../../Domain/Repositories/adminDashboard_repository.dart';
import 'dart:convert';

import '../../Infrastructure/data_providers/menu_opportunity_api.dart';
//import '../../Domain/models/menu_opportunity_model.dart';
import '../../Domain/Repositories/menuOpportunity_Repository.dart';
//import '../../Infrastructure/data_providers/menu_opportunity_api.dart';
import 'package:one/Domain/models/menu_opportunity_model.dart';


class MenuRepositoryImpl implements MenuOpportunityRepository {
  
  @override
  Future<void> registerOpportunity(MenuOpportunity menuOpportunity) async {
    try {
      // Here you can pass the MenuOpportunity object directly to the registerOpportunity method
      await MenuDashboardApi.registerOpportunity(menuOpportunity);
    } catch (e) {
      // Handle exceptions
      print('Error registering opportunity: $e');
      throw e;
    }
  }

  @override
  Future<List<MenuOpportunity>> fetchOpportunity() async {
    return await MenuDashboardApi.fetchOpportunity();
  }
}
