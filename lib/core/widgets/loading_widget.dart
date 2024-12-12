import 'package:flutter/cupertino.dart';

import 'package:task_application/core/constants/color_strings.dart';

class ShowLoadingWidget extends StatelessWidget {
  const ShowLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        color: AppColors.button,
      ),
    );
  }
}
