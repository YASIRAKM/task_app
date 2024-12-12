import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_application/core/constants/api_strings.dart';
import 'package:http/http.dart' as http;
import 'package:task_application/core/utils/date_helper.dart';
import 'package:task_application/features/authentication/model/user_model.dart';
import 'package:task_application/features/task_management/model/task_model.dart';

class ApiRepository {
  static Future<UserModel> login(String username, String password) async {
    log(loginurl);

    var response = await http.post(Uri.parse(loginurl),
        body: {"email": username, "password": password});

    try {
      if (response.statusCode == HttpStatus.ok) {
        return userModelFromJson(response.body);
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<(bool, String)> addTask(Tasks task) async {
    try {
      String? token = await SharedPrefHelper.getValue("token");
      Map params = {
        "name": task.name,
        "description": task.description,
        "deadline": DateHelper.formatToYYYYMMDD(task.deadline!)
      };
      log(json.encode(params));

      var response = await http.post(Uri.parse(addTasksUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(params));
      log(response.body);

      if (response.statusCode == 200) {
        return (true, "added");
      } else {
        return (false, "error adding task");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<(bool, String)> updateTask(Tasks task) async {
    try {
      String? token = await SharedPrefHelper.getValue("token");
      Map params = {
        "name": task.name,
        "description": task.description,
        "deadline": DateHelper.formatToYYYYMMDD(task.deadline!)
      };

      var response = await http.post(Uri.parse("$updateTaskUrl${task.id}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(params));

      log(response.body);

      if (response.statusCode == 200) {
        return (true, "updated");
      } else {
        return (false, "failed");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<TaskModel> getTasks() async {
    try {
      String? token = await SharedPrefHelper.getValue("token");
      final response = await http.get(
        Uri.parse(getTasksUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        TaskModel tasks = taskModelFromJson(response.body);
        return tasks;
      } else {
        throw Exception("ss");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<(bool, String)> deleteTask(int id) async {
    try {
      String? token = await SharedPrefHelper.getValue("token");
      final response = await http.post(
        Uri.parse("$deleteTaskUrl$id"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return (true, "");
      } else {
        return (false, "failed");
      }
    } catch (e) {
      return (false, e.toString());
    }
  }
}

class SharedPrefHelper {
  static Future<void> saveValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> clearValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
