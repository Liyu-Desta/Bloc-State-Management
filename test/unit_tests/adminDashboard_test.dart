import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one/presentation/screens/adminDashboard.dart';

void main() {
  group('AdminDashboard Widget Tests', () {
    late MaterialApp app;

    setUp(() {
      app = MaterialApp(
        home: Dashboard(),
      );
    });

    testWidgets('AdminDashboard renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      // Verify that the AdminDashboard title is rendered
      expect(find.text('Admin Dashboard'), findsOneWidget);

      // Verify that the 'Add Opportunity' button is rendered
      expect(find.text('Add Opportunity'), findsOneWidget);
    });

    testWidgets('Adding new opportunity', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      // Tap the 'Add Opportunity' button
      await tester.tap(find.text('Add Opportunity'));
      await tester.pumpAndSettle();

      // Verify that the 'Add Opportunity' dialog is displayed
      expect(find.text('Add Opportunity'), findsOneWidget);

      // Fill in the form and save
      await tester.enterText(find.byKey(ValueKey('titleField')), 'Test Opportunity');
      await tester.enterText(find.byKey(ValueKey('locationField')), 'Test Location');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify that the new opportunity is added to the list
      expect(find.text('Test Opportunity'), findsOneWidget);
      expect(find.text('Test Location'), findsOneWidget);
    });

    testWidgets('Editing an opportunity', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      // Add a new opportunity first
      await tester.tap(find.text('Add Opportunity'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(ValueKey('titleField')), 'Test Opportunity');
      await tester.enterText(find.byKey(ValueKey('locationField')), 'Test Location');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Edit the added opportunity
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(ValueKey('titleField')), 'Edited Opportunity');
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();

      // Verify that the opportunity is updated in the list
      expect(find.text('Edited Opportunity'), findsOneWidget);
      expect(find.text('Test Location'), findsOneWidget); // Check that location remains unchanged
    });

    testWidgets('Deleting an opportunity', (WidgetTester tester) async {
      await tester.pumpWidget(app);

      // Add a new opportunity first
      await tester.tap(find.text('Add Opportunity'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(ValueKey('titleField')), 'Test Opportunity');
      await tester.enterText(find.byKey(ValueKey('locationField')), 'Test Location');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Delete the added opportunity
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Verify that the opportunity is removed from the list
      expect(find.text('Test Opportunity'), findsNothing);
      expect(find.text('Test Location'), findsNothing);
    });
  });
}
