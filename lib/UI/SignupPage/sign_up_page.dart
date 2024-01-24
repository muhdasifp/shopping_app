import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping_app/Constant/widget/custom_button.dart';
import 'package:shoping_app/Controller/authController/auth%20controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your Name';
                          }
                          return null;
                        },
                        controller: authController.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Name',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmail) {
                            return null;
                          } else if (value.isEmpty) {
                            return 'Please enter Email';
                          } else {
                            return 'Please enter a valid email!';
                          }
                        },
                        controller: authController.email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Password';
                          } else if (value.length < 6) {
                            return 'Length is to Short minimum 6 character need';
                          }
                          return null;
                        },
                        controller: authController.password,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline)),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            } else if (value.length < 6) {
                              return 'Length is to Short minimum 6 character need';
                            } else if (authController.confirmPassword.text !=
                                authController.password.text) {
                              return 'Password not Match ';
                            }
                            return null;
                          },
                          controller: authController.confirmPassword,
                          obscureText: authController.secure.value,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: 'Confirm Password',
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
                        text: 'SIGN UP',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.signupWithEmail();
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
                    const Text('Already have a Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('SIGN IN'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
