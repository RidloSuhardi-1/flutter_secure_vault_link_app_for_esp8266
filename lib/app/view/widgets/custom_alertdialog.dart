import 'package:flutter/material.dart';

import '../../../res/colors/color.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.text,
    required this.action,
  });

  final String? title;
  final String? text;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      titlePadding: const EdgeInsets.all(16.0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      actionsPadding: const EdgeInsets.all(16.0),
      title: Text(
        "$title",
        style: const TextStyle(
          color: kTitleColor,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$text",
            style: const TextStyle(
              color: kTextColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          style: TextButton.styleFrom(
            foregroundColor: kPrimaryColor,
            shadowColor: kPrimaryColor.withOpacity(0.1),
          ),
          child: const Text('Tutup'),
        ),
        ElevatedButton(
          onPressed: action,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: kPrimaryColor,
            shadowColor: kPrimaryColor.withOpacity(0.1),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
