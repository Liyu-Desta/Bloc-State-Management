import 'package:equatable/equatable.dart';
import '../../Domain/models/userDashboard_model.dart';

abstract class UserDashboardEvent extends Equatable {
  const UserDashboardEvent();

  @override
  List<Object> get props => [];
}

class AddUserOpportunity extends UserDashboardEvent {
  final UserOpportunity userOpportunity;

  const AddUserOpportunity({required this.userOpportunity});

  @override
  List<Object> get props => [userOpportunity];
}

class UpdateUserOpportunity extends UserDashboardEvent {
  final String id;
  final UserOpportunity updatedUserOpportunity;

  const UpdateUserOpportunity({required this.id, required this.updatedUserOpportunity});

  @override
  List<Object> get props => [id, updatedUserOpportunity];
}

class DeleteUserOpportunity extends UserDashboardEvent {
  final String id;

  const DeleteUserOpportunity({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchUserOpportunities extends UserDashboardEvent {
  const FetchUserOpportunities();

  @override
  List<Object> get props => [];
}
