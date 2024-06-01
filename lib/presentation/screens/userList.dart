import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../screens/Profile.dart';
import 'adminDashboard.dart';
import '../widgets/HamburgerMenu.dart';
import '../widgets/logout_dialog.dart';
import '../../Domain/models/userList_model.dart';
import '../../Infrastructure/repositories/userList_repository_impl.dart';
import '/presentation/Events/userList_event.dart';
import '/presentation/State/userList_state.dart';
import '/presentation/screens/loginPage.dart';
import '/presentation/widgets/HamburgerMenu.dart';
import '../widgets/logout_dialog.dart';
import 'package:intl/intl.dart';
import '../../Application/bloc/userList_bloc.dart';

class UserList extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserListBloc(userRepository: userListRepositoryImpl())
            ..add(fetchUserList()),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 166, 70, 183),
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
         drawer: HamburgerMenu(
        onUserListTap: () {
          // print("USERLIST ROUTING");
          context.go('/userList');
        },
        onDashboardTap: () {
          // print("DASHBOARD ROUTING");
          context.go('/dashboard');
        },
        onProfileTap: () {
          // print("PROFILE ROUTING");
          context.go('/profile');
        },
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<UserListBloc, userListState>(
            builder: (context, state) {
              if (state is userListLoading) {
                return CircularProgressIndicator();
              } else if (state is userListSuccess) {
                return _buildUserList(state.userLists, context);
              } else if (state is userListFailure) {
                return Text('Failed to fetch user list: ${state.error}');
              }
              return Container(); // Return an empty container by default
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(List<userList> userList, BuildContext context) {
    return Column(
      children: [
        // User List Table
        Text(
          'Users List',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          // Table container
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTableCell('Email'),
                  _buildTableCell('phoneNumber'),
                  _buildTableCell('Change Role'),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTableCell(user.email),
                      _buildTableCell(user.phoneNumber),
                      DropdownButton<String>(
                        value: user.role,
                        onChanged: (newValue) {
                          // Handle role change
                          print("newValue $newValue");
                          if (newValue != user.role) {
                            final updatedUser =
                                userList[index].copyWith(role: newValue);
                            print("updatedUser ${updatedUser.role}");
                            BlocProvider.of<UserListBloc>(context).add(
                              updateRole(
                                id: updatedUser.id,

                                updatedUser:
                                    updatedUser, // Pass the specific userList object
                              ),
                            );
                          }
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value:
                                "user", // Use a unique value for each item
                            child:
                                Text("user"), // Display the role as the text
                          ),
                          DropdownMenuItem<String>(
                            value:
                                "admin", // Use a unique value for each item
                            child:
                                Text("admin"), // Display the role as the text
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
