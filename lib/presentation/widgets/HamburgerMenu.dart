import 'package:flutter/material.dart';
import '../widgets/logout_dialog.dart';

class HamburgerMenu extends StatelessWidget {
  final VoidCallback onDashboardTap;
  final VoidCallback onUserListTap; // Add callback for UserList
  final VoidCallback onProfileTap;

  const HamburgerMenu({
    Key? key,
    required this.onDashboardTap,
    required this.onUserListTap, // Update constructor
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 166, 70, 183),
            ),
            accountName: Text(
              'Ankelba',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            accountEmail: Text(
              '', // Replace with the actual email address or placeholder text
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/logo.png',
                height: 36,
                width: 36,
              ),
            ),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: onDashboardTap,
          ),
          ListTile(
            title: Text('User List'), // Add User List option
            onTap: onUserListTap,
          ),
          ListTile(
            title: Text('Profile'),
            onTap: onProfileTap,
          ),
           ListTile(
              title: Text('Logout'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
        ],
      ),
    );
  }
  
void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutDialog(); // Display the LogoutDialog
    },
  );
}

}
