import 'package:flutter/material.dart';

Future<void> showActionBottomSheet(
  BuildContext context, {
  required List<ActionItem> actions,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    showDragHandle: true,
    builder: (context) {
      return ActionBottomSheet(actions: actions);
    },
  );
}

class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet({
    required this.actions,
    super.key,
  });

  final List<ActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: actions,
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        onTap: () {
          Navigator.pop(context);
          onTap?.call();
        },
      ),
    );
  }
}
