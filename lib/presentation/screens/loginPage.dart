import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:one/Application/bloc/loginbloc.dart';
import 'package:one/presentation/screens/adminDashboard.dart';
import 'package:one/presentation/screens/menu.dart';
import 'package:one/presentation/screens/signup.dart';
import 'package:one/presentation/screens/userDashboard.dart';
import 'package:one/presentation/screens/userProfile.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
    BlocConsumer<AuthBloc,AuthState>(
      listener: (context, state) {
        
      },
      builder:(context,state){
      if (state == AuthEmpty){
      return login(context);}
     else if(state is LoginState){
      if(state.user.role == "admin"){
        return Dashboard();
      }else{
        return Menu();
      }
     }else{
      return login(context);
     }
  });
  }

  Scaffold login(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'Fill your credentials to log in',
            style: TextStyle(
              fontSize: 15.0,

            ),
          ),
          SizedBox(height: 54.0), // Adding space between welcome message and form
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.purple[50],
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.purple[50],
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform login logic here
                      print('Email: ${_emailController.text}');
                      print('Password: ${_passwordController.text}');
                      context.read<AuthBloc>().add(
                        LogUserAction(_emailController.text, _passwordController.text)
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 55.0),
                    backgroundColor: Colors.purpleAccent,
                  ),
                  child: Text('Login'),
                  
                ),
                SizedBox(height: 36.0),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushReplacement('/signup');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  } 


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
