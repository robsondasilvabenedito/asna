// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:asna/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:asna/main.dart';

void main() {
  testWidgets("Test", (WidgetTester tester) async {
    // Build App()
    await tester.pumpWidget(const App());

    // Home view
    expect(find.text("ASNA"), findsOneWidget);
    expect(find.text("Type here..."), findsNothing);
  });
}
