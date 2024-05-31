import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one/presentation/screens/Profile.dart';

void main() {
  testWidgets('AdminProfilePage has title, profile fields, and additional features', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: AdminProfilePage()));

    // Verify that the title is present.
    expect(find.text('Admin Profile'), findsOneWidget);

    // Verify that profile fields are present.
    expect(find.text('Admin Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);

    // Verify that additional features are present.
    expect(find.text('Security Settings'), findsOneWidget);
    expect(find.text('App Settings'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
  });
}
