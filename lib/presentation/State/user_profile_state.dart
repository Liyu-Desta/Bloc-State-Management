import 'package:one/Domain/models/userProfile_model.dart'; // Adjust import path as per your project

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile userProfile;

  UserProfileLoaded(this.userProfile);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileLoaded &&
          runtimeType == other.runtimeType &&
          userProfile == other.userProfile;

  @override
  int get hashCode => userProfile.hashCode;
}

class UserProfileError extends UserProfileState {
  final String errorMessage;

  UserProfileError(this.errorMessage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileError &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => errorMessage.hashCode;
}
