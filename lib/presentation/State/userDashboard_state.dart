import 'package:equatable/equatable.dart';
import '../../Domain/models/userDashboard_model.dart';

abstract class UserDashboardState extends Equatable {
  const UserDashboardState();

  @override
  List<Object?> get props => [];
}

class UserDashboardInitial extends UserDashboardState {}

class UserDashboardLoading extends UserDashboardState {}

class UserDashboardSuccess extends UserDashboardState {
  final List<UserOpportunity> userOpportunities;

  const UserDashboardSuccess(this.userOpportunities);

  @override
  List<Object?> get props => [userOpportunities];
}

class UserDashboardFailure extends UserDashboardState {
  final String error;

  const UserDashboardFailure(this.error);

  @override
  List<Object?> get props => [error];
}
