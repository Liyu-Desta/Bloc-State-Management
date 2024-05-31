import 'package:equatable/equatable.dart';
import '../../Domain/models/opportunities.dart';

abstract class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object> get props => [];
}

class AddOpportunity extends AdminDashboardEvent {
  final Opportunity opportunity;

  const AddOpportunity({required this.opportunity});

  @override
  List<Object> get props => [opportunity];
}

class UpdateOpportunity extends AdminDashboardEvent {
  final String id;
  final Opportunity updatedOpportunity;

  const UpdateOpportunity({required this.id, required this.updatedOpportunity});

  @override
  List<Object> get props => [id, updatedOpportunity];
}

class DeleteOpportunity extends AdminDashboardEvent {
  final String id;

  const DeleteOpportunity({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchOpportunities extends AdminDashboardEvent {
  const FetchOpportunities();

  @override
  List<Object> get props => [];
}
