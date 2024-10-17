import 'package:flutter/material.dart';

import '../../../resources/text_style.dart';

class InitialListWidget extends StatelessWidget {
  const InitialListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Image.asset(
                "assets/png/scanning.png",
                height: 200,
              ),
              Text(
                "Use Search or Scanner to get the ordered card details",
                style: AppTextTheme.textTheme.displayMedium?.copyWith(color: Colors.orange),
                textAlign: TextAlign.center,
                maxLines: 3,
              )
            ],
          ),
        ));
  }
}
