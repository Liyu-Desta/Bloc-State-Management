import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one/Application/bloc/user_profile_bloc.dart';
import 'package:one/Domain/models/userProfile_model.dart';


import 'package:one/presentation/Events/user_profile_event.dart';
import 'package:one/presentation/State/user_profile_state.dart';
import '../widgets/custom_app_bar.dart'; 
import '../widgets/custom_button.dart'; 
 

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => UserProfileBloc(),
      child: UserProfilePage(),
    ),
  ));
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late UserProfileBloc _userProfileBloc;
  late UserProfile _userProfile; // Store user profile locally

  @override
  void initState() {
    super.initState();
    _userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    _userProfile = UserProfile(
      userName: 'Michael',
      email: 'miketherunner@gmail.com',
      phoneNumber: '123-456-7890',
      bio: '',
      location: '',
      interests: '',
      socialMedia: '',
    );
    _userProfileBloc.add(FetchUserProfile()); // Trigger fetch profile on init
  }

  @override
  void dispose() {
    _userProfileBloc.close();
    super.dispose();
  }

  void _updateProfilePicture(Uint8List profileImageBytes) {
    _userProfileBloc.add(UpdateProfilePicture(profileImageBytes));
  }

  void _updateField(String fieldName, String value) {
    switch (fieldName) {
      case 'userName':
        _userProfileBloc.add(UpdateUserName(value));
        break;
      case 'email':
        _userProfileBloc.add(UpdateEmail(value));
        break;
      case 'phoneNumber':
        _userProfileBloc.add(UpdatePhoneNumber(value));
        break;
      case 'bio':
        _userProfileBloc.add(UpdateBio(value));
        break;
      case 'location':
        _userProfileBloc.add(UpdateLocation(value));
        break;
      case 'interests':
        _userProfileBloc.add(UpdateInterests(value));
        break;
      case 'socialMedia':
        _userProfileBloc.add(UpdateSocialMedia(value));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Profile',
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            _userProfile = state.userProfile; // Update local profile state
            return _buildProfileContent();
          } else if (state is UserProfileError) {
            return Center(child: Text('Failed to load profile: ${state.errorMessage}'));
          } else {
            return Center(child: Text('Unknown state occurred.'));
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        text: 'Save',
        onPressed: () {
          _saveUserProfile();
        },
      ),
    );
  }

  Widget _buildProfileContent() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(40),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                GestureDetector(
                  onTap: _updateProfilePicture,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: _userProfile.profileImageBytes != null
                        ? CircleAvatar(
                            backgroundImage:
                                MemoryImage(_userProfile.profileImageBytes!),
                            radius: 60,
                          )
                        : Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 20),
                _buildProfileField(
                  fieldName: 'userName',
                  labelText: 'User Name',
                  initialValue: _userProfile.userName,
                ),
                SizedBox(height: 16.0),
                _buildProfileField(
                  fieldName: 'email',
                  labelText: 'Email',
                  initialValue: _userProfile.email,
                ),
                SizedBox(height: 16.0),
                _buildProfileField(
                  fieldName: 'phoneNumber',
                  labelText: 'Phone Number',
                  initialValue: _userProfile.phoneNumber,
                ),
                SizedBox(height: 20),
                // Divider between profile fields and additional features
                Divider(color: Colors.grey),
                _buildAdditionalProfileFeature(
                  icon: Icons.person,
                  title: 'Bio',
                  subtitle: 'Add a short description about yourself',
                  inputValue: _userProfile.bio,
                  fieldName: 'bio',
                ),

                _buildAdditionalProfileFeature(
                  icon: Icons.location_on,
                  title: 'Location',
                  subtitle: 'Add or update your current location',
                  inputValue: _userProfile.location,
                  fieldName: 'location',
                ),

                _buildAdditionalProfileFeature(
                  icon: Icons.tag,
                  title: 'Interests',
                  subtitle: 'Add or update your interests or hobbies',
                  inputValue: _userProfile.interests,
                  fieldName: 'interests',
                ),

                _buildAdditionalProfileFeature(
                  icon: Icons.link,
                  title: 'Social Media',
                  subtitle: 'Connect your social media profiles',
                  inputValue: _userProfile.socialMedia,
                  fieldName: 'socialMedia',
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileField({
    required String fieldName,
    required String labelText,
    required String initialValue,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: Icon(Icons.edit, color: Colors.purple),
        labelStyle: TextStyle(
          color: Colors.purple,
          fontFamily: 'Roboto',
        ),
      ),
      onChanged: (value) => _updateField(fieldName, value),
    );
  }

  Widget _buildAdditionalProfileFeature({
    required IconData icon,
    required String title,
    required String subtitle,
    required String inputValue,
    required String fieldName,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.purple),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey, // Set subtitle color to grey
              fontFamily: 'Roboto',
            ),
          ),
          onTap: () {
            _showInputDialog(inputValue, (value) {
              _updateField(fieldName, value); // Update field value
            });
          },
        ),
        if (inputValue.isNotEmpty) // Only show input value if not empty
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              inputValue,
              style: TextStyle(
                color: Colors.black, // Set input value color to black
                fontFamily: 'Roboto',
              ),
            ),
          ),
        Divider(color: Colors.grey),
      ],
    );
  }

  void _showInputDialog(String initialValue, Function(String) onSave) {
    String inputValue = initialValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter'),
          content: TextFormField(
            initialValue: initialValue, // Set initial value for editing
            onChanged: (value) => inputValue = value,
            decoration: InputDecoration(
              hintText: 'Enter',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(inputValue); // Save input value
                Navigator.pop(context); // Close dialog
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _saveUserProfile() {
    _userProfileBloc.add(SaveUserProfile(_userProfile));
  }
}
