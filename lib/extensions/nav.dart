import 'package:flutter/Material.dart';

extension Nav on BuildContext {
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

  void navAndClean(Widget nextScreen) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => nextScreen),
      (route) => false,
    );
  }
}
