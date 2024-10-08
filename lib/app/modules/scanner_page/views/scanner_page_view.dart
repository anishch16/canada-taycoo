import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsator/pulsator.dart';
import '../../../resources/text_style.dart';
import '../controllers/scanner_page_controller.dart';
import 'order_card.dart';

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
        scrolledUnderElevation: 0,
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
                        controller: controller.searchController,
                        cursorColor: Colors.orange,
                        onChanged: (value) {
                          controller.searchController.text = value;
                        },
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
                  GestureDetector(
                    onTap: () {
                      controller.searchController.text.isNotEmpty
                          ? controller.getCardList(orderId: "?search=${controller.searchController.text}")
                          : null;
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
            controller.isLoading.value
                ? const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()))
                : controller.responseModelData.value?.results == null
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
            : (controller.responseModelData.value?.results ?? []).isEmpty ?
            Center(
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
                ))
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.responseModelData.value?.results?.length ?? 0,
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
                                          pickArea:
                                              controller.responseModelData.value?.results?[index].item?.pickArea?.pickAreaName ?? "pickAreaName",
                                          smallText: controller.responseModelData.value?.results?[index].item?.smallText ?? "smallText",
                                          quantity: controller.responseModelData.value?.results?[index].quantity.toString() ?? "quantity",
                                          orderText: controller.responseModelData.value?.results?[index].orderHeader?.orderNumber ?? "orderId",
                                          itemText: controller.responseModelData.value?.results?[index].item?.itemNumber ?? "itemID",
                                          descriptionText: controller.responseModelData.value?.results?[index].item?.itemDescription ?? "description",
                                          colorText: "COLOR",
                                          plantDateText: controller.responseModelData.value?.results?[index].orderHeader?.planDate ?? "1985-00-99",
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.capturePng(index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Colors.orange,
                                          foregroundColor: Colors.white,
                                          shape: const StadiumBorder(),
                                        ),
                                        child: Text("Download", style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                                if (controller.responseModelData.value?.results?.length == (index + 1)) const SizedBox(height: 200)
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
