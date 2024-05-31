import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one/presentation/widgets/logout_dialog.dart';

import 'package:one/presentation/widgets/HamburgerMenu.dart';

void main() {
  testWidgets('HamburgerMenu triggers the correct callbacks on tap', (WidgetTester tester) async {
    // Define keys for the ListTiles.
    const dashboardKey = Key('dashboardTile');
    const userListKey = Key('userListTile');
    const profileKey = Key('profileTile');
    const logoutKey = Key('logoutTile');

    // Track if callbacks are called.
    bool dashboardTapped = false;
    bool userListTapped = false;
    bool profileTapped = false;

    // Build the widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          drawer: HamburgerMenu(
            onDashboardTap: () {
              dashboardTapped = true;
            },
            onUserListTap: () {
              userListTapped = true;
            },
            onProfileTap: () {
              profileTapped = true;
            },
          ),
        ),
      ),
    );

    // Open the drawer.
    await tester.tap(find.byType(Scaffold));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // Add some delay to animate the drawer opening

    // Tap the Dashboard tile.
    await tester.tap(find.text('Dashboard'));
    await tester.pump();
    expect(dashboardTapped, isTrue);

    // Tap the User List tile.
    await tester.tap(find.text('User List'));
    await tester.pump();
    expect(userListTapped, isTrue);

    // Tap the Profile tile.
    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(profileTapped, isTrue);
  });

  testWidgets('HamburgerMenu shows logout confirmation dialog on Logout tap', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          drawer: HamburgerMenu(
            onDashboardTap: () {},
            onUserListTap: () {},
            onProfileTap: () {},
          ),
        ),
      ),
    );

    // Open the drawer.
    await tester.tap(find.byType(Scaffold));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // Add some delay to animate the drawer opening

    // Tap the Logout tile.
    await tester.tap(find.text('Logout'));
    await tester.pump();

    // Verify that the LogoutDialog is displayed.
    expect(find.byType(LogoutDialog), findsOneWidget);
  });
}
