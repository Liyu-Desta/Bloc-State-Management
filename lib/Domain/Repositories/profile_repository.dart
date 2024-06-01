import '../../Domain/models/profile.dart';

abstract class ProfileRepository {
  Future<void> updateProfile(Profile profile);
  Future<void> deleteProfile(String id);
  Future<List<Profile>> fetchProfile();
}
