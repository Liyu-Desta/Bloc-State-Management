import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:one/presentation/widgets/custom_alert_dialog.dart';
void main() {
  testWidgets('CustomAlertDialog displays title, content, and actions', (WidgetTester tester) async {
    // Define test data
    const testTitle = 'Test Title';
    const testContent = Text('Test Content');
    const testActions = <Widget>[
      TextButton(
        onPressed: null,
        child: Text('Action 1'),
      ),
      TextButton(
        onPressed: null,
        child: Text('Action 2'),
      ),
    ];

    // Build the CustomAlertDialog widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomAlertDialog(
            title: testTitle,
            content: testContent,
            actions: testActions,
          ),
        ),
      ),
    );

    // Verify the title is displayed
    expect(find.text(testTitle), findsOneWidget);

    // Verify the content is displayed
    expect(find.text('Test Content'), findsOneWidget);

    // Verify the actions are displayed
    expect(find.text('Action 1'), findsOneWidget);
    expect(find.text('Action 2'), findsOneWidget);
  });
}
