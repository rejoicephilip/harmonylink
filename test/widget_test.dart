import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestGreetingWidget extends StatelessWidget {
  const TestGreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('hi harmonylink!'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('TestGreetingWidget shows the text', (WidgetTester tester) async {
    await tester.pumpWidget(const TestGreetingWidget());

    expect(find.text('hi harmonylink!'), findsOneWidget);
  });
}