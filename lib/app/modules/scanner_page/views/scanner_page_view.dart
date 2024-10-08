import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsator/pulsator.dart';

// import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../resources/text_style.dart';
import '../../home/views/order_card.dart';
import '../controllers/scanner_page_controller.dart';

class ScannerPageView extends GetView<ScannerPageController> {
  const ScannerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () => controller.scanBarcode(),
        child: const PulseIcon(
          icon: Icons.qr_code_scanner,
          pulseColor: Colors.orange,
          iconColor: Colors.white,
          iconSize: 34,
          innerSize: 64,
          pulseSize: 116,
          pulseCount: 1,
          pulseDuration: Duration(seconds: 4),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 100,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)), color: Colors.orange),
            child: Text(
              "Furniture Manufacturer",
              style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            "assets/png/logo.png",
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.orange,
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
                  Container(
                    height: 50,
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
                  )
                ],
              ),
            ),
            controller.responseModelData.value?.data == null
                ? Center(
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
                  ))
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.responseModelData.value?.data?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RepaintBoundary(
                                    key: controller.globalKeys[index],
                                    child: OrderCard(
                                      pickArea: controller.responseModelData.value?.data?.items?[index].pickArea?.pickAreaName ?? "",
                                      smallText: controller.responseModelData.value?.data?.items?[index].smallText ?? "smallText",
                                      quantity: controller.responseModelData.value?.data?.items?[index].quantity ?? "quantity",
                                      orderText: controller.responseModelData.value?.data?.orderId ?? "orderId",
                                      itemText: controller.responseModelData.value?.data?.items?[index].itemId ?? "itemID",
                                      descriptionText: controller.responseModelData.value?.data?.items?[index].itemDescription ?? "description",
                                      colorText: "COLOR",
                                      plantDateText: controller.responseModelData.value?.data?.planeDate ?? "1985-00-99",
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.capturePng(0);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.white,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text("Download"),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.responseModelData.value?.data?.items?.length == (index + 1)) const SizedBox(height: 200)
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
