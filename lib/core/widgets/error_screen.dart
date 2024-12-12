import 'package:flutter/material.dart';
import 'package:task_application/core/utils/gaps.dart';
import 'package:task_application/core/utils/text_styles.dart';
import 'package:task_application/core/widgets/custom_button.dart';

class ShowErrorWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const ShowErrorWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "something went wrong please try again",
            style: AppTextStyles.headline5,
          ),
          largeVerticalGap(),
          CustomButton(
            text: "Refresh",
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
