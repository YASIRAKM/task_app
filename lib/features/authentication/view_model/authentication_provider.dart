import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:task_application/bottom_navigation_view.dart';
import 'package:task_application/common_providers/common_providers.dart';
import 'package:task_application/core/utils/show_message.dart';

import 'package:task_application/data/repository/api_repository.dart';
import 'package:task_application/features/authentication/model/user_model.dart';

import 'package:task_application/main.dart';
import 'package:task_application/splash_screen.dart';

class AuthNotifier extends AsyncNotifier {
  Future<void> login(email, password) async {
    ref.read(loadingProvider.notifier).state = true;

    try {
      UserModel user = await ApiRepository.login(email, password);
      if (user.name.isNotEmpty) {
        await SharedPrefHelper.saveValue("token", user.token);
        await SharedPrefHelper.saveValue("user", jsonEncode(user));
        ref.read(loadingProvider.notifier).state = false;
        navigatorKey.currentState!.pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => BottomNavigationView(user: user),
          ),
          (route) => false,
        );
        showMessage(message: "Logged  in");
      } else {
        ref.read(loadingProvider.notifier).state = false;

        showMessage(message: "Login  Failed");

        throw Exception("something went wrong");
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      showMessage(message: "Log in  Failed${e.toString()}");
    }
  }

  Future<void> logout() async {
    bool isLoggedOut = await SharedPrefHelper.clearValue("token");
    if (isLoggedOut) {
      showMessage(message: "Logged out succesfully");
      navigatorKey.currentState!.pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false,
      );
    } else {
      showMessage(message: "Logged out failed");
    }
  }

  @override
  Future build() {
    return Future.delayed(const Duration(milliseconds: 1));
  }
}

final authProvider =
    AsyncNotifierProvider<AuthNotifier, void>(() => AuthNotifier());
