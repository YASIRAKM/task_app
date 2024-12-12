import 'package:flutter/material.dart';
import 'package:task_application/core/utils/gaps.dart';
import 'package:task_application/core/widgets/custom_button.dart';
import 'package:task_application/main.dart';

Future<dynamic> confirmDialoge(
    {required BuildContext context,
    required String title,
    String content = "",
    required VoidCallback onPressed,
    required String buttonText,
    bool isLoading = false}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CustomButton(
            width: 100,
            isCanccel: true,
            text: "Cancel",
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
          ),
          mediumHorizontalGap(),
          CustomButton(
            width: 100,
            text: buttonText,
            onPressed: onPressed,
          )
        ],
      );
    },
  );
}
