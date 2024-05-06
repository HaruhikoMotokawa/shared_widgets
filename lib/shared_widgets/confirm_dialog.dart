import 'package:flutter/material.dart';

/// カスタマイズしたダイアログを呼び出す
///
/// [isCancelButtonEnable]はデフォルトでtrue
///
/// ただの告知文を出したいだけの場合はここをfalseにすればOKボタンのみになる
Future<bool> showConfirmDialog(
  BuildContext context, {
  Widget? title,
  Widget? content,
  bool isCancelButtonEnable = true,
}) async {
  // Flutter標準のshowDialog関数を呼び出す
  // 引数のbuilderに[ConfirmDialog]を渡す
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            title: title,
            content: content,
            isCancelButtonEnable: isCancelButtonEnable,
          );
        },
      ) ??
      // showDialogの引数`barrierDismissible`はデフォルトでtrueになっている
      // つまりダイアログの外をタップするとダイアログを閉じるので、その場合の戻り値を
      // falseにしておく必要がある
      false;
}

/// ダイアログの基本形
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.title,
    this.content,
    required this.isCancelButtonEnable,
  });

  final Widget? title;
  final Widget? content;

  /// キャンセルボタンの表示を切り替えできるようにするフラグ
  final bool isCancelButtonEnable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        if (isCancelButtonEnable)
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
