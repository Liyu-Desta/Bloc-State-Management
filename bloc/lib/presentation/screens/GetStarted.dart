import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'loginPage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent!, Colors.deepPurpleAccent!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 0,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 110.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "VOLUNTEER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "MANAGEMENT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "SYSTEM",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 230, // Adjust the left position of the circle
              top: 0,
              right: 0, // Adjust the right position of the circle
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 300.0), // Add padding to the circle
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/th.jpg'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0, // Adjust the left position of the circle
              top: 0,
              right: 230, // Adjust the right position of the circle
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 300.0), // Add padding to the circle
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/th (2).jpg'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20, // Adjust the left position of the circle
              top: 0,
              right: 20, // Adjust the right position of the circle
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 400.0), // Add padding to the circle
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/th (1).jpg'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0, // Adjust the left position of the circle
              top: 0,
              right: 290, // Adjust the right position of the circle
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 450.0), // Add padding to the circle
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/th (4).jpg'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 300, // Adjust the left position of the circle
              top: 0,
              right: 0, // Adjust the right position of the circle
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 480.0), // Add padding to the circle
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/th (5).jpg'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0, // Adjust the left position of the circle
              top: 0,
              right: 100, // Adjust the right position of the circle
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 560.0), // Add padding to the circle
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/th (3).jpg'),
                  ),
                ),
              ),
            ),
            // Add other Positioned CircleAvatars here...

            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Center(
                child: Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      GoRouter.of(context).pushReplacement('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                      backgroundColor: Colors.purpleAccent,
                    ),
                    child: Text('Get Started'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
