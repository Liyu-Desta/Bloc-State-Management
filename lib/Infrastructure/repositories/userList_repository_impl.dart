// userList_repository_impl.dart

import 'package:one/Domain/Repositories/userList_repository.dart';

import '../../Domain/models/userList_model.dart';

import '../../infrastructure/data_providers/userList_api.dart';

class userListRepositoryImpl implements userListRepository {
  @override
  Future<void> updateRole(userList userList) async {
    if (userList.id == null) {
      throw Exception('User ID is required for update');
    }
    await userListApi.updateRole(userList.id, userList);
    print(userList);
  }

  @override
  Future<List<userList>> fetchUserList() async {
    return await userListApi.fetchUserList();
  }
}
