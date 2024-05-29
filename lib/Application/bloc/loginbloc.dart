import 'package:bloc/bloc.dart';
import 'package:one/Domain/entities/user.dart';
import 'package:one/Domain/models/user_model.dart';
import 'package:one/Infrastructure/data_providers/signInDataProvider.dart';


abstract class AuthState {
  UserModel user;
  AuthState({required this.user});
}


class AuthEmpty extends AuthState{
  AuthEmpty():super(user:UserModel(email: "",role: "",userId: ""));
}
abstract class AuthAction{
  const AuthAction();
}

class EmptyAction extends AuthAction{}
class LogUserAction extends AuthAction{
  String email;
  String password;

  LogUserAction(this.email,this.password);

  // String get email => this._email;
  // String get password => this._password;
}

class SingUpUserAction extends AuthAction{
  String email;
  String phoneNumber;
  String password;
  String name;

  SingUpUserAction(this.email,this.phoneNumber,this.password,this.name);
}

class SingUpState extends AuthState{
  SingUpState({required super.user});
}
class LoginState extends AuthState {
  LoginState({required super.user});
}

class AuthErrorState extends AuthState{
  String message;

  AuthErrorState({required this.message}):super(user:UserModel(email: "",role: "",userId: ""));
}

class AuthBloc extends Bloc<AuthAction,AuthState>{
  SignInDataProvider signInDataProvider;

  AuthBloc({required this.signInDataProvider}):super(AuthEmpty()){
    on<LogUserAction>((event,emit) async{
      var result = await signInDataProvider.login(event.email, event.password);
      if (result != null){
        emit(LoginState(user: result));
      }else{
         emit(AuthErrorState(message: 'Error occured while sign in'));
      }
    });
    on<SingUpUserAction>((event,emit) async{
      var result = await signInDataProvider.singUp(User(name:event.name,email:event.email,phoneNumber:event.phoneNumber), event.password);

      if (result != null){
        emit(SingUpState(user: result));
      }else{
        emit(AuthErrorState(message: 'Error occured while sign up'));
      }
    });
    on<EmptyAction>((event,emit){
      emit(AuthEmpty());
    });
  }


}