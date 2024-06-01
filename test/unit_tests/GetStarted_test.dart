import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:one/presentation/screens/getStarted.dart'; // Adjust the import according to your file structure

void main() {
  testWidgets('HomeScreen has Get Started button and navigates to login', (WidgetTester tester) async {
    // Define a mock GoRouter
    final router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(body: Text('Login Screen')),
      ),
    ]);

    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp.router(
      routerConfig: router,
    ));

    // Verify that the 'Get Started' button is present
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the 'Get Started' button and trigger a frame
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that the login screen is displayed
    expect(find.text('Login Screen'), findsOneWidget);
  });
}
