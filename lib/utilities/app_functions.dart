import 'package:flutter/services.dart';

class AppFunctions {
  onPressedWithHaptic(Function f) {
    HapticFeedback.mediumImpact();
    f();
  }
}
