import 'package:flutter_test/flutter_test.dart';
import 'package:one/Domain/models/userList_model.dart';

void main() {
  group('userList model tests', () {
    final Map<String, dynamic> userJson = {
      '_id': '123',
      'email': 'test@example.com',
      'phoneNumber': '1234567890',
      'roles': ['user']
    };

    final user = userList(
      id: '123',
      email: 'test@example.com',
      phoneNumber: '1234567890',
      role: 'user',
    );

    test('fromJson should return a valid userList object', () {
      final result = userList.fromJson(userJson);
      expect(result.id, user.id);
      expect(result.email, user.email);
      expect(result.phoneNumber, user.phoneNumber);
      expect(result.role, user.role);
    });

    test('toJson should return a valid JSON map', () {
      final result = user.toJson();
      expect(result['email'], userJson['email']);
      expect(result['phoneNumber'], userJson['phoneNumber']);
      expect(result['role'], user.role);
    });

    test('copyWith should return a valid copy with updated fields', () {
      final updatedUser = user.copyWith(email: 'new@example.com', role: 'admin');
      expect(updatedUser.id, user.id);
      expect(updatedUser.email, 'new@example.com');
      expect(updatedUser.phoneNumber, user.phoneNumber);
      expect(updatedUser.role, 'admin');
    });
  });
}
