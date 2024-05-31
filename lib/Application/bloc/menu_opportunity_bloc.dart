import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:one/Infrastructure/repositories/adminDashboard_repository_impl.dart';
import '../../presentation/Events/menu_opportunity_event.dart';
import '../../presentation/State/menu_opportunity_state.dart';
import '../../Domain/Repositories/menuOpportunity_Repository.dart';

// class AdminDashboardBloc
//     extends Bloc<AdminDashboardEvent, AdminDashboardState> {
//   final AdminDashboardRepository adminDashboardRepository;

//   AdminDashboardBloc({required this.adminDashboardRepository})
//       : super(AdminDashboardInitial()) {
//     on<AddOpportunity>(_mapAddOpportunityToState);
//     on<UpdateOpportunity>(_mapUpdateOpportunityToState);
//     on<FetchOpportunities>(_mapFetchOpportunitiesToState);
//     on<DeleteOpportunity>(_mapDeleteOpportunityToState);
//   }
class MenuOpportunityBloc
    extends Bloc<MenuOpportunityEvent, MenuOpportunityState> {
  final MenuOpportunityRepository menuOpportunityRepository;

  MenuOpportunityBloc({required this.menuOpportunityRepository})
      : super(MenuOpportunityInitial()) {
    on<RegisterOpportunity>(_mapregisterOpportunityToState);
    
    on<FetchOpportunity>(_mapFetchOpportunitiesToState);
    
  }

  // @override
  // Stream<AdminDashboardState> mapEventToState(
  //     AdminDashboardEvent event) async* {
  //   if (event is FetchOpportunities) {
  //     yield* _mapFetchOpportunitiesToState();
  //   } else if (event is AddOpportunity) {
  //     yield* _mapAddOpportunityToState(event);
  //   } else if (event is UpdateOpportunity) {
  //     yield* _mapUpdateOpportunityToState(event);
  //   } else if (event is DeleteOpportunity) {
  //     yield* _mapDeleteOpportunityToState(event);
  //   }
  // }

  FutureOr<MenuOpportunityState> _mapFetchOpportunitiesToState(
      event, emit) async {
    emit(MenuOpportunityLoading());
    try {
      final menuOpportunities = await menuOpportunityRepository.fetchOpportunity();
      emit(MenuOpportunitySuccess(menuOpportunities));
      return MenuOpportunitySuccess(menuOpportunities); // Explicit return here
    } catch (e) {
      emit(MenuOpportunityFailure(e.toString()));
      return MenuOpportunityFailure(e.toString()); // Explicit return here
    }
  }

  FutureOr<void> _mapregisterOpportunityToState(event, emit) async {
    emit(MenuOpportunityLoading());
    try {
      await menuOpportunityRepository.registerOpportunity(event.menuOpportunity);
      print("done adding opportunity to the backend");
      final menuOpportunities = await menuOpportunityRepository.fetchOpportunity();
      emit(MenuOpportunitySuccess(menuOpportunities));
    } catch (e) {
      emit(MenuOpportunityFailure(e.toString()));
    }
  }

  

  
}
