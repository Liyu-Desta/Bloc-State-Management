import 'package:flutter/material.dart';
import '../screens/Profile.dart'; // Import your ProfilePage file
import 'adminDashboard.dart';
import '../widgets/HamburgerMenu.dart'; 
import '../widgets/logout_dialog.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => UserList(),
      '/profile': (context) => AdminProfilePage(),
      '/dashboard': (context) => Dashboard(),
      '/userList': (context) => UserList(),
    },
  ));
}
class UserList extends StatelessWidget {
  final List<String> pages = ['Dashboard', 'User List', 'Profile'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add GlobalKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign GlobalKey to Scaffold
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 166, 70, 183),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Use GlobalKey to access ScaffoldState
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
        onDashboardTap: () {
          Navigator.pushNamed(context, '/dashboard');
        },
        onUserListTap: () {
          Navigator.pushNamed(context, '/userList');
        },
        onProfileTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Users List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTableCell('Name'),
                  _buildTableCell('Email'),
                  _buildTableCell('Password'),
                  _buildTableCell('Change Role'),
                ],
              ),
            ),
          ],
        ),
      ),
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
