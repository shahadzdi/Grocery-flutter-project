import 'package:flutter/Material.dart';

/// Shortcuts for navigating between screens using context.
extension Nav on BuildContext {
  /// Opens a new screen on top of the current one (the user can go back).
  void navToScreen(Widget nextScreen) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) {
          return nextScreen;
        },
      ),
    );
  }

  /// Opens a new screen and removes all previous screens (no going back).
  void navAndClean(Widget nextScreen) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => nextScreen),
      (route) => false,
    );
  }
}
