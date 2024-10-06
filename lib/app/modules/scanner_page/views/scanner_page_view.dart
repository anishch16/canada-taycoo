import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsator/pulsator.dart';

// import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../resources/text_style.dart';
import '../../../routes/app_pages.dart';
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
            padding: const EdgeInsets.only(left: 32, right: 16, top: 8, bottom: 8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)), color: Colors.orange),
            child: Text(
              "Scanned Items List",
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
        () => SingleChildScrollView(
          child: Column(
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
              controller.scanResult.value == null
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
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
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
                            children: [
                              RepaintBoundary(
                                key: controller.globalKeys[0],
                                child: OrderCard(
                                  orderText: controller.scanResult.value!.rawContent.toString(),
                                  itemText: controller.scanResult.value!.rawContent.toString(),
                                  descriptionText: "DESCRIPTION LONG LOREM IPSUM DOLOR SIT MET CONSECTETUR ADIPISSED DO EIUS",
                                  colorText: "COLOR",
                                  plantDateText: "1985-00-99",
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                  ElevatedButton(
                                    onPressed: () => Get.toNamed(Routes.HOME),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.white,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text("Upload"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      // const ListTile(
                      //   title: Text('Camera selection'),
                      //   dense: true,
                      //   enabled: false,
                      // ),
                      // RadioListTile(
                      //   onChanged: (v) => controller.selectedCamera.value = -1,
                      //   value: -1,
                      //   title: const Text('Default camera'),
                      //   groupValue: controller.selectedCamera.value,
                      // ),
                      // ...List.generate(
                      //   controller.numberOfCameras.value,
                      //       (i) => RadioListTile(
                      //     onChanged: (v) => controller.selectedCamera.value = i,
                      //     value: i,
                      //     title: Text('Camera ${i + 1}'),
                      //     groupValue: controller.selectedCamera.value,
                      //   ),
                      // ),
                      // const ListTile(
                      //   title: Text('Button Texts'),
                      //   dense: true,
                      //   enabled: false,
                      // ),
                      // ListTile(
                      //   title: TextField(
                      //     decoration: const InputDecoration(
                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       labelText: 'Flash On',
                      //     ),
                      //     controller: controller.flashOnController,
                      //   ),
                      // ),
                      // ListTile(
                      //   title: TextField(
                      //     decoration: const InputDecoration(
                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       labelText: 'Flash Off',
                      //     ),
                      //     controller: controller.flashOffController,
                      //   ),
                      // ),
                      // ListTile(
                      //   title: TextField(
                      //     decoration: const InputDecoration(
                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                      //       labelText: 'Cancel',
                      //     ),
                      //     controller: controller.cancelController,
                      //   ),
                      // ),
                      // if (Platform.isAndroid) ...[
                      //   const ListTile(
                      //     title: Text('Android specific options'),
                      //     dense: true,
                      //     enabled: false,
                      //   ),
                      //   ListTile(
                      //     title: Text(
                      //       'Aspect tolerance (${controller.aspectTolerance.value.toStringAsFixed(2)})',
                      //     ),
                      //     subtitle: Slider(
                      //       min: -1,
                      //       value: controller.aspectTolerance.value,
                      //       onChanged: (value) {
                      //         controller.aspectTolerance.value = value;
                      //       },
                      //     ),
                      //   ),
                      //   CheckboxListTile(
                      //     title: const Text('Use autofocus'),
                      //     value: controller.useAutoFocus.value,
                      //     onChanged: (checked) {
                      //       controller.useAutoFocus.value = checked!;
                      //     },
                      //   ),
                      // ],
                      // const ListTile(
                      //   title: Text('Other options'),
                      //   dense: true,
                      //   enabled: false,
                      // ),
                      // CheckboxListTile(
                      //   title: const Text('Start with flash'),
                      //   value: controller.autoEnableFlash.value,
                      //   onChanged: (checked) {
                      //     controller.autoEnableFlash.value = checked!;
                      //   },
                      // ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
// class ScannerPageView extends GetView<ScannerPageController> {
//   const ScannerPageView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.orange,
//       //   elevation: 0,
//       //   title: Row(
//       //     children: [
//       //       Icon(Icons.qr_code_scanner, color: Colors.white),
//       //       SizedBox(width: 8),
//       //       Text(
//       //         'Scanner Page',
//       //         style: AppTextTheme.textTheme.displaySmall!.copyWith(color: Colors.white),
//       //       ),
//       //     ],
//       //   ),
//       //   centerTitle: false,
//       // ),
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller.mobileScannerController,
//             onDetect: (BarcodeCapture capture) {
//               final List<Barcode> barcodes = capture.barcodes;
//               final String? barcodeValue = barcodes.first.rawValue;
//               if (barcodeValue != null) {
//                 // handle barcode scan
//               }
//             },
//             overlayBuilder: (context, constraints) {
//               return Container(
//                 decoration: ShapeDecoration(
//                   shape: QrScannerOverlayShape(
//                     borderColor: Colors.blueAccent,
//                     borderWidth: 4.0,
//                     overlayColor: const Color.fromRGBO(0, 0, 0, 70),
//                     cutOutWidth: 280,
//                     cutOutHeight: 280,
//                     cutOutBottomOffset: 0,
//                   ),
//                 ),
//               );
//             },
//           ),
//
//           Obx(() {
//             return Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: controller.searchByNumber.value
//                   ? Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//                         color: Colors.orange,
//                       ),
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               Flexible(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: SizedBox(
//                                     height: 55,
//                                     child: TextFormField(
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(25.0),
//                                         ),
//                                         labelText: "Order ID",
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Get.offAllNamed(Routes.HOME);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   minimumSize: Size(55, 55),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                   ),
//                                   backgroundColor: Colors.black,
//                                 ),
//                                 child: Icon(Icons.search, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   : Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                       child: ElevatedButton(
//                         onPressed: () => controller.searchByNumber.value = true,
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           backgroundColor: Colors.orange,
//                           foregroundColor: Colors.white,
//                           minimumSize: const Size(double.infinity, 48),
//                           shape: const StadiumBorder(),
//                         ),
//                         child: const Text("Search by number"),
//                       ),
//                     ),
//             );
//           }),
//           Positioned(
//             left: 0,
//             top: 0,
//             right: 0,
//             child: SizedBox(
//               width: double.infinity,
//               child: Center(
//                   child: SafeArea(
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 24),
//                         child: Image.asset("assets/png/logo.png", width: 100, height: 100),
//                       ))),
//             ),),
//         ],
//       ),
//     );
//   }
// }

