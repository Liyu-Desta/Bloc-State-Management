import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/Events/profile_event.dart';
import '../../presentation/State/profile_state.dart';
import '../../Domain/Repositories/profile_repository.dart';

class ProfileBloc
    extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository})
      : super(ProfileInitial()) {
    on<UpdateProfile>(_mapUpdateProfileToState);
    on<FetchProfile>(_mapFetchProfileToState);
    on<DeleteProfile>(_mapDeleteProfileToState);
  }

  

  FutureOr<ProfileState> _mapFetchProfileToState(
      event, emit) async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepository.fetchProfile();
      emit(ProfileSuccess(profile));
      return ProfileSuccess(profile); // Explicit return here
    } catch (e) {
      emit(ProfileFailure(e.toString()));
      return ProfileFailure(e.toString()); // Explicit return here
    }
  }

 
  FutureOr<ProfileState> _mapUpdateProfileToState(
      event, emit) async {
   
    emit(ProfileLoading());
    try {
      await profileRepository
          .updateProfile(event.updatedProfile);
      final profile = await profileRepository.fetchProfile();
      emit(ProfileSuccess(profile));
      return ProfileSuccess(profile); // Explicit return here
    } catch (e) {
      emit(ProfileFailure(e.toString()));
      return ProfileFailure(e.toString()); // Explicit return here
    }
  }

  FutureOr<ProfileState> _mapDeleteProfileToState(
      event, emit) async {
    emit(ProfileLoading());
    try {
      await profileRepository.deleteProfile(event.id);
      final profile = await profileRepository.fetchProfile();
      emit(ProfileSuccess(profile));
      return ProfileSuccess(profile);
    } catch (e) {
      emit(ProfileFailure(e.toString()));
      return ProfileFailure(e.toString());
    }
  }
}
