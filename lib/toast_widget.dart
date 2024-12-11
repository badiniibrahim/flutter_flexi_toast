import 'package:flexi_toast/toast_position.dart';
import 'package:flutter/material.dart';

/// A widget representing a toast notification.
///
/// The [message], [duration], [position], [backgroundColor], [textStyle], [borderRadius], and [icon] parameters
/// allow for complete customization of the toast appearance and behavior. The [onTap] parameter provides an optional
/// callback when the toast is tapped.
///
/// Example usage:
/// ```dart
/// ToastWidget(
///   message: "Event created successfully",
///   description: "Sunday, December 03, 2023 at 9:00 AM",
///   duration: Duration(seconds: 3),
///   position: ToastPosition.bottom,
///   backgroundColor: Colors.green,
///   textStyle: TextStyle(color: Colors.white),
///   borderRadius: BorderRadius.all(Radius.circular(8)),
///   icon: Icon(Icons.check_circle, color: Colors.white),
///   onTap: () { print("Toast tapped!"); },
/// );
/// ```
class ToastWidget extends StatelessWidget {
  final String message;
  final String? description;
  final Duration duration;
  final ToastPosition position;
  final Color backgroundColor;
  final TextStyle textStyle;
  final BorderRadiusGeometry borderRadius;
  final Widget? icon;
  final VoidCallback? onTap;
  final String? actionLabel; // Optional action button label (e.g., "Undo")
  final VoidCallback? onActionPressed; // Callback for action button press

  const ToastWidget({
    super.key,
    required this.message,
    this.description,
    required this.duration,
    required this.position,
    required this.backgroundColor,
    required this.textStyle,
    required this.borderRadius,
    this.icon,
    this.onTap,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: position == ToastPosition.bottom ? 40 : null,
      top: position == ToastPosition.top ? 40 : null,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            description!,
                            style: textStyle.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (actionLabel != null && onActionPressed != null) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onActionPressed,
                    child: Text(
                      actionLabel!,
                      style: textStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
