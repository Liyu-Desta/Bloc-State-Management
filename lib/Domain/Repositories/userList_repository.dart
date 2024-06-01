import '../models/userList_model.dart';

abstract class userListRepository {
  Future<void> updateRole(userList userList);
  Future<List<userList>> fetchUserList();
}
