import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_application/core/constants/color_strings.dart';
import 'package:task_application/core/utils/confirm_dialoge.dart';
import 'package:task_application/core/utils/gaps.dart';
import 'package:task_application/core/utils/text_styles.dart';
import 'package:task_application/core/widgets/custom_button.dart';
import 'package:task_application/core/widgets/custom_text.dart';
import 'package:task_application/core/widgets/image_view_widget.dart';
import 'package:task_application/features/authentication/model/user_model.dart';
import 'package:task_application/features/authentication/view_model/authentication_provider.dart';


class ProfileView extends ConsumerWidget {
  final UserModel user;
  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: const Text(
          "Profile",
          style: AppTextStyles.headline3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: ImageViewWidget(url: user.image)),
            extraLargeVerticalGap(),
            const Divider(),
            mediumVerticalGap(),
            CustomRowText(title: "Name : ", subTitle: user.name),
            mediumVerticalGap(),
            CustomRowText(title: "Position : ", subTitle: user.position),
            mediumVerticalGap(),
            CustomRowText(
              title: "Total tasks :",
              subTitle: "${user.noOfTask.toString()} Tasks",
              subTitleTextStyle: AppTextStyles.headline4,
            ),
            mediumVerticalGap(),
            const Divider(),
            mediumVerticalGap(),
            const Text(
              "Percantage :",
              style: AppTextStyles.headline4,
            ),
            mediumVerticalGap(),
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(15),
              minHeight: 20,
              color: user.percentage <= 25
                  ? AppColors.redColor
                  : user.percentage >= 75
                      ? AppColors.greenColor
                      : AppColors.yellowColor,
              backgroundColor: AppColors.fadedTextColor,
              // valueColor:AnimationColro,
              // //  current.percentage! <= 25
              // //     ? AppColors.redColor
              // //     :AppColors.greenColor,
              value: double.parse(user.percentage.toString()),
            ),
            smallVerticalGap(),
            const Divider(),
            extraLargeVerticalGap(),
            CustomButton(
              text: "Logout",
              onPressed: () {
                confirmDialoge(
                    context: context,
                    title: "Log out",
                    onPressed: () {
                      ref.read(authProvider.notifier).logout();
                    },
                    content: "Do you want to log out",
                    buttonText: "Log out");
              },
            )
          ],
        ),
      ),
    );
  }
}
