import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flexi_toast/toast_widget.dart';
import 'package:flexi_toast/toast_position.dart';

void main() {
  testWidgets('ToastWidget displays message correctly', (tester) async {
    // Create a simple test app with the ToastWidget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToastWidget(
          message: 'Test Toast',
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.info, color: Colors.white),
          onTap: () {},
        ),
      ),
    ));

    // Verify that the message is rendered on screen
    expect(find.text('Test Toast'), findsOneWidget);
  });

  testWidgets('ToastWidget renders with description', (tester) async {
    // Create a simple test app with the ToastWidget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToastWidget(
          message: 'Test Toast',
          description: 'This is a description',
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.info, color: Colors.white),
          onTap: () {},
        ),
      ),
    ));

    // Verify that both the message and description are rendered on screen
    expect(find.text('Test Toast'), findsOneWidget);
    expect(find.text('This is a description'), findsOneWidget);
  });

  testWidgets('ToastWidget displays icon', (tester) async {
    // Create a simple test app with the ToastWidget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToastWidget(
          message: 'Test Toast',
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.info, color: Colors.white),
          onTap: () {},
        ),
      ),
    ));

    // Verify that the icon is rendered on screen
    expect(find.byIcon(Icons.info), findsOneWidget);
  });

  testWidgets('ToastWidget reacts to onTap event', (tester) async {
    bool tapped = false;

    // Create a simple test app with the ToastWidget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToastWidget(
          message: 'Test Toast',
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.info, color: Colors.white),
          onTap: () {
            tapped = true;
          },
        ),
      ),
    ));

    // Tap the toast widget
    await tester.tap(find.text('Test Toast'));
    await tester.pump();

    // Verify that the onTap callback was triggered
    expect(tapped, true);
  });

  testWidgets('ToastWidget positions correctly at top', (tester) async {
    // Create a test app with the ToastWidget positioned at the top
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToastWidget(
          message: 'Test Toast',
          duration: const Duration(seconds: 2),
          position: ToastPosition.top,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.info, color: Colors.white),
          onTap: () {},
        ),
      ),
    ));

    // Verify that the toast is positioned at the top
    final toastPosition = tester.getTopLeft(find.byType(ToastWidget));
    expect(toastPosition.dy,
        lessThan(100)); // Ensure it is near the top of the screen
  });

  testWidgets('ToastWidget positions correctly at bottom', (tester) async {
    // Create a test app with the ToastWidget positioned at the bottom
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ToastWidget(
          message: 'Test Toast',
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.info, color: Colors.white),
          onTap: () {},
        ),
      ),
    ));

    // Verify that the toast is positioned at the bottom
    final toastPosition = tester.getBottomLeft(find.byType(ToastWidget));
    expect(toastPosition.dy,
        greaterThan(400)); // Ensure it is near the bottom of the screen
  });
}
