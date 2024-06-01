import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:one/presentation/State/profile_state.dart';
import 'package:one/presentation/screens/GetStarted.dart';
import 'package:one/presentation/screens/loginPage.dart';

import '../../Application/bloc/profile_bloc.dart';
import '../../Domain/models/profile.dart';
import '../Events/profile_event.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_alert_dialog.dart';
 // Import your login screen here

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late ProfileBloc _profileBloc;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(FetchProfile()); // Fetch the profile data on page load

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _profileBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Profile'),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileSuccess) {
            final List<Profile> profiles = state.profile; // Assuming it returns List<Profile>
            if (profiles.isEmpty) {
              return Center(child: Text('No profile data available'));
            } else {
              // Display the first profile in the list (assuming there's only one)
              final Profile profile = profiles.first;

              // Update text controllers with profile data
              _emailController.text = profile.email;
              _passwordController.text = profile.password;
              _phoneNumberController.text = profile.phoneNumber;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/logo.png'),
                    ),
                    SizedBox(height: 20),
                    _buildEditableProfileField('Email', _emailController),
                    SizedBox(height: 16.0),
                    _buildEditableProfileField('Password', _passwordController, obscureText: true),
                    SizedBox(height: 16.0),
                    _buildEditableProfileField('Phone Number', _phoneNumberController),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Save',
                      onPressed: () {
                        _showConfirmationDialog(profile.id);
                      },
                    ),
                    SizedBox(height: 8.0),
                    CustomButton(
                      text: 'Delete Account',
                      onPressed: () {
                        _showDeleteConfirmationDialog(profile.id);
                      },
                    ),
                  ],
                ),
              );
            }
          } else if (state is ProfileFailure) {
            return Center(child: Text('Failed to load profile: ${state.error}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildEditableProfileField(String label, TextEditingController controller, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  void _showConfirmationDialog(String profileId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Confirm Changes',
          content: Text('Are you sure you want to save changes?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateProfile(profileId);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _updateProfile(String profileId) {
    final updatedProfile = Profile(
      id: profileId,
      email: _emailController.text,
      password: _passwordController.text,
      phoneNumber: _phoneNumberController.text,
    );
    _profileBloc.add(UpdateProfile(id: profileId, updatedProfile: updatedProfile));
  }

  void _showDeleteConfirmationDialog(String profileId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Confirm Delete Account',
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteProfile(profileId, () {
                GoRouter.of(context).pushReplacement("/login");
              });
              setState(() {
                
              });
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}



 void _deleteProfile(String profileId, VoidCallback callback) {
  _profileBloc.add(DeleteProfile(id: profileId));

  // Close any dialogs or modals before navigating away
  Navigator.of(context).pop();

  // Call the callback to navigate to LoginScreen after deletion
  callback();
}




}
