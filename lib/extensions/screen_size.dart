import 'package:flutter/cupertino.dart';

/// Shortcuts to get the screen width and height, used to size widgets responsively.
extension ScreenSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
 }
