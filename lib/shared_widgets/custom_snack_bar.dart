import 'package:flutter/material.dart';

// グローバル関数としてスナックバーを表示する
// `context`はスナックバーを表示する画面のBuildContext
// `message`はスナックバーに表示したいメッセージ
// `duration`はスナックバーを表示する時間（省略可能、デフォルトは3秒）
void showCustomSnackbar(
  BuildContext context,
  String message, {
  int duration = 2,
}) {
  final snackbar = SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 16),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: Colors.grey);

  // ScaffoldMessengerを使用してスナックバーを表示
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
