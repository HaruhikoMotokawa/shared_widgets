import 'package:flutter/material.dart';

/// ユーザーへの告知ダイアログを表示する
///
/// - [type] を指定するとダイアログのタイトル、コンテント、ボタンのテキストが自動で設定される
/// - [title] タイトルのウイジェットで[type]が指定されている場合は無視される
/// - [content]コンテントのウイジェットで[type]が指定されている場合は無視される
/// - [doneButtonText] ボタンのテキストで[type]が指定されている場合は無視される
///
/// 使用例
/// ```dart
/// showNotificationDialog(
///  context,
///  type: NotificationDialogType.communicationFailure,
/// );
///
/// showNotificationDialog(
///   context,
///   title: const Text('アップロードの完了'),
///   content: const Text('クラウドへ写真データをアップロードしました。'),
///   doneButtonText: 'とじーーる',
/// ),
///```
Future<void> showNotificationDialog(
  BuildContext context, {
  NotificationType? type,
  Widget? title,
  Widget? content,
  String? doneButtonText,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return NotificationDialog(
        type: type,
        title: title,
        content: content,
        doneButtonText: doneButtonText,
      );
    },
  );
}

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({
    this.type,
    this.title,
    this.content,
    this.doneButtonText,
    super.key,
  });

  final Widget? title;
  final Widget? content;
  final String? doneButtonText;
  final NotificationType? type;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(24);

    final (titlePadding, contentPadding) = switch ((title, content)) {
      (null, _?) => (null, padding),
      (_?, null) => (padding, null),
      _ => (null, null),
    };

    // ここで引数typeのnullチェックをswitch式で行う
    // 引数のtypeが
    final titleWidget = switch (type) {
      // final hoge?でnullを剥がす => つまり引数に値が入っていた場合
      final type? => Text(type.title),
      // それ以外、つまりtypeはnullだった場合
      _ => title,
    };

    final contentWidget = switch (type) {
      final type? => Text(type.content),
      _ => content,
    };

    final buttonText = switch (type) {
      final type? => type.doneButtonText,
      _ => doneButtonText ?? '閉じる',
    };

    // PopScopeはAndroidの戻るボタンが無効になる
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: titleWidget,
        titlePadding: titlePadding,
        content: contentWidget,
        contentPadding: contentPadding,
        actions: [
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size.fromHeight(48)),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

/// 通知の種類
///
/// Dart2.17以降ではこう書ける(2022年5月以降)
enum NotificationType {
  /// 通信失敗
  communicationFailure(
    title: '通信の失敗',
    content: '通信が失敗しました。ネットワークを確認してください。',
    doneButtonText: '閉じる',
  ),

  /// データ取得失敗
  dataRetrievalFailure(
    title: 'データの取得に失敗',
    content: '原因不明のエラーによりデータの取得に失敗しました。もう一度お試しください。',
    doneButtonText: '閉じる',
  ),

  /// ダウンロードの終了
  finishDownload(
    title: 'ダウンロード完了',
    content: 'ダウンロードが正常に完了しました。',
    doneButtonText: 'OK',
  ); // <-　最後は';'で区切る

  const NotificationType({
    required this.title,
    required this.content,
    required this.doneButtonText,
  });

  /// 通知のタイトル
  final String title;

  /// 通知の内容
  final String content;

  /// ダイアログの閉じるボタンの表示
  final String doneButtonText;
}

/// =========================== これは昔書き方 ============================
enum NotificationTypeOld {
  communicationFailure,
  dataRetrievalFailure,
  finishDownload,
}
extension NotificationDialogTypeExtension on NotificationTypeOld {
  String get title {
    switch (this) {
      case NotificationTypeOld.communicationFailure:
        return '通信の失敗';
      case NotificationTypeOld.dataRetrievalFailure:
        return 'データの取得に失敗';
      case NotificationTypeOld.finishDownload:
        return 'ダウンロード完了';
    }
  }

  String get content {
    switch (this) {
      case NotificationTypeOld.communicationFailure:
        return '通信が失敗しました。ネットワークを確認してください。';
      case NotificationTypeOld.dataRetrievalFailure:
        return '原因不明のエラーによりデータの取得に失敗しました。もう一度お試しください。';
      case NotificationTypeOld.finishDownload:
        return 'ダウンロードが正常に完了しました。';
    }
  }

  String get doneButtonText {
    switch (this) {
      case NotificationTypeOld.communicationFailure:
        return '閉じる';
      case NotificationTypeOld.dataRetrievalFailure:
        return '閉じる';
      case NotificationTypeOld.finishDownload:
        return 'OK';
    }
  }
}
