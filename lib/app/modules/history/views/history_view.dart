import 'dart:developer';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taycoo/app/resources/text_style.dart';
import '../../../resources/utils.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text("Search History"),
        actions: [
          if (controller.searchRecordsList.isNotEmpty)
            IconButton(
              onPressed: () async {
                final box = GetStorage();
                await box.write('search_table', []);
                Get.back();
                log('Search table cleared');
              },
              icon: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.deepOrange),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  "Clear History",
                  style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: controller.searchRecordsList.isEmpty
            ? const Center(
                child: Text("No search history found"),
              )
            : ListView(
                children: [
                  // SearchTable(records: controller.searchRecordsList),
                  // For demo
                  ...List.generate(
                    controller.searchRecordsList.length,
                    (index) => HistoryCard(
                      index: (index + 1),
                      name: controller.searchRecordsList[index].searchedItemNumber,
                      time: controller.timeAgo(controller.searchRecordsList[index].searchedTime),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.name,
    required this.time,
    required this.index,
  });

  final String name, time;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: (index % 2) == 0 ? Colors.grey.shade50 : Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
            ),
            child: Text(index.toString(), style: AppTextTheme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
          ),
          SvgPicture.string(
            buildBarcodeSvg(Barcode.qrCode(), name),
            height: 40,
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order id: $name",
                style: AppTextTheme.textTheme.titleLarge,
              ),
              Text(
                time,
                style: AppTextTheme.textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),

      // const Icon(Icons.qr_code_2_outlined)
    );
  }
}
