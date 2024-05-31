// admin_profile_event.dart

part of '../../Application/bloc/admin_profile_bloc.dart';

abstract class AdminProfileEvent extends Equatable {
  const AdminProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchAdminProfile extends AdminProfileEvent {}

class UpdateProfilePicture extends AdminProfileEvent {
  final Uint8List profileImageBytes;

  UpdateProfilePicture(this.profileImageBytes);

  @override
  List<Object?> get props => [profileImageBytes];
}

class UpdateAdminName extends AdminProfileEvent {
  final String adminName;

  UpdateAdminName(this.adminName);

  @override
  List<Object?> get props => [adminName];
}

class UpdateEmail extends AdminProfileEvent {
  final String email;

  UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePhoneNumber extends AdminProfileEvent {
  final String phoneNumber;

  UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class SaveAdminProfile extends AdminProfileEvent {
  SaveAdminProfile(AdminProfile updatedProfile);
}

class NavigateToSecuritySettings extends AdminProfileEvent {}

class NavigateToAppSettings extends AdminProfileEvent {}

class ChangePassword extends AdminProfileEvent {
  final String newPassword;

  ChangePassword(this.newPassword);

  @override
  List<Object?> get props => [newPassword];
}
