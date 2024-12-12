// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:task_application/core/utils/text_styles.dart';

class CustomRowText extends StatelessWidget {
  final String title;
  final String subTitle;
  TextStyle titleTextStyle;
  TextStyle subTitleTextStyle;

  CustomRowText({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleTextStyle = AppTextStyles.headline4,
    this.subTitleTextStyle = AppTextStyles.cardSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: "$title ",
        style: titleTextStyle,
        children: [
          TextSpan(
            text: subTitle,
            style: subTitleTextStyle,
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.visible,
      softWrap: true,
    );
  }
}
