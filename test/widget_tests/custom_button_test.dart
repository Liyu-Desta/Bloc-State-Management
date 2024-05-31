import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_package_name/custom_button.dart';

void main() {
  testWidgets('CustomButton displays text and responds to tap', (WidgetTester tester) async {
    // Define the test key.
    const testKey = Key('customButton');

    // Create a variable to track if the button has been pressed.
    bool buttonPressed = false;

    // Build the widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            key: testKey,
            text: 'Press me',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Verify that the button displays the correct text.
    expect(find.text('Press me'), findsOneWidget);

    // Verify the initial state of the buttonPressed variable.
    expect(buttonPressed, isFalse);

    // Tap the button.
    await tester.tap(find.byKey(testKey));

    // Rebuild the widget.
    await tester.pump();

    // Verify the button was pressed.
    expect(buttonPressed, isTrue);
  });
}
