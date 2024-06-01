import 'package:equatable/equatable.dart';
import '../../Domain/models/userList_model.dart';

abstract class userListEvent extends Equatable {
  const userListEvent();

  @override
  List<Object> get props => [];
}

class updateRole extends userListEvent {
  final String id;
  final userList updatedUser;

  const updateRole({required this.id, required this.updatedUser});

  @override
  List<Object> get props => [id, updatedUser];
}

class fetchUserList extends userListEvent {
  const fetchUserList();

  @override
  List<Object> get props => [];
}
