import 'package:flexi_toast/toast_type.dart';
import 'package:flutter/material.dart';
import 'toast_widget.dart';
import 'toast_position.dart';

/// A utility class for managing the display of toast notifications within a Flutter application.
///
/// This class provides a convenient way to show toasts with customizable appearances, actions, and durations.
///
/// The [show] method allows you to display a toast with custom messages, duration, position, style, and more.
///
/// Example usage:
/// ```dart
/// ToastManager.show(
///   context: context,
///   message: "Event has been created",
///   description: "Sunday, December 03, 2023 at 9:00 AM",
///   duration: Duration(seconds: 3),
///   position: ToastPosition.bottom,
///   type: ToastType.success,  // Choose the toast type
///   icon: Icon(Icons.check_circle, color: Colors.white),  // Optional icon
///   onTap: () {
///     print("Toast tapped!");
///   },
/// );
/// ```
class ToastManager {
  static final _toasts = <OverlayEntry>[];

  /// Displays a toast with customizable parameters.
  ///
  /// - [context]: The BuildContext from which to display the toast. This must be provided.
  /// - [message]: The main message of the toast (required).
  /// - [description]: An optional description to display below the main message.
  /// - [duration]: The duration the toast will be visible. Default is `Duration(seconds: 2)`.
  /// - [position]: The position where the toast will appear (top, bottom). Default is `ToastPosition.bottom`.
  /// - [type]: The type of the toast, which controls the background color. Options include:
  ///   - `ToastType.danger`: Red background (for error or danger).
  ///   - `ToastType.warning`: Orange background (for warnings).
  ///   - `ToastType.success`: Green background (for success messages).
  ///   - `ToastType.info`: Blue background (for informational messages).
  /// - [textStyle]: The text style for the toast message. Default is white text.
  /// - [borderRadius]: The border radius of the toast container. Default is rounded corners with a radius of 8.
  /// - [icon]: An optional icon to display at the start of the toast.
  /// - [onTap]: An optional callback that gets triggered when the user taps on the toast.
  ///
  /// Example usage:
  /// ```dart
  /// ToastManager.show(
  ///   context: context,
  ///   message: "Event has been created",
  ///   description: "Sunday, December 03, 2023 at 9:00 AM",
  ///   duration: Duration(seconds: 3),
  ///   position: ToastPosition.bottom,
  ///   type: ToastType.success,
  ///   icon: Icon(Icons.check_circle, color: Colors.white),
  ///   onTap: () {
  ///     print("Toast tapped!");
  ///   },
  /// );
  /// ```
  static void show({
    required BuildContext context,
    required String message,
    String? description,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastType type = ToastType.info,
    TextStyle textStyle = const TextStyle(color: Colors.white),
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
    Widget? icon,
    VoidCallback? onTap,
  }) {
    final overlay = Overlay.of(context);
    Color backgroundColor;

    // Determine the background color based on the toast type
    switch (type) {
      case ToastType.danger:
        backgroundColor = Colors.red;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange;
        break;
      case ToastType.success:
        backgroundColor = Colors.green;
        break;
      case ToastType.info:
        backgroundColor = Colors.blue;
        break;
    }

    late final OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => ToastWidget(
        message: message,
        description: description,
        duration: duration,
        position: position,
        backgroundColor: backgroundColor,
        textStyle: textStyle,
        borderRadius: borderRadius,
        icon: icon,
        onTap: () {
          onTap?.call();
          _removeToast(overlayEntry);
        },
      ),
    );

    _toasts.add(overlayEntry);
    overlay.insert(overlayEntry);

    // Remove the toast after the specified duration
    Future.delayed(duration, () {
      _removeToast(overlayEntry);
    });
  }

  /// Removes a toast from the screen.
  ///
  /// - [entry]: The overlay entry representing the toast to remove.
  static void _removeToast(OverlayEntry entry) {
    if (_toasts.contains(entry)) {
      entry.remove();
      _toasts.remove(entry);
    }
  }

  /// Clears all active toasts from the screen.
  static void clear() {
    for (var toast in _toasts) {
      toast.remove();
    }
    _toasts.clear();
  }
}
