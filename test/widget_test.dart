// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ecampus_application/main.dart';

void main() {
  testWidgets('Profile displays the supplied photo', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ECampusApp());
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    expect(find.text('Muhammad Abdul Rouf'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CircleAvatar && widget.backgroundImage is AssetImage,
      ),
      findsOneWidget,
    );
  });

  testWidgets('Course schedule shows the courses from the provided image', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ECampusApp());
    await tester.tap(find.text('Jadwal'));
    await tester.pumpAndSettle();

    expect(find.text('Data Mining (1124A)'), findsOneWidget);
    expect(find.text('Game Development Techniques (1124A)'), findsOneWidget);
    expect(find.text('Mobile Programming (1124A)'), findsOneWidget);
    expect(find.text('Teori Graf dan Otomata (1124A)'), findsOneWidget);
    expect(find.text('Pemrograman Web Lanjut (1124A)'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data?.contains('Kehadiran: 8 dari 16 sesi') == true,
      ),
      findsNWidgets(2),
    );
  });
}
