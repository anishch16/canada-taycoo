import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../resources/text_style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/scanner_page_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScannerPageController controller;

  const CustomAppBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      leadingWidth: 100,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.HISTORY);
                },
                child: const Icon(
                  Icons.history,
                  size: 34,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Log Out?"),
                        content: const Text("Are you sure to log out?"),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white, shape: const StadiumBorder(side: BorderSide(color: Colors.orange))),
                            child: Text("Cancel", style: AppTextTheme.textTheme.titleMedium?.copyWith(color: Colors.orange)),
                            onPressed: () {
                              Get.back(); // Close the dialog
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(backgroundColor: Colors.orange),
                            child: Text("Log Out", style: AppTextTheme.textTheme.titleMedium?.copyWith(color: Colors.white)),
                            onPressed: () async {
                              await controller.clearData();
                              Get.offAllNamed(Routes.SIGNIN); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.logout,
                  size: 34,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset(
          "assets/png/logo.png",
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
