import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:one/presentation/screens/GetStarted.dart';
import 'package:one/presentation/screens/loginPage.dart';
import 'package:one/presentation/screens/signup.dart';
import 'package:one/presentation/screens/userDashboard.dart';
import 'package:one/presentation/screens/adminDashboard.dart';
import 'package:one/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App navigation test', (WidgetTester tester) async {
    app.main(); // Start the app

    await tester.pumpAndSettle(); // Wait for the app to settle

    // Verify that the app starts on the GetStarted screen
    expect(find.byType(GetStarted), findsOneWidget);

    // Navigate to the login screen
    await tester.tap(find.byKey(Key('login_button')));
    await tester.pumpAndSettle();

    // Verify that the app navigates to the login screen
    expect(find.byType(LoginPage), findsOneWidget);

    // Navigate to the signup screen
    await tester.tap(find.byKey(Key('signup_button')));
    await tester.pumpAndSettle();

    // Verify that the app navigates to the signup screen
    expect(find.byType(signup), findsOneWidget);

    // Navigate to the user dashboard screen
    // Example: simulate successful login
    // You might need to mock authentication for a proper test
    // This is just an illustrative example
    await tester.tap(find.byKey(Key('login_button')));
    await tester.pumpAndSettle();
    // Now you're on the user dashboard screen
    expect(find.byType(UserDashboard), findsOneWidget);

    // Navigate to the admin dashboard screen
    // Example: simulate admin access
    // You might need to mock authentication for a proper test
    // This is just an illustrative example
    await tester.tap(find.byKey(Key('dashboard_button')));
    await tester.pumpAndSettle();
    // Now you're on the admin dashboard screen
    expect(find.byType(adminDashboard), findsOneWidget);
  });
}
