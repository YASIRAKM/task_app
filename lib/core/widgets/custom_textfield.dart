import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_application/common_providers/common_providers.dart';
import 'package:task_application/core/constants/color_strings.dart';
import 'package:task_application/core/utils/date_helper.dart';

class CustomTextField extends ConsumerWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool obscureText;
  final bool isReadOnly;
  final int maxLines;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  bool validate;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return TextFormField(
      controller: controller,
      obscureText: obscureText ? !isPasswordVisible : false,
      keyboardType: keyboardType,
      validator: validate
          ? (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              if (labelText == 'Email' &&
                  !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              if (labelText == 'Password' && value.length < 6) {
                return 'Passwrd lenght is 6';
              }
              // You can add custom validation logic for other fields if needed
              return null;
            }
          : null,
      readOnly: isReadOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: AppColors.textFieldBorder),
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: AppColors.textFieldBorder,
                  ),
                  onPressed: () {
                    // Toggle the password visibility when the icon is pressed
                    ref.read(passwordVisibilityProvider.notifier).state =
                        !isPasswordVisible;
                  },
                )
              : suffixIcon,
          border: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // Make edges rounded
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldBorder),
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // Rounded corners
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.button),
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // Rounded corners
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ))),
    );
  }
}

class CustomDatePickerField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  bool validate;

  CustomDatePickerField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validate = false,
    super.key,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateHelper.formatToDDMMYYYY(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true, // Prevent manual editing
      onTap: () => _selectDate(context), // Show date picker on tap
      validator: validate
          ? (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          // prefixIcon:
          //     const Icon(Icons.calendar_today, color: AppColors.textFieldBorder),
          border: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // Make edges rounded
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldBorder),
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // Rounded corners
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.button),
            borderRadius:
                BorderRadius.all(Radius.circular(10)), // Rounded corners
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ))),
    );
  }
}
