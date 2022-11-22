import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_dropdown_search/Dialog/dialog_options.dart';

class AppDialogs {
  static Future<void> showAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
    DialogOptions options  = const DialogOptions(),
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return _IOSDialog(
            title: title,
            content: content,options: options,

          );
        } else {
          return _AndroidDialog(
            title: title,
            content: content,
            options: options,
          );
        }
      },
    );
  }
}

// Build cupertino dialog with CupertinoAlertDialog
class _IOSDialog extends StatelessWidget {
  final String title;
  final String content;
  final DialogOptions options;

  const _IOSDialog({
    Key? key,
    required this.title,
    required this.content,
    this.options = const DialogOptions(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: options.onMainActionPressed,
          isDefaultAction: true,
          child: Text(options.mainActionText),
        ),
        CupertinoDialogAction(
          onPressed: options.onSecondaryActionPressed,
          isDestructiveAction: options.isSecondaryDestructiveAction,
          child: Text(options.secondaryActionText),
        ),
      ],
    );
  }
}
// Build Android dialog with AlertDialog
class _AndroidDialog extends StatelessWidget {
  final String title;
  final String content;
  final DialogOptions options;

  const _AndroidDialog(
      {Key? key,
      required this.title,
      required this.content,
       this.options = const DialogOptions()})

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: options.onMainActionPressed,
          child: Text(options.mainActionText),
        ),
        TextButton(
          onPressed: options.onSecondaryActionPressed,
          child: Text(options.secondaryActionText),
        ),
      ],
    );
  }
}
