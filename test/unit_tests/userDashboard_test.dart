import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one/presentation/screens/userDashboard.dart';

void main() {
  testWidgets('User dashboard widgets are present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: UserDashboard()));

    // Verify that the app bar title is present.
    expect(find.text('User Dashboard'), findsOneWidget);

    // Verify that the list of booked opportunities is present.
    expect(find.byType(ListTile), findsWidgets);
  });
}
