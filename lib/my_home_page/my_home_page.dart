import 'package:components_sample/shared_widgets/action_bottom_sheet.dart';
import 'package:components_sample/shared_widgets/confirm_dialog.dart';
import 'package:components_sample/shared_widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final boxColor = useState(Colors.black);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          children: [
            const Text('色が変わります：デフォルトは黒'),
            const Gap(20),
            SizedBox(
              height: 200,
              width: 200,
              child: ColoredBox(color: boxColor.value),
            ),
            const Gap(40),
            _OnlyBottomSheetButton(boxColor: boxColor),
            const Gap(20),
            _OnlyDialogButton(boxColor: boxColor),
            const Gap(20),
            _OnlySnackBar(boxColor: boxColor),
            const Gap(20),
            _DialogAndSnackBarButton(boxColor: boxColor),
            const Gap(20),
            _AllButton(boxColor: boxColor),
          ],
        ),
      ),
    );
  }
}

class _OnlyBottomSheetButton extends StatelessWidget {
  const _OnlyBottomSheetButton({required this.boxColor});

  final ValueNotifier<Color> boxColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showActionBottomSheet(
          context,
          actions: [
            ActionItem(
              icon: Icons.apple,
              text: '赤色に変更',
              onTap: () => boxColor.value = Colors.red,
            ),
            ActionItem(
              icon: Icons.water,
              text: '青色に変更',
              onTap: () => boxColor.value = Colors.blue,
            ),
            ActionItem(
                icon: Icons.light,
                text: '黄色に変更',
                onTap: () => boxColor.value = Colors.yellow),
            ActionItem(
              icon: Icons.replay_outlined,
              text: '元に戻す',
              onTap: () => boxColor.value = Colors.black,
            ),
          ],
        );
      },
      child: const Text('ボトムシートだけ'),
    );
  }
}

class _OnlyDialogButton extends StatelessWidget {
  const _OnlyDialogButton({required this.boxColor});

  final ValueNotifier<Color> boxColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(
          context,
          title: const Text('色の変更'),
          content: const Text('赤色に変更してもよろしいですか？'),
        );
        if (result) {
          boxColor.value = Colors.red;
        }
      },
      child: const Text('ダイアログだけ：赤色に変更'),
    );
  }
}

class _OnlySnackBar extends StatelessWidget {
  const _OnlySnackBar({required this.boxColor});

  final ValueNotifier<Color> boxColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        boxColor.value = Colors.blue;
        showCustomSnackbar(context, '青色に変更しました');
      },
      child: const Text('スナックバーだけ：青色に変更'),
    );
  }
}

class _DialogAndSnackBarButton extends StatelessWidget {
  const _DialogAndSnackBarButton({required this.boxColor});

  final ValueNotifier<Color> boxColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final result = await showConfirmDialog(
          context,
          title: const Text('色の変更'),
          content: const Text('黄色に変更してもよろしいですか？'),
        );
        if (result && context.mounted) {
          boxColor.value = Colors.yellow;
          showCustomSnackbar(context, '黄色に変更しました');
        }
      },
      child: const Text('ダイアログ＋スナックバー'),
    );
  }
}

class _AllButton extends StatelessWidget {
  const _AllButton({required this.boxColor});

  final ValueNotifier<Color> boxColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showActionBottomSheet(
          context,
          actions: [
            ActionItem(
              icon: Icons.apple,
              text: '赤色に変更',
              onTap: () async {
                final result = await showConfirmDialog(
                  context,
                  title: const Text('色の変更'),
                  content: const Text('赤色に変更してもよろしいですか？'),
                );
                if (result && context.mounted) {
                  boxColor.value = Colors.red;
                  showCustomSnackbar(context, '赤色に変更しました');
                }
              },
            ),
            ActionItem(
              icon: Icons.water,
              text: '青色に変更',
              onTap: () async {
                final result = await showConfirmDialog(
                  context,
                  title: const Text('色の変更'),
                  content: const Text('青色に変更してもよろしいですか？'),
                );
                if (result && context.mounted) {
                  boxColor.value = Colors.blue;
                  showCustomSnackbar(context, '青色に変更しました');
                }
              },
            ),
            ActionItem(
              icon: Icons.light,
              text: '黄色に変更',
              onTap: () async {
                final result = await showConfirmDialog(
                  context,
                  title: const Text('色の変更'),
                  content: const Text('黄色に変更してもよろしいですか？'),
                );
                if (result && context.mounted) {
                  boxColor.value = Colors.yellow;
                  showCustomSnackbar(context, '黄色に変更しました');
                }
              },
            ),
            ActionItem(
              icon: Icons.replay_outlined,
              text: '元に戻す',
              onTap: () async {
                final result = await showConfirmDialog(
                  context,
                  title: const Text('元に戻す'),
                  content: const Text('色を元に戻してもよろしいですか？'),
                );
                if (result && context.mounted) {
                  boxColor.value = Colors.black;
                  showCustomSnackbar(context, '色を元に戻しました');
                }
              },
            ),
          ],
        );
      },
      child: const Text('全部の組み合わせ'),
    );
  }
}
