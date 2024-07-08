import 'package:flutter/material.dart';

class CustomAlertDialog {
  final String title;
  final String content;
  final String cancelText;
  final String deleteText;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  CustomAlertDialog({
    required this.title,
    required this.content,
    required this.cancelText,
    required this.deleteText,
    this.onCancel,
    this.onDelete,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: onCancel ?? () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(deleteText),
              onPressed: onDelete ?? () {
                // Handle delete action
                Navigator.of(context).pop(); // Example: close dialog
              },
            ),
          ],
        );
      },
    );
  }
}