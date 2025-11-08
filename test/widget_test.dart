import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sandwitch_shop/main.dart';

void main() {
  group('App initial state', () {
    testWidgets('shows AppBar title and empty list placeholder',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('(no notes)'), findsOneWidget);
      // No sandwich emoji present when empty
      expect(find.textContaining('sandwich(es):'), findsOneWidget);
    });
  });

  group('Add / Remove flows', () {
    testWidgets('adds an item with a note and clears the note field',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final noteField = find.byType(TextField);
      expect(noteField, findsOneWidget);

      // Enter a note and add
      await tester.enterText(noteField, 'no onions');
      final addButton = find.widgetWithText(ElevatedButton, 'Add');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify summary and item content
      expect(find.text('1 sandwich(es): 🥪'), findsOneWidget);
      expect(find.textContaining('Footlong: no onions'), findsOneWidget);

      // The text field should be cleared after add
      final TextField tf = tester.widget(noteField);
      expect(tf.controller?.text ?? '', isEmpty);
    });

    testWidgets('removes items until empty and disables remove when zero',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final noteField = find.byType(TextField);
      final addButton = find.widgetWithText(ElevatedButton, 'Add');
      final removeButton = find.widgetWithText(ElevatedButton, 'Remove');

      // Add two items
      await tester.enterText(noteField, 'first');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      await tester.enterText(noteField, 'second');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('2 sandwich(es): 🥪🥪'), findsOneWidget);

      // Remove one
      await tester.tap(removeButton);
      await tester.pumpAndSettle();
      expect(find.text('1 sandwich(es): 🥪'), findsOneWidget);

      // Remove last
      await tester.tap(removeButton);
      await tester.pumpAndSettle();
      expect(find.text('(no notes)'), findsOneWidget);

      // Remove button should be disabled (tap has no effect). We check that
      // trying to tap does not cause negative counts or errors.
      await tester.tap(removeButton);
      await tester.pumpAndSettle();
      expect(find.text('(no notes)'), findsOneWidget);
    });
  });

  group('Size selector and max quantity', () {
    testWidgets('changes size using dropdown and reflects in new items',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Open dropdown
      final dropdown = find.byType(DropdownButton<String>);
      expect(dropdown, findsOneWidget);
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select 'Six-inch'
      final sixInch = find.text('Six-inch').last;
      await tester.tap(sixInch);
      await tester.pumpAndSettle();

      // Add an item and check its label
      final noteField = find.byType(TextField);
      final addButton = find.widgetWithText(ElevatedButton, 'Add');
      await tester.enterText(noteField, 'no mayo');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('Six-inch: no mayo'), findsOneWidget);
    });

    testWidgets('respects maxQuantity and disables Add at limit',
        (WidgetTester tester) async {
      // Use an App instance with a small maxQuantity via the widget's ctor.
      await tester
          .pumpWidget(const MaterialApp(home: OrderScreen(maxQuantity: 2)));
      await tester.pumpAndSettle();

      final noteField = find.byType(TextField);
      final addButton = find.widgetWithText(ElevatedButton, 'Add');

      // Add twice (limit)
      await tester.enterText(noteField, 'a');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      await tester.enterText(noteField, 'b');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('2 sandwich(es):'), findsOneWidget);

      // Attempt to add a third time; the button should be disabled (no change)
      await tester.enterText(noteField, 'c');
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Still 2
      expect(find.textContaining('2 sandwich(es):'), findsOneWidget);
    });
  });
}
