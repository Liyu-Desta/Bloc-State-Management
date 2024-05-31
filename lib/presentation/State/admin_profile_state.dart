// admin_profile_state.dart

part of '../../Application/bloc/admin_profile_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:one/Domain/models/adminProfile_model.dart';

abstract class AdminProfileState extends Equatable {
  const AdminProfileState();

  @override
  List<Object?> get props => [];
}

class AdminProfileInitial extends AdminProfileState {}

class AdminProfileLoading extends AdminProfileState {}

class AdminProfileLoaded extends AdminProfileState {
  final AdminProfile adminProfile;

  AdminProfileLoaded(this.adminProfile);

  @override
  List<Object?> get props => [adminProfile];
}

class AdminProfileError extends AdminProfileState {
  final String errorMessage;

  AdminProfileError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class NavigatedToSecuritySettings extends AdminProfileState {}

class NavigatedToAppSettings extends AdminProfileState {}

class PasswordChanged extends AdminProfileState {}
