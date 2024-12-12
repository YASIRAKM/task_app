import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_application/core/utils/confirm_dialoge.dart';
import 'package:task_application/core/utils/date_helper.dart';
import 'package:task_application/core/utils/gaps.dart';
import 'package:task_application/core/utils/text_styles.dart';
import 'package:task_application/core/widgets/custom_button.dart';
import 'package:task_application/core/widgets/custom_textfield.dart';
import 'package:task_application/features/task_management/model/task_model.dart';

import 'package:task_application/features/task_management/view_model/task_provider.dart';

class TaskAddForm extends ConsumerStatefulWidget {
  Tasks? task;
  TaskAddForm({super.key, this.task});

  @override
  ConsumerState<TaskAddForm> createState() => _TaskAddFormState();
}

class _TaskAddFormState extends ConsumerState<TaskAddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    if (widget.task != null) {
      _taskController.text = widget.task!.name;
      _descriptionController.text = widget.task!.description;
      _dateController.text = widget.task!.deadline == null
          ? ""
          : DateHelper.formatToDDMMYYYY(
              widget.task!.deadline ?? DateTime.now());
    }

    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task != null ? "Update Task" : "ADD TASK",
              style: AppTextStyles.cardTitle,
            ),
            largeVerticalGap(),
            CustomTextField(
              labelText: "Task",
              hintText: "Enter task name",
              controller: _taskController,
              validate: true,
            ),
            largeVerticalGap(),
            CustomTextField(
              labelText: "Description",
              hintText: "Enter task description",
              controller: _descriptionController,
              maxLines: 3,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Decription is required';
              //   }
              //   return null;
              // },
            ),
            largeVerticalGap(),
            CustomDatePickerField(
                labelText: "Deadline",
                hintText: "Select deadline date",
                validate: true,
                controller: _dateController),
            largeVerticalGap(),
            CustomButton(
              text: widget.task != null ? "Update Task" : "Submit Task",
              onPressed: () {
                _submitForm(context);
              },
            ),
          ],
        ),
      ),
    );
  }

/*submit form */
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final taskname = _taskController.text.trim();
      final description = _descriptionController.text.trim();
      final deadline = _dateController.text;
      int id = widget.task != null ? widget.task!.id : 0;
      Tasks task = Tasks(
          id: id,
          name: taskname,
          description: description,
          deadline: DateHelper.parseFromDDMMYYYY(deadline));
      if (widget.task != null) {
        confirmDialoge(
            context: context,
            title: "Update",
            onPressed: () {
              ref.read(taskProvider.notifier).updateTask(task);
            },
            buttonText: "Update",
            content: "Do you wnat to update this task?");
      } else {
        ref.read(taskProvider.notifier).addTask(task);
      }
    }
  }
}
