

import 'package:flutter/material.dart';
import 'package:task_application/bottom_navigation_view.dart';
import 'package:task_application/core/utils/text_styles.dart';

import 'dart:async';

import 'package:task_application/data/repository/api_repository.dart';
import 'package:task_application/features/authentication/model/user_model.dart';
import 'package:task_application/features/authentication/view/login_view.dart';


import 'package:task_application/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String userString = await SharedPrefHelper.getValue('user') ?? "";

    await Future.delayed(const Duration(seconds: 3));

    if (userString != "") {
      UserModel user = userModelFromJson(userString);
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomNavigationView(
            user: user,
          ),
        ),
        (route) => false,
      );
    } else {
      // Navigate to Login screen
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false, // Replace with your Dashboard widget
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Task Management',
          style: AppTextStyles.splashText,
        ),
      ),
    );
  }
}
