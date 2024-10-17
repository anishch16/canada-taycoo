import 'package:flutter/material.dart';

import '../../../resources/text_style.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
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
                "assets/png/no_data.png",
                height: 200,
              ),
              Text(
                "No data found",
                style: AppTextTheme.textTheme.displayMedium?.copyWith(color: Colors.orange),
                textAlign: TextAlign.center,
                maxLines: 3,
              )
            ],
          ),
        ));
  }
}
