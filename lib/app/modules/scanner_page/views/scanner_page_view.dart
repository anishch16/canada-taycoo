import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsator/pulsator.dart';
import 'package:taycoo/app/modules/scanner_page/views/search_widget.dart';
import '../../../resources/text_style.dart';
import '../controllers/scanner_page_controller.dart';
import 'custom_app_bar.dart';
import 'empty_list_widget.dart';
import 'initial_list_widget.dart';
import 'order_card.dart';

class ScannerPageView extends GetView<ScannerPageController> {
  const ScannerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      appBar: const CustomAppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SearchWidget(controller: controller),
              controller.isLoading.value
                  ? const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()))
                  : controller.dataNull.value
                      ? const EmptyListWidget()
                      : controller.isInitial.value
                          ? const InitialListWidget()
                          : (controller.responseModelData.value?.data?.firstOrNull?.results ?? []).isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.responseModelData.value?.data?.firstOrNull?.results?.length ?? 0,
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
                                                  pickArea: controller
                                                          .responseModelData.value?.data?.firstOrNull?.results?[index].item?.pickArea?.pickAreaName ??
                                                      "pickAreaName",
                                                  smallText: controller.responseModelData.value?.data?.firstOrNull?.results?[index].item?.smallText ??
                                                      "smallText",
                                                  quantity:
                                                      controller.responseModelData.value?.data?.firstOrNull?.results?[index].quantity.toString() ??
                                                          "quantity",
                                                  orderText: controller.responseModelData.value?.data?.firstOrNull?.orderHeader?.orderNumber ??
                                                      "orderNumber",
                                                  itemText: controller.responseModelData.value?.data?.firstOrNull?.results?[index].item?.itemNumber ??
                                                      "itemID",
                                                  descriptionText:
                                                      controller.responseModelData.value?.data?.firstOrNull?.results?[index].item?.itemDescription ??
                                                          "description",
                                                  colorText: "COLOR",
                                                  plantDateText: "1985-00-99",
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.printDoc(
                                                    pickArea: controller.responseModelData.value?.data?.firstOrNull?.results?[index].item?.pickArea
                                                            ?.pickAreaName ??
                                                        "pickAreaName",
                                                    smallText:
                                                        controller.responseModelData.value?.data?.firstOrNull?.results?[index].item?.smallText ??
                                                            "smallText",
                                                    quantity:
                                                        controller.responseModelData.value?.data?.firstOrNull?.results?[index].quantity.toString() ??
                                                            "quantity",
                                                    orderText: controller.responseModelData.value?.data?.firstOrNull?.orderHeader?.orderNumber ??
                                                        "orderNumber",
                                                    itemText:
                                                        controller.responseModelData.value?.data?.firstOrNull?.results?[index].item?.itemNumber ??
                                                            "itemID",
                                                    descriptionText: controller
                                                            .responseModelData.value?.data?.firstOrNull?.results?[index].item?.itemDescription ??
                                                        "description",
                                                    colorText: "COLOR",
                                                    plantDateText: "1985-00-99",
                                                  );
                                                  // controller.capturePng(index);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor: Colors.orange,
                                                  foregroundColor: Colors.white,
                                                  shape: const StadiumBorder(),
                                                ),
                                                child: Text("Print", style: AppTextTheme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (controller.responseModelData.value?.data?.firstOrNull?.results?.length == (index + 1))
                                          const SizedBox(height: 200)
                                      ],
                                    );
                                  },
                                )
                              : const InitialListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
