import 'package:equatable/equatable.dart';
import 'package:one/Domain/models/userList_model.dart';
import '../../domain/models/opportunities.dart';

abstract class userListState extends Equatable {
  const userListState();

  @override
  List<Object?> get props => [];
}

class userListInitial extends userListState {}

class userListLoading extends userListState {}

class userListSuccess extends userListState {
  final List<userList> userLists;

  const userListSuccess(this.userLists);

  @override
  List<Object?> get props => [userLists];
}

class userListFailure extends userListState {
  final String error;

  const userListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
