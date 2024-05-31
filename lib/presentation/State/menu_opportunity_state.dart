import 'package:equatable/equatable.dart';
//import 'package:one/Domain/models/menu_opportunity_model.dart';
import '../../Domain/models/menu_opportunity_model.dart';

abstract class MenuOpportunityState extends Equatable {
  const MenuOpportunityState();

  @override
  List<Object> get props => [];
}

class MenuOpportunityInitial extends MenuOpportunityState {}

class MenuOpportunityLoading extends MenuOpportunityState {}


class MenuOpportunitySuccess extends MenuOpportunityState {
  final List<MenuOpportunity> menuOpportunities;

  const MenuOpportunitySuccess(this.menuOpportunities);

  @override
  List<Object> get props => [menuOpportunities];
}


class MenuOpportunityFailure extends MenuOpportunityState {
  final String error;

  const MenuOpportunityFailure(this.error);

  @override
  List<Object> get props => [error];
}


