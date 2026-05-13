import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:english_time_travel/main.dart';

void main() {
  testWidgets('App boots to splash', (tester) async {
    await tester.pumpWidget(const EnglishTimeTravelApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
