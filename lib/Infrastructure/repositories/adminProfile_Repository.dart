import 'dart:typed_data';

import 'package:one/Domain/models/adminProfile_model.dart';


abstract class AdminProfileRepository {
  Future<AdminProfile> fetchAdminProfile();
  Future<void> updateProfilePicture(Uint8List profileImageBytes);
  Future<void> updateAdminName(String adminName);
  Future<void> updateEmail(String email);
  Future<void> updatePhoneNumber(String phoneNumber);
  Future<void> changePassword(String newPassword);

  saveAdminProfile(AdminProfile adminProfile) {}
}
