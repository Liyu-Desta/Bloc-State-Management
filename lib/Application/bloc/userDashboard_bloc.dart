import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/Events/userDashboard_event.dart';
import '../../presentation/State/userDashboard_state.dart';
import '../../Domain/Repositories/userDashbord.dart';

class UserDashboardBloc
    extends Bloc<UserDashboardEvent, UserDashboardState> {
  final UserDashboardRepository userDashboardRepository;

  UserDashboardBloc({required this.userDashboardRepository})
      : super(UserDashboardInitial()) {
    
    on<UpdateUserOpportunity>(_mapUpdateUserOpportunityToState);
    on<FetchUserOpportunities>(_mapFetchUserOpportunitiesToState);
    on<DeleteUserOpportunity>(_mapDeleteUserOpportunityToState);
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

  FutureOr<UserDashboardState> _mapFetchUserOpportunitiesToState(
      event, emit) async {
    emit(UserDashboardLoading());
    try {
      final userOpportunities = await userDashboardRepository.fetchUserOpportunities();
      emit(UserDashboardSuccess(userOpportunities));
      return UserDashboardSuccess(userOpportunities); // Explicit return here
    } catch (e) {
      emit(UserDashboardFailure(e.toString()));
      return UserDashboardFailure(e.toString()); // Explicit return here
    }
  }



  FutureOr<UserDashboardState> _mapUpdateUserOpportunityToState(
      event, emit) async {
   
    emit(UserDashboardLoading());
    try {
      await userDashboardRepository
          .updateUserOpportunity(event.updatedUserOpportunity);
      final userOpportunities = await userDashboardRepository.fetchUserOpportunities();
      emit(UserDashboardSuccess(userOpportunities));
      return UserDashboardSuccess(userOpportunities); // Explicit return here
    } catch (e) {
      emit(UserDashboardFailure(e.toString()));
      return UserDashboardFailure(e.toString()); // Explicit return here
    }
  }

  FutureOr<UserDashboardState> _mapDeleteUserOpportunityToState(
      event, emit) async {
    emit(UserDashboardLoading());
    try {
      await userDashboardRepository.deleteUserOpportunity(event.id);
      final userOpportunities = await userDashboardRepository.fetchUserOpportunities();
      emit(UserDashboardSuccess(userOpportunities));
      return UserDashboardSuccess(userOpportunities);
    } catch (e) {
      emit(UserDashboardFailure(e.toString()));
      return UserDashboardFailure(e.toString());
    }
  }
}
