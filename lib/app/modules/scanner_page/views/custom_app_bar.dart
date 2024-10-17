import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
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
                  Get.offAllNamed(Routes.SIGN_UP);
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
