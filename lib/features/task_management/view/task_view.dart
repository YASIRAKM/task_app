import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_application/core/constants/color_strings.dart';
import 'package:task_application/core/utils/confirm_dialoge.dart';
import 'package:task_application/core/utils/date_helper.dart';
import 'package:task_application/core/utils/gaps.dart';
import 'package:task_application/core/utils/text_styles.dart';

import 'package:task_application/core/widgets/custom_text.dart';
import 'package:task_application/core/widgets/error_screen.dart';
import 'package:task_application/core/widgets/loading_widget.dart';
import 'package:task_application/features/task_management/model/task_model.dart';
import 'package:task_application/features/task_management/view/add_task_form.dart';
import 'package:task_application/features/task_management/view_model/task_provider.dart';

class TaskView extends ConsumerWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        shape: const CircleBorder(),
        backgroundColor: AppColors.button,
        isExtended: true,
        onPressed: () {
          _taskAddUpdate(context);
        },
        child: const Icon(
          CupertinoIcons.add_circled,
          color: AppColors.background,
          size: 35,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: const Text(
          "Tasks",
          style: AppTextStyles.headline3,
        ),
      ),
      body: taskState.when(
        data: (task) => onData(task, ref),
        error: (error, stackTrace) => ShowErrorWidget(
          onPressed: () {
            ref.read(taskProvider.notifier).fetchTasks();
          },
        ),
        loading: () => const ShowLoadingWidget(),
      ),
    );
  }

  Future<dynamic> _taskAddUpdate(BuildContext context, {Tasks? task}) {
    return showModalBottomSheet(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: TaskAddForm(
            task: task,
          ),
        );
      },
    );
  }

/*is data success */
  Padding onData(TaskModel task, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              CustomRowText(
                title: "Total Tasks :",
                subTitle: task.totalTasks.toString(),
                subTitleTextStyle: AppTextStyles.cardTitle,
              ),
              CustomRowText(
                title: "Pending Tasks :",
                subTitle: task.pendingTasks.toString(),
                subTitleTextStyle: AppTextStyles.cardTitle,
              )
            ],
          ),
          largeVerticalGap(),
          Expanded(
              child: task.data.isEmpty
                  ? const Center(
                      child: Text(
                        "No task available",
                        style: AppTextStyles.headline4,
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Tasks current = task.data[index];
                        return taskCardTile(context, current, ref);
                      },
                      separatorBuilder: (context, index) {
                        return largeVerticalGap();
                      },
                      itemCount: task.data.length))
        ],
      ),
    );
  }

/*card tile */
  Container taskCardTile(BuildContext context, Tasks current, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.containerBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // direction: Axis.vertical,
        children: [
          CustomRowText(
              titleTextStyle: AppTextStyles.cardTitle,
              subTitleTextStyle: AppTextStyles.cardSubtitle,
              title: "Task name :",
              subTitle: current.name),
          mediumVerticalGap(),
          const Divider(),
          mediumVerticalGap(),
          CustomRowText(
              titleTextStyle: AppTextStyles.cardBody1,
              subTitleTextStyle: AppTextStyles.cardBody2,
              title: "Deadline  :",
              subTitle: DateHelper.formatToDDMMYYYY(
                  current.deadline ?? DateTime.now())),
          mediumVerticalGap(),
          const Text(
            "Description :",
            style: AppTextStyles.cardBody1,
          ),
          smallVerticalGap(),
          Text(
            current.description == ""
                ? "No description available"
                : current.description,
            style: AppTextStyles.cardBody2,
          ),
          smallVerticalGap(),
          const Divider(),
          smallVerticalGap(),
          const Text(
            "Completed :",
            style: AppTextStyles.cardBody1,
          ),
          mediumVerticalGap(),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(15),
            minHeight: 20,
            color: current.percentage! <= 25
                ? AppColors.redColor
                : current.percentage! >= 75
                    ? AppColors.greenColor
                    : AppColors.yellowColor,
            backgroundColor: AppColors.fadedTextColor,
            // valueColor:AnimationColro,
            // //  current.percentage! <= 25
            // //     ? AppColors.redColor
            // //     :AppColors.greenColor,
            value: double.parse(current.percentage.toString()),
          ),
          largeVerticalGap(),
          CustomRowText(
              title: "Status : ",
              titleTextStyle: AppTextStyles.cardBody1,
              subTitleTextStyle: current.status!.toUpperCase() == "INCOMPLETE"
                  ? AppTextStyles.incompletedText
                  : AppTextStyles.completedText,
              subTitle: current.status!.toUpperCase()),
          smallVerticalGap(),
          const Divider(),
          mediumVerticalGap(),
          cardBottomWidgets(context, current, ref)
        ],
      ),
    );
  }

  Row cardBottomWidgets(BuildContext context, Tasks task, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Hero(
        //     tag: "view_task",
        //     child: IconButton(
        //         onPressed: () {
        //           (context: context,);
        //         },
        //         icon: const Icon(CupertinoIcons.eye))),
        // smallHorizontalGap(),
        IconButton(
            onPressed: () {
              _taskAddUpdate(context, task: task);
            },
            icon: const Icon(Icons.edit_document)),
        smallHorizontalGap(),
        IconButton(
            onPressed: () {
              confirmDialoge(
                  context: context,
                  title: "Delete",
                  onPressed: () {
                    ref.read(taskProvider.notifier).deleteTask(task.id);
                  },
                  buttonText: "Delete",
                  content: "Do you want to delete this task ?");
            },
            icon: const Icon(
              CupertinoIcons.delete,
              color: AppColors.redColor,
            )),
        smallHorizontalGap(),
      ],
    );
  }
}
