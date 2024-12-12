import 'package:flutter/material.dart';
import 'package:task_application/core/constants/color_strings.dart';
import 'package:task_application/core/utils/text_styles.dart';
import 'package:task_application/main.dart';

showMessage({required String message}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.info_outline, // You can change this icon to any other
          color: AppColors.background,
        ),
        const SizedBox(width: 8), // Space between icon and text
        Expanded(
          child: Text(
            message,
            style: AppTextStyles.button1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    backgroundColor:
        AppColors.fadedTextColor, // Background color of the SnackBar
    duration: const Duration(seconds: 3), // How long the SnackBar will stay
    behavior: SnackBarBehavior
        .floating, // Floating SnackBar (appears above the content)
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Rounded corners
    ),
    padding: const EdgeInsets.symmetric(
        vertical: 12, horizontal: 16), // Custom padding
  );

  return scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
