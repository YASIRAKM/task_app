import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_application/common_providers/common_providers.dart';
import 'package:task_application/core/utils/show_message.dart';
import 'package:task_application/data/repository/api_repository.dart';
import 'package:task_application/features/task_management/model/task_model.dart';
import 'package:task_application/main.dart';

class TaskNotifier extends AsyncNotifier<TaskModel> {
  @override
  Future<TaskModel> build() async {
    return fetchTasks();
  }

  Future<TaskModel> fetchTasks() async {
    state = const AsyncValue.loading();
    try {
      TaskModel task = await ApiRepository.getTasks();
      state = AsyncValue.data(task);

      return task;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      throw Exception();
    }
  }

  Future<void> addTask(Tasks task) async {
    ref.read(loadingProvider.notifier).state = true;
    try {
      state = await AsyncValue.guard(
        () async {
          (bool, String) res = await ApiRepository.addTask(task);

          if (res.$1) {
            Future.microtask(() {
              ref.read(loadingProvider.notifier).state = false;
            });
            navigatorKey.currentState!.pop();
            showMessage(message: "Task  Added");

            return fetchTasks();
          } else {
            ref.read(loadingProvider.notifier).state = false;
            showMessage(message: "Failed to Add task ");
            return fetchTasks();
          }
        },
      );
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      showMessage(message: "Failed to Add task ");
      throw Exception(e);
    }
  }

  Future<void> updateTask(Tasks task) async {
    ref.read(loadingProvider.notifier).state = true;
    try {
      state = await AsyncValue.guard(
        () async {
          (bool, String) res = await ApiRepository.updateTask(task);

          if (res.$1) {
            Future.microtask(() {
              ref.read(loadingProvider.notifier).state = false;
            });
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pop();
            showMessage(message: "Task  Updated");

            return fetchTasks();
          } else {
            ref.read(loadingProvider.notifier).state = false;
            navigatorKey.currentState!.pop();
            showMessage(message: "Failed to Update task ");
            return fetchTasks();
          }
        },
      );
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!.pop();
      showMessage(message: "Failed to Update task ");
    }
  }

  Future<void> deleteTask(int id) async {
    ref.read(loadingProvider.notifier).state = true;
    try {
      state = await AsyncValue.guard(
        () async {
          (bool, String) res = await ApiRepository.deleteTask(id);
          log(res.$2);

          if (res.$1) {
            Future.microtask(() {
              ref.read(loadingProvider.notifier).state = false;
            });
            navigatorKey.currentState!.pop();
            showMessage(message: "Task  Deleted");

            return fetchTasks();
          } else {
            ref.read(loadingProvider.notifier).state = false;
            navigatorKey.currentState!.pop();
            showMessage(message: "Failed to Delete task ");
            return fetchTasks();
          }
        },
      );
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      navigatorKey.currentState!.pop();
      showMessage(message: "Failed to Delete task ");
      throw Exception(e);
    }
  }
}

final taskProvider = AsyncNotifierProvider<TaskNotifier, TaskModel>(
  () => TaskNotifier(),
);
