
import 'package:doodleblue/utils/constants.dart';
import 'package:doodleblue/views/business_list.dart';
import 'package:doodleblue/views/common_widget/custom_button.dart';
import 'package:doodleblue/views/common_widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Username',
              controller: usernameController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Password',
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Login',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BusinessList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}