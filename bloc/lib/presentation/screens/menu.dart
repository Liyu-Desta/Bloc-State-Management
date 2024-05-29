import 'package:flutter/material.dart';
import './userProfile.dart';
import 'userDashboard.dart';
import '../screens/LoginPage.dart'; // Import the new login screen widget

import '../widgets/logout_dialog.dart'; // Import the new hamburger menu widget

void main() => runApp(const MenuApp());

class MenuApp extends StatelessWidget {
  const MenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Menu(),
      routes: {
        '/userProfile': (context) => UserProfilePage(),
        '/userDashboard': (context) => UserDashboard(),
        '/loginpage': (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => LoginScreen());
        }
        // Handle other routes here if needed
      },
    );
  }
}


class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 166, 70, 183),
        title: const Text('Volunteer Opportunities For You'),
      ),
      drawer: Drawer(
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
              accountEmail: null, // You can remove this line if not needed
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/logo.png', // Replace 'assets/logo.png' with your logo image path
                  height: 36,
                  width: 36,
                ),
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/userDashboard');
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/userProfile');
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MenuList(),
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

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4, // Change this to the number of menu items
      itemBuilder: (BuildContext context, int index) {
        return buildMenuItem(context, index);
      },
    );
  }
}

  Widget buildMenuItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return buildMenuItemWidget(
          context,
          'Volunteers',
          'Description of the volunteers',
          'assets/images/1587124484014.jpeg',
          'April 05, 2024 morning',
        );
      case 1:
        return buildMenuItemWidget(
          context,
          'Green Organization',
          'Planting and environment cleaning',
          'assets/images/volunteer3.jpeg',
          'April 05, 2024 morning',
        );
      case 2:
        return buildMenuItemWidget(
          context,
          'NCA',
          'Teaching how to code for elementary students',
          'assets/images/volunteer3.jpeg',
          'Saturday and Sunday',
        );
      case 3:
        return buildMenuItemWidget(
          context,
          'Minilik Hospital',
          'Providing services for patients',
          'assets/images/1587124484014.jpeg',
          'Monday and Friday',
        );
      default:
        return Container();
    }
  }

  Widget buildMenuItemWidget(
    BuildContext context,
    String title,
    String description,
    String imagePath,
    String date,
  ) {
    return GestureDetector(
      onTap: () {
        _showDetailsDialog(context, title, description, imagePath, date);
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 100.0,
                width: 100.0,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showDetailsDialog(
    BuildContext context,
    String title,
    String description,
    String imagePath,
    String date,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(imagePath),
              SizedBox(height: 16),
              Text(
                description,
                style: TextStyle(fontSize: 18),
              ),
              Text(date),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Book"),
              ),
            ],
          ),
        );
      },
    );
  }
