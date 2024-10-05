import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 24),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      hintText: "Email address",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.orange,
                      ),
                      suffixIcon: Icon(
                        Icons.mail,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                      hintText: "Password",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.orange,
                      ),
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.SCANNER_PAGE),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const StadiumBorder(),
              ),
              child: const Text("Sign In"),
            ),
            const SizedBox(height: 16.0),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
