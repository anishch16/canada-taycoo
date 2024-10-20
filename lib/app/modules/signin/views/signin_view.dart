import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../resources/text_style.dart';
import '../../../resources/validators.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Spacer(flex: 2),
                Image.asset(
                  "assets/png/logo.png",
                  height: 146,
                ),
                const SizedBox(height: 24),
                Form(
                  key: controller.signInFormKey,
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
                      const SizedBox(height: 24),
                      Obx(() {
                        return TextFormField(
                          cursorColor: Colors.orange,
                          controller: controller.passwordController,
                          obscuringCharacter: "*",
                          obscureText: controller.passwordVisible.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (string) => Validator.validateIsEmpty(string: string ?? ""),
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
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (controller.signInFormKey.currentState!.validate()) {
                      controller.signIn(email: controller.emailController.text, password: controller.passwordController.text);
                    } else {
                      Get.rawSnackbar(
                        message: "Please input correct inputs",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: Text("Sign In", style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SIGN_UP);
                  },
                  child: Text.rich(
                      const TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                      style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.black)),
                ),

                const Spacer(flex: 2),
              ],
            ),
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
