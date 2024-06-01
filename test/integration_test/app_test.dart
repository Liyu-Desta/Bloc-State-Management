import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:go_router/go_router.dart';
import 'package:one/presentation/screens/getStarted.dart'; // Adjust the import according to your file structure

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigate from HomeScreen to LoginPage', (WidgetTester tester) async {
    // Define a mock GoRouter
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Scaffold(body: Text('Login Screen')),
        ),
      ],
    );

    // Build the app with MaterialApp and the defined GoRouter
    await tester.pumpWidget(MaterialApp.router(
      routerConfig: router,
    ));

    // Verify that the HomeScreen is displayed
    expect(find.text('VOLUNTEER'), findsOneWidget); // Adjust this based on your HomeScreen UI check

    // Tap the 'Get Started' button and wait for navigation to complete
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that the LoginPage is displayed
    expect(find.text('Login Screen'), findsOneWidget); // Adjust this based on your LoginPage UI check
  });
}
