import 'dart:math';
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../resources/text_style.dart';
import '../../../resources/utils.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/order_card.dart';
import '../controllers/scanner_page_controller.dart';

class ScannerPageView extends GetView<ScannerPageController> {
  const ScannerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () => controller.scanBarcode(),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
          child: const Icon(
            Icons.qr_code_2,
            size: 34,
            color: Colors.white,
          ),
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
                : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
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
                    ),
                )
          ],
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

class QrScannerOverlayShape extends ShapeBorder {
  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 3.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    double? cutOutSize,
    double? cutOutWidth,
    double? cutOutHeight,
    this.cutOutBottomOffset = 0,
  })  : cutOutWidth = cutOutWidth ?? cutOutSize ?? 250,
        cutOutHeight = cutOutHeight ?? cutOutSize ?? 250 {
    assert(
      borderLength <= min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2,
      "Border can't be larger than ${min(this.cutOutWidth, this.cutOutHeight) / 2 + borderWidth * 2}",
    );
    assert((cutOutWidth == null && cutOutHeight == null) || (cutOutSize == null && cutOutWidth != null && cutOutHeight != null),
        'Use only cutOutWidth and cutOutHeight or only cutOutSize');
  }

  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutWidth;
  final double cutOutHeight;
  final double cutOutBottomOffset;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final mBorderLength = borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2 ? borderWidthSize / 2 : borderLength;
    final mCutOutWidth = cutOutWidth < width ? cutOutWidth : width - borderOffset;
    final mCutOutHeight = cutOutHeight < height ? cutOutHeight : height - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - mCutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset + rect.top + height / 2 - mCutOutHeight / 2 + borderOffset,
      mCutOutWidth - borderOffset * 2,
      mCutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + mBorderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + mBorderLength,
          cutOutRect.top + mBorderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - mBorderLength,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - mBorderLength,
          cutOutRect.left + mBorderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
