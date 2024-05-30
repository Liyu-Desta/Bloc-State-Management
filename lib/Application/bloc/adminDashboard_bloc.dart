import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/Events/adminDashboard_event.dart';
import '../../presentation/State/adminDashboard_state.dart';
import '../../domain/repositories/adminDashboard_repository.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final AdminDashboardRepository adminDashboardRepository;

  AdminDashboardBloc({required this.adminDashboardRepository})
      : super(AdminDashboardInitial()) {
    on<AddOpportunity>(_mapAddOpportunityToState);
    on<UpdateOpportunity>(_mapUpdateOpportunityToState);
    on<FetchOpportunities>(_mapFetchOpportunitiesToState);
    on<DeleteOpportunity>(_mapDeleteOpportunityToState);
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

  FutureOr<AdminDashboardState> _mapFetchOpportunitiesToState(
      event, emit) async {
    emit(AdminDashboardLoading());
    try {
      final opportunities = await adminDashboardRepository.fetchOpportunities();
      print(opportunities);
      emit(AdminDashboardSuccess(opportunities));
      return AdminDashboardSuccess(opportunities); // Explicit return here
    } catch (e) {
      emit(AdminDashboardFailure(e.toString()));
      return AdminDashboardFailure(e.toString()); // Explicit return here
    }
  }

  FutureOr<void> _mapAddOpportunityToState(event, emit) async {
    emit(AdminDashboardLoading());
    try {
      await adminDashboardRepository.addOpportunity(event.opportunity);
      print("done adding opportunity to the backend");
      final opportunities = await adminDashboardRepository.fetchOpportunities();
      emit(AdminDashboardSuccess(opportunities));
    } catch (e) {
      emit(AdminDashboardFailure(e.toString()));
    }
  }

  FutureOr<AdminDashboardState> _mapUpdateOpportunityToState(
      event, emit) async {
   
    emit(AdminDashboardLoading());
    try {
      await adminDashboardRepository
          .updateOpportunity(event.updatedOpportunity);
      final opportunities = await adminDashboardRepository.fetchOpportunities();
      emit(AdminDashboardSuccess(opportunities));
      return AdminDashboardSuccess(opportunities); // Explicit return here
    } catch (e) {
      emit(AdminDashboardFailure(e.toString()));
      return AdminDashboardFailure(e.toString()); // Explicit return here
    }
  }

  FutureOr<AdminDashboardState> _mapDeleteOpportunityToState(
      event, emit) async {
    emit(AdminDashboardLoading());
    try {
      await adminDashboardRepository.deleteOpportunity(event.id);
      final opportunities = await adminDashboardRepository.fetchOpportunities();
      emit(AdminDashboardSuccess(opportunities));
      return AdminDashboardSuccess(opportunities);
    } catch (e) {
      emit(AdminDashboardFailure(e.toString()));
      return AdminDashboardFailure(e.toString());
    }
  }
}
