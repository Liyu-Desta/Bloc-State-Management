

import 'package:one/Domain/models/userProfile_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:typed_data';


abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {}

class UpdateProfilePicture extends UserProfileEvent {
  final Uint8List profileImageBytes;

  UpdateProfilePicture(this.profileImageBytes);
}

class UpdateUserName extends UserProfileEvent {
  final String userName;

  UpdateUserName(this.userName);
}

class UpdateEmail extends UserProfileEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdatePhoneNumber extends UserProfileEvent {
  final String phoneNumber;

  UpdatePhoneNumber(this.phoneNumber);
}

class UpdateBio extends UserProfileEvent {
  final String bio;

  UpdateBio(this.bio);
}

class UpdateLocation extends UserProfileEvent {
  final String location;

  UpdateLocation(this.location);
}

class UpdateInterests extends UserProfileEvent {
  final String interests;

  UpdateInterests(this.interests);
}

class UpdateSocialMedia extends UserProfileEvent {
  final String socialMedia;

  UpdateSocialMedia(this.socialMedia);
}