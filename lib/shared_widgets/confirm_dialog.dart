import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  Widget? title,
  Widget? content,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            title: title,
            content: content,
          );
        },
      ) ??
      false;
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.title,
    this.content,
  });

  final Widget? title;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
