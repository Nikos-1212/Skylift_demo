import 'package:flutter/material.dart';

class TextFieldDialog extends StatelessWidget {
  final String title;
  final String nameHintText;
  final String emailHintText;
  final TextEditingController nameField;
  final TextEditingController emailField;

  const TextFieldDialog({
    Key? key,
    required this.title,
    required this.nameHintText,
    required this.emailHintText,
    required this.nameField,
    required this.emailField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameField,
            decoration: InputDecoration(hintText: nameHintText),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailField, // Use emailField controller here
            decoration: InputDecoration(hintText: emailHintText),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop([nameField.text, emailField.text]);
          },
        ),
      ],
    );
  }
}
