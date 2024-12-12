import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_application/common_providers/common_providers.dart';
import 'package:task_application/core/constants/color_strings.dart';
import 'package:task_application/features/authentication/model/user_model.dart';
import 'package:task_application/features/authentication/view/profile_view.dart';
import 'package:task_application/features/task_management/view/task_view.dart';

class BottomNavigationView extends ConsumerWidget {
  final UserModel user;
  BottomNavigationView({super.key, required this.user});
  final BottomNavigationBarType _bottomNavType = BottomNavigationBarType.fixed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(indexProvider);
    return Scaffold(
      body: index == 1
          ? ProfileView(
              user: user,
            )
          : const TaskView(),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          iconSize: 25,
          backgroundColor: AppColors.background,
          currentIndex: index,
          selectedItemColor: AppColors.bottomBarSelectedColor,
          unselectedItemColor: AppColors.bottomBarunSelectedColor,
          type: _bottomNavType,
          onTap: (index) {
            ref.read(indexProvider.notifier).state = index;
          },
          items: _navBarItems),
    );
  }
}

const List<BottomNavigationBarItem> _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.bookmark),
    activeIcon: Icon(CupertinoIcons.bookmark_solid),
    label: 'Tasks',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.person_alt_circle),
    activeIcon: Icon(CupertinoIcons.person_alt_circle_fill),
    label: 'Profile',
  )
];
