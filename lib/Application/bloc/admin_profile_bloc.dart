import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:one/Infrastructure/repositories/adminProfile_Repository.dart';
import 'package:one/Domain/models/adminProfile_model.dart';

part '../../presentation/Events/admin_profile_event.dart';
part '../../presentation/State/admin_profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final AdminProfileRepository adminProfileRepository;

  AdminProfileBloc({required this.adminProfileRepository})
      : super(AdminProfileInitial());

  @override
  Stream<AdminProfileState> mapEventToState(
    AdminProfileEvent event,
  ) async* {
    if (event is FetchAdminProfile) {
      yield* _mapFetchAdminProfileToState(event);
    } else if (event is UpdateProfilePicture) {
      yield* _mapUpdateProfilePictureToState(event);
    } else if (event is UpdateAdminName) {
      yield* _mapUpdateAdminNameToState(event);
    } else if (event is UpdateEmail) {
      yield* _mapUpdateEmailToState(event);
    } else if (event is UpdatePhoneNumber) {
      yield* _mapUpdatePhoneNumberToState(event);
    } else if (event is SaveAdminProfile) {
      yield* _mapSaveAdminProfileToState(event);
    } else if (event is NavigateToSecuritySettings) {
      yield NavigatedToSecuritySettings();
    } else if (event is NavigateToAppSettings) {
      yield NavigatedToAppSettings();
    } else if (event is ChangePassword) {
      yield* _mapChangePasswordToState(event);
    }
  }

  Stream<AdminProfileState> _mapFetchAdminProfileToState(
    FetchAdminProfile event,
  ) async* {
    yield AdminProfileLoading();
    try {
      final adminProfile = await adminProfileRepository.fetchAdminProfile();
      yield AdminProfileLoaded(adminProfile);
    } catch (e) {
      yield AdminProfileError('Failed to fetch admin profile: $e');
    }
  }

  Stream<AdminProfileState> _mapUpdateProfilePictureToState(
    UpdateProfilePicture event,
  ) async* {
    yield AdminProfileLoading();
    try {
      await adminProfileRepository.updateProfilePicture(event.profileImageBytes);
      final currentProfileState = state;
      if (currentProfileState is AdminProfileLoaded) {
        final updatedProfile = currentProfileState.adminProfile.copyWith(
          profileImageBytes: event.profileImageBytes,
        );
        yield AdminProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield AdminProfileError('Failed to update profile picture: $e');
    }
  }

  Stream<AdminProfileState> _mapUpdateAdminNameToState(
    UpdateAdminName event,
  ) async* {
    yield AdminProfileLoading();
    try {
      await adminProfileRepository.updateAdminName(event.adminName);
      final currentProfileState = state;
      if (currentProfileState is AdminProfileLoaded) {
        final updatedProfile = currentProfileState.adminProfile.copyWith(
          adminName: event.adminName,
        );
        yield AdminProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield AdminProfileError('Failed to update admin name: $e');
    }
  }

  Stream<AdminProfileState> _mapUpdateEmailToState(
    UpdateEmail event,
  ) async* {
    yield AdminProfileLoading();
    try {
      await adminProfileRepository.updateEmail(event.email);
      final currentProfileState = state;
      if (currentProfileState is AdminProfileLoaded) {
        final updatedProfile = currentProfileState.adminProfile.copyWith(
          email: event.email,
        );
        yield AdminProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield AdminProfileError('Failed to update email: $e');
    }
  }

  Stream<AdminProfileState> _mapUpdatePhoneNumberToState(
    UpdatePhoneNumber event,
  ) async* {
    yield AdminProfileLoading();
    try {
      await adminProfileRepository.updatePhoneNumber(event.phoneNumber);
      final currentProfileState = state;
      if (currentProfileState is AdminProfileLoaded) {
        final updatedProfile = currentProfileState.adminProfile.copyWith(
          phoneNumber: event.phoneNumber,
        );
        yield AdminProfileLoaded(updatedProfile);
      }
    } catch (e) {
      yield AdminProfileError('Failed to update phone number: $e');
    }
  }

  Stream<AdminProfileState> _mapSaveAdminProfileToState(
    SaveAdminProfile event,
  ) async* {
    yield AdminProfileLoading();
    final currentProfileState = state;
    if (currentProfileState is AdminProfileLoaded) {
      try {
        await adminProfileRepository.saveAdminProfile(currentProfileState.adminProfile);
        yield AdminProfileLoaded(currentProfileState.adminProfile);
      } catch (e) {
        yield AdminProfileError('Failed to save admin profile: $e');
      }
    }
  }

  Stream<AdminProfileState> _mapChangePasswordToState(
    ChangePassword event,
  ) async* {
    yield AdminProfileLoading();
    try {
      await adminProfileRepository.changePassword(event.newPassword);
      yield PasswordChanged();
    } catch (e) {
      yield AdminProfileError('Failed to change password: $e');
    }
  }
}
