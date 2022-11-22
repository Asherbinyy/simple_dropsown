import 'package:flutter/foundation.dart';

class DialogOptions {
  // main action
  final String mainActionText;
  final VoidCallback? onMainActionPressed;
  // secondary action
  final String secondaryActionText;
  final VoidCallback? onSecondaryActionPressed;
  final bool isSecondaryDestructiveAction;

  const DialogOptions({
    this.mainActionText = 'OK',
    this.onMainActionPressed,
    this.secondaryActionText = 'Cancel',
    this.onSecondaryActionPressed,
    this.isSecondaryDestructiveAction = true,
  });
}

class DialogIosOptions {}
