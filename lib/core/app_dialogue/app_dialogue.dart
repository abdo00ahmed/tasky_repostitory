import 'package:flutter/material.dart';

class AppDialogue {
  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xff5F33E1)),
        );
      },
    );
  }

  static void showError(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Back", style: TextStyle(color: Colors.red)),
            ),
          ],
          title: Text(
            "Error has occured ",
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            "Error in email or password",
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
