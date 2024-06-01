import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one/presentation/widgets/custom_app_bar.dart'; // Adjust the import according to your project structure

void main() {
  testWidgets('CustomAppBar displays title and responds to leading button press', (WidgetTester tester) async {
    bool leadingPressed = false;

    // Define test data
    const testTitle = 'Test App Bar';

    // Build the CustomAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(
            title: testTitle,
            leadingOnPressed: () {
              leadingPressed = true;
            },
          ),
          body: Center(child: Text('Test Body')),
        ),
      ),
    );

    // Verify the title is displayed
    expect(find.text(testTitle), findsOneWidget);

    // Verify the leading button is displayed
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Tap the leading button and verify the onPressed callback is executed
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();

    expect(leadingPressed, isTrue);
  });

  testWidgets('CustomAppBar pops the navigator when leading button pressed without callback', (WidgetTester tester) async {
    // Define test data
    const testTitle = 'Test App Bar';

    // Build the CustomAppBar widget with no leadingOnPressed callback
    await tester.pumpWidget(
      MaterialApp(
        home: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: CustomAppBar(
                title: testTitle,
              ),
              body: Center(child: Text('Test Body')),
            ),
          ),
        ),
      ),
    );

    // Verify the title is displayed
    expect(find.text(testTitle), findsOneWidget);

    // Verify the leading button is displayed
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Tap the leading button and verify the Navigator pops
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that the navigator popped to the previous route (in this case, it should be empty)
    expect(find.text('Test Body'), findsNothing);
  });
}
