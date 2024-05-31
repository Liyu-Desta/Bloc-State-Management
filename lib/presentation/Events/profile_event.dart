import 'package:equatable/equatable.dart';
import '../../Domain/models/profile.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final String id;
  final Profile updatedProfile;

  const UpdateProfile({required this.id, required this.updatedProfile});

  @override
  List<Object?> get props => [id, updatedProfile];
}

class DeleteProfile extends ProfileEvent {
  final String id;

  const DeleteProfile({required this.id});

  @override
  List<Object?> get props => [id];
}

class FetchProfile extends ProfileEvent {
  const FetchProfile();

  @override
  List<Object?> get props => [];
}
