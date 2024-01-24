import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Constant/widget/custom_button.dart';
import 'package:shoping_app/Controller/authController/auth%20controller.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmail) {
                          return null;
                        } else if (value.isEmpty) {
                          return 'Please enter Email';
                        } else {
                          return 'Please enter a valid Email!';
                        }
                      },
                      controller: authController.loginEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Password';
                          } else if (value.length < 6) {
                            return 'Length is to Short minimum 6 character need';
                          }
                          return null;
                        },
                        controller: authController.loginPassword,
                        obscureText: authController.secure.value,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  authController.secure.value =
                                      !authController.secure.value;
                                },
                                icon: authController.secure.value
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            prefixIcon: const Icon(Icons.lock_outline)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'SIGN IN',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          authController.loginWithEmail();
                        } else {
                          return;
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Dont\'t have Account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signup');
                    },
                    child: const Text('SIGNUP'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
