// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:klik/application/core/constants/constants.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmButtonText,
  required String cancelButtonText,
  required Future<void> Function() onConfirm,
  VoidCallback? onCancel,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(title, style: showdialogueHeadingstyle),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                content,
                style: showdialogueContentStyle,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              }
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text(
              cancelButtonText,
              style: showDialogueButtonStyle,
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await onConfirm();

              // Dismiss the dialog
            },
            child: Text(confirmButtonText, style: showDialogueButtonStyle2),
          ),
        ],
      );
    },
  );
}
