import 'package:equatable/equatable.dart';
import 'package:one/Domain/models/menu_opportunity_model.dart';

abstract class MenuOpportunityEvent extends Equatable {
  const MenuOpportunityEvent();

  @override
  List<Object?> get props => [];
}

class RegisterOpportunity extends MenuOpportunityEvent {
  final MenuOpportunity menuOpportunity;

  const RegisterOpportunity({required this.menuOpportunity});

  @override
  List<Object> get props => [menuOpportunity];
}

class FetchOpportunity extends MenuOpportunityEvent {
  const FetchOpportunity();

  @override
  List<Object> get props => [];
}
