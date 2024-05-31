import 'package:one/Infrastructure/auth_api_service.dart';

import '../../Domain/models/profile.dart';
import '../../Domain/Repositories/profile_repository.dart';
import '../../Infrastructure/data_providers/profile_api.dart';


class ProfileRepositoryImpl implements ProfileRepository {


  @override
  Future<void> updateProfile(Profile profile) async {
    if (profile.id == null) {
      throw Exception('Pofile ID is required for update');
    }
    await ProfileApi.updateProfile(profile.id!, profile);
  }

  @override
  Future<void> deleteProfile(String id) async {
    await ProfileApi.deleteProfile(id);
  }

  @override
  Future<List<Profile>> fetchProfile() async {
    return await ProfileApi.fetchProfile();
  }
}
