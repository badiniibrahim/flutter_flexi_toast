import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flexi_toast/toast_manager.dart';

void main() {
  testWidgets('ToastManager inserts toast into overlay', (tester) async {
    // Build the app with a simple MaterialApp
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(
      builder: (context) {
        return ElevatedButton(
          onPressed: () {
            ToastManager.show(
              context: context,
              message: "Test Toast",
              duration: const Duration(seconds: 1),
            );
          },
          child: const Text('Show Toast'),
        );
      },
    ))));

    // Tap the button to trigger the toast
    await tester.tap(find.text('Show Toast'));
    await tester.pumpAndSettle();

    // Check if the toast appears on the screen (based on its message)
    expect(find.text('Test Toast'), findsOneWidget);
  });

  testWidgets('ToastManager removes toast after duration', (tester) async {
    // Build the app with a simple MaterialApp
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(
      builder: (context) {
        return ElevatedButton(
          onPressed: () {
            ToastManager.show(
              context: context,
              message: "Test Toast",
              duration: const Duration(seconds: 1),
            );
          },
          child: const Text('Show Toast'),
        );
      },
    ))));

    // Tap the button to trigger the toast
    await tester.tap(find.text('Show Toast'));
    await tester.pump();

    // Check if the toast appears on the screen
    expect(find.text('Test Toast'), findsOneWidget);

    // Wait for the toast to disappear after duration
    await tester.pump(const Duration(seconds: 2));

    // Check if the toast disappears
    expect(find.text('Test Toast'), findsNothing);
  });

  test('ToastManager clear removes all toasts', () {
    // Initialize ToastManager and simulate toasts
    final context =
        null; // Use an appropriate context when testing in real apps
    ToastManager.show(
      context: context!,
      message: "Toast 1",
      duration: const Duration(seconds: 1),
    );
    ToastManager.show(
      context: context!,
      message: "Toast 2",
      duration: const Duration(seconds: 1),
    );
  });
}
