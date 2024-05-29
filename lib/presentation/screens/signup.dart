import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:one/Application/bloc/loginbloc.dart';
import 'package:one/presentation/screens/adminDashboard.dart';
import 'package:one/presentation/screens/loginPage.dart';
import 'package:one/presentation/screens/userDashboard.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
    BlocConsumer<AuthBloc,AuthState>(
      listener: (context, state) {},
      builder:(context,state){
      if (state == AuthEmpty){
          return singUp(context);
      }
      else if(state is SingUpState){
        if(state.user.role == "admin"){
          return Dashboard();
        }
        else{
          return UserDashboard();
        }
      }
      else {
        return singUp(context);
      }
    });
  }

  Scaffold singUp(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Text(
              'Create your account',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 38.0),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller:_emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Add email validation logic here if needed
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller:_phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      }
                      // Add  validation logic here if needed
                      return null;
                    },
                  ),
                ),
            

                SizedBox(height: 16.0),
                Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      // Add password validation logic here if needed
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 28.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // All fields are valid, proceed with sign-up logic
                        String name = _nameController.text;
                        String email = _emailController.text;
                        String phoneNumber = _phoneNumberController.text;
                        String password = _passwordController.text;
                        // // Add sign-up logic here (e.g., API call, database operation)
                        // // Navigate to the next screen or show a success message
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Sign up successful!'),
                        //   ),
                        // );

                        context.read<AuthBloc>().add(
                          SingUpUserAction(email, phoneNumber, password, name)
                        );
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 55.0),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.purpleAccent,
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                ),
                SizedBox(height: 36.0),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );

                    GoRouter.of(context).pushReplacement('/login');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
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
}

