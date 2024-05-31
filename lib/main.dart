import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:one/Application/bloc/loginbloc.dart';
import 'package:one/Application/bloc/menu_opportunity_bloc.dart';
import 'package:one/Domain/Repositories/user_repository.dart';
import 'package:one/Infrastructure/auth_api_service.dart';
import 'package:one/Infrastructure/data_providers/signInDataProvider.dart';
import 'package:one/Infrastructure/repositories/menuOpportunity_repository_impl.dart';
import 'package:one/Infrastructure/user_repository_impl.dart';
import 'package:one/presentation/screens/GetStarted.dart';
import 'package:one/presentation/screens/adminDashboard.dart';
import 'package:one/presentation/screens/loginPage.dart';
import 'package:one/presentation/screens/signup.dart';
import 'package:one/presentation/screens/userDashboard.dart';
import '../../Infrastructure/repositories/adminDashboard_repository_impl.dart';
import '/presentation/Events/adminDashboard_event.dart';
import '/presentation/State/adminDashboard_state.dart';
import '../../Application/bloc/adminDashboard_bloc.dart';


void main(){

  runApp(
      MultiBlocProvider(providers: [
        BlocProvider(create: (context) => AuthBloc(signInDataProvider: SignInDataProvider(UserRepositoryImpl(apiService: AuthApiService()) ))),
        BlocProvider<AdminDashboardBloc>(create: (context) => AdminDashboardBloc(adminDashboardRepository: AdminDashboardRepositoryImpl())),
        BlocProvider<MenuOpportunityBloc>(create: (context) => MenuOpportunityBloc(menuOpportunityRepository: MenuRepositoryImpl())),
       
    
      ], child: MyApp(),)
      
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final _router = GoRouter(routes: [
    GoRoute(path: '/',pageBuilder: (context, state) => MaterialPage(child: Material(child: HomeScreen(),)),),
    GoRoute(path: '/login',pageBuilder: (context,state)=>MaterialPage(child: Material(child: LoginScreen(),))),
    GoRoute(path: '/signup',pageBuilder:((context, state) => MaterialPage(child: Material(child: SignupScreen(),)))),
    GoRoute(path: '/userDashboard',pageBuilder: (context, state) => MaterialPage(child: Material(child: UserDashboard(),)),),
    GoRoute(path:'/dashboard',pageBuilder: (context, state) => MaterialPage(child: Material(child: Dashboard(),)),)
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate:_router.routerDelegate,
    );
  }
}