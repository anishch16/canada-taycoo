import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../resources/text_style.dart';
import '../../../resources/validators.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.08),
                    Image.asset(
                      "assets/png/logo.png",
                      height: 100,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.08),
                    Text(
                      "Sign Up",
                      style: AppTextTheme.textTheme.displayLarge?.copyWith(color: Colors.orange),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Form(
                      key: controller.signUpFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: Colors.orange,
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (string) => Validator.validateIsEmpty(string: string ?? ""),
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                              enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                              border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                              hintText: "Email address",
                              hintStyle: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.orange),
                              suffixIcon: const Icon(
                                Icons.mail,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Obx(() {
                              return TextFormField(
                                cursorColor: Colors.orange,
                                controller: controller.passwordController,
                                obscuringCharacter: "*",
                                obscureText: controller.passwordVisible.value,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (string) => Validator.validatePassword(string: string ?? ""),
                                decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  hintText: "Password",
                                  hintStyle: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.orange),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.passwordVisible.value = !controller.passwordVisible.value;
                                    },
                                    child: Icon(
                                      !controller.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Obx(() {
                              return TextFormField(
                                cursorColor: Colors.orange,
                                controller: controller.confirmPasswordController,
                                obscuringCharacter: "*",
                                obscureText: controller.confirmPasswordVisible.value,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (string) => Validator.confirmPassword(password: controller.passwordController.text, cPassword: string ?? ""),
                                decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  hintText: "Confirm Password",
                                  hintStyle: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.orange),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      controller.confirmPasswordVisible.value = !controller.confirmPasswordVisible.value;
                                    },
                                    child: Icon(
                                      !controller.confirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (controller.signUpFormKey.currentState!.validate()) {
                                  controller.signUp(
                                      email: controller.emailController.text,
                                      password: controller.passwordController.text,
                                      confirmPassword: controller.confirmPasswordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Sign Up"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text.rich(
                                const TextSpan(
                                  text: "Already have an account? ",
                                  children: [
                                    TextSpan(
                                      text: "Sign in",
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ],
                                ),
                                style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        Obx(() {
          if(controller.isLogging.value) {
            return const Opacity(
              opacity: 0.4,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            );
          } else {
            return const SizedBox();
          }
        }),
        Align(
          alignment: Alignment.center,
          child: Obx(() {
            if(controller.isLogging.value) {
              return const CircularProgressIndicator();
            } else {
              return const SizedBox();
            }
          }),
        ),
      ],
    );
  }
}
