import 'package:flutter/material.dart';

Future submitAlertDialog(BuildContext context, String message) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Success! ✅',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                letterSpacing: 0.5,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 70,
        ),
      );
    },
  );
}
