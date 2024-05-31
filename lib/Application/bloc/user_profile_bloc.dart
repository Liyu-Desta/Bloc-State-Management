import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one/Infrastructure/repositories/userProfile_Repository.dart';
import 'package:one/Domain/models/userProfile_model.dart';
import 'package:one/presentation/Events/user_profile_event.dart';
import 'package:one/presentation/State/user_profile_state.dart';




class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository _repository;

  UserProfileBloc(this._repository) : super(UserProfileLoading());

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is FetchUserProfile) {
      yield* _mapFetchUserProfileToState();
    } else if (event is UpdateProfilePicture) {
      yield* _mapUpdateProfilePictureToState(event.profileImageBytes);
    } else if (event is UpdateUserName) {
      yield* _mapUpdateUserNameToState(event.userName);
    } else if (event is UpdateEmail) {
      yield* _mapUpdateEmailToState(event.email);
    } else if (event is UpdatePhoneNumber) {
      yield* _mapUpdatePhoneNumberToState(event.phoneNumber);
    } else if (event is UpdateBio) {
      yield* _mapUpdateBioToState(event.bio);
    } else if (event is UpdateLocation) {
      yield* _mapUpdateLocationToState(event.location);
    } else if (event is UpdateInterests) {
      yield* _mapUpdateInterestsToState(event.interests);
    } else if (event is UpdateSocialMedia) {
      yield* _mapUpdateSocialMediaToState(event.socialMedia);
    }
  }

  Stream<UserProfileState> _mapFetchUserProfileToState() async* {
    try {
      final userProfile = await _repository.fetchUserProfile();
      yield UserProfileLoaded(userProfile);
    } catch (e) {
      yield UserProfileError('Failed to fetch user profile: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateProfilePictureToState(Uint8List profileImageBytes) async* {
    try {
      await _repository.updateUserProfilePicture(profileImageBytes);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(profileImageBytes: profileImageBytes);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update profile picture: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateUserNameToState(String userName) async* {
    try {
      await _repository.updateUserName(userName);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(userName: userName);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update user name: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateEmailToState(String email) async* {
    try {
      await _repository.updateEmail(email);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(email: email);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update email: $e');
    }
  }

  Stream<UserProfileState> _mapUpdatePhoneNumberToState(String phoneNumber) async* {
    try {
      await _repository.updatePhoneNumber(phoneNumber);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(phoneNumber: phoneNumber);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update phone number: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateBioToState(String bio) async* {
    try {
      await _repository.updateBio(bio);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(bio: bio);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update bio: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateLocationToState(String location) async* {
    try {
      await _repository.updateLocation(location);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(location: location);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update location: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateInterestsToState(String interests) async* {
    try {
      await _repository.updateInterests(interests);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(interests: interests);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update interests: $e');
    }
  }

  Stream<UserProfileState> _mapUpdateSocialMediaToState(String socialMedia) async* {
    try {
      await _repository.updateSocialMedia(socialMedia);
      final currentState = state;
      if (currentState is UserProfileLoaded) {
        final updatedProfile = currentState.userProfile.copyWith(socialMedia: socialMedia);
        yield UserProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield UserProfileError('Failed to update social media: $e');
    }
  }
}
