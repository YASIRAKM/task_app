import 'dart:convert';

import 'package:task_application/core/utils/date_helper.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int totalTasks;
  int pendingTasks;
  List<Tasks> data;

  TaskModel({
    required this.totalTasks,
    required this.pendingTasks,
    required this.data,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        totalTasks: json["total_tasks"],
        pendingTasks: json["pending_tasks"],
        data: List<Tasks>.from(json["data"].map((x) => Tasks.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_tasks": totalTasks,
        "pending_tasks": pendingTasks,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Tasks {
  int id;
  String name;
  String description;
  int? percentage;
  String? status;
  DateTime? deadline;

  Tasks(
      {required this.id,
      required this.name,
      required this.description,
      this.percentage,
      this.status,
      this.deadline});

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        percentage: json["percentage"] ?? 0,
        deadline:
            DateHelper.parseFromYYYYMMDD(json["deadline"] ?? "2024-12-12"),
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "name": name,
        "description": description,
        "percentage": percentage,
        "status": status,
      };
}
