import 'package:flutter/material.dart';
import 'package:task_application/core/utils/gaps.dart';
import 'package:task_application/core/utils/show_message.dart';
import 'package:task_application/core/utils/text_styles.dart';
import 'package:task_application/core/widgets/custom_button.dart';
import 'package:task_application/core/widgets/custom_textfield.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/Authentication_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome back !!",
                style: AppTextStyles.headline1,
              ),
              largeVerticalGap(),
              CustomTextField(
                labelText: "Email",
                hintText: "Enter your email",
                controller: _emailController,
                validate: true,
              ),
              mediumVerticalGap(),
              CustomTextField(
                labelText: "Password",
                hintText: "Enter your password",
                controller: _passwordController,
                obscureText: true,
                validate: true,
              ),
              largeVerticalGap(),
              CustomButton(
                text: "Login",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    try {
                      await ref
                          .read(authProvider.notifier)
                          .login(email, password);
                    } catch (error) {
                      showMessage(
                        message: "Login failed: ${error.toString()}",
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
