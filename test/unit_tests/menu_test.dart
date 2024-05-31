import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one/presentation/screens/menu.dart';

void main() {
  testWidgets('MenuApp has a title and menu items', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MenuApp());

    // Verify that the title is present.
    expect(find.text('Volunteer Opportunities For You'), findsOneWidget);

    // Verify that the menu items are present.
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });
}
