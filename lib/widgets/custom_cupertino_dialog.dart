import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool hasTwoButtons;
  final String button1Text;
  final String button2Text;
  final VoidCallback? button1Action;
  final VoidCallback? button2Action;

  const CustomCupertinoDialog({
    super.key,
    required this.title,
    required this.content,
    this.hasTwoButtons = false,
    this.button1Text = 'Ok',
    this.button2Text = 'Cancel',
    this.button1Action,
    this.button2Action,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(content),
      ),
      actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    if (!hasTwoButtons) {
      return [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: button1Action ?? () {},
          child: Text(
            button1Text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ), // Execute button1Action or do nothing
        ),
      ];
    } else {
      return [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: button1Action ?? () {},
          child: Text(
            button1Text,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ), // Execute button1Action or do nothing
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: button2Action ?? () {},
          child: Text(
            button2Text,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ), // Execute button2Action or do nothing
        ),
      ];
    }
  }
}
