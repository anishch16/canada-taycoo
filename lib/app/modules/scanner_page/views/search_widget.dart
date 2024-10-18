import 'package:flutter/material.dart';

import '../../../resources/text_style.dart';
import '../controllers/scanner_page_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
  });

  final ScannerPageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: controller.searchController,
                cursorColor: Colors.orange,
                onChanged: (value) {
                  controller.searchController.text = value;
                },
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 8.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.orange,
                      ),
                    ),
                    suffixIcon: controller.searchController.text.isEmpty
                        ? const SizedBox(
                            height: 0,
                            width: 0,
                          )
                        :  Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: (){
                                controller.searchController.clear();
                                controller.isInitial.value = true;
                                controller.dataNull.value = false;
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.orange),
                    ),
                    labelText: "Order ID",
                    labelStyle: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.orange)),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          GestureDetector(
            onTap: () {
              controller.searchController.text.isNotEmpty ? controller.getCardList(orderId: "?search=${controller.searchController.text}") : null;
            },
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                  child: Text(
                "Search",
                style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
