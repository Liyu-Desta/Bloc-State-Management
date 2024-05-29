
// import 'package:one/Domain/entities/user.dart';
import 'package:one/Domain/models/user_model.dart';
import 'package:one/Infrastructure/user_repository_impl.dart';

import '../../Domain/entities/user.dart';


class SignInDataProvider {
  UserRepositoryImpl _userRepository;

  SignInDataProvider(this._userRepository);


  Future<UserModel?> singUp(User user,String password){
    return _userRepository.signup(user , password);
  }

  Future<UserModel?> login(String email, String password){
    return _userRepository.login(email, password);
  }

}