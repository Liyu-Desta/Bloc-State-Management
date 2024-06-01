import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one/Domain/Repositories/userList_repository.dart';
import 'package:one/Domain/models/userList_model.dart';
import '../../presentation/Events/userList_event.dart';
import '../../presentation/State/userList_state.dart';


class UserListBloc extends Bloc<userListEvent, userListState> {
  final userListRepository userRepository;

  UserListBloc({required this.userRepository}) : super(userListInitial()) {
    on<updateRole>(_mapUpdateRoleToState);
    on<fetchUserList>(_mapFetchUserListToState);
  }

  Future<void> _mapFetchUserListToState(
    fetchUserList event,
    Emitter<userListState> emit,
  ) async {
    emit(userListLoading());
    try {
      final userLists = await userRepository.fetchUserList();
      print(userLists);
      emit(userListSuccess(userLists));
    } catch (e) {
      emit(userListFailure(e.toString()));
    }
  }

  Future<void> _mapUpdateRoleToState(
    updateRole event,
    Emitter<userListState> emit,
  ) async {
    emit(userListLoading());
    try {
      await userRepository.updateRole(event.updatedUser);
      final userLists = await userRepository.fetchUserList();
      emit(userListSuccess(userLists));
    } catch (e) {
      emit(userListFailure(e.toString()));
    }
  }
}
