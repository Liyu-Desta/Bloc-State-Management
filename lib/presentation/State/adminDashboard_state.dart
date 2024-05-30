import 'package:equatable/equatable.dart';
import '../../domain/models/opportunities.dart';

abstract class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object?> get props => [];
}

class AdminDashboardInitial extends AdminDashboardState {}

class AdminDashboardLoading extends AdminDashboardState {}

class AdminDashboardSuccess extends AdminDashboardState {
  final List<Opportunity> opportunities;

  const AdminDashboardSuccess(this.opportunities);

  @override
  List<Object?> get props => [opportunities];
}

class AdminDashboardFailure extends AdminDashboardState {
  final String error;

  const AdminDashboardFailure(this.error);

  @override
  List<Object?> get props => [error];
}
