import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:barcode/barcode.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/remote/api_client.dart';
import 'package:http/http.dart' as http;
import '../../../data/remote/models/data_success_model.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../../../data/remote/models/search_record_model.dart';
import '../../../resources/utils.dart';
import '../views/printable.dart';

class ScannerPageController extends GetxController {
  var scanResult = Rx<ScanResult?>(null);
  var responseModelData = Rx<ResponseModel?>(null);
  var aspectTolerance = 0.00.obs;
  var numberOfCameras = 0.obs;
  var selectedCamera = (-1).obs;
  var useAutoFocus = true.obs;
  var autoEnableFlash = false.obs;
  var globalKeys = [].obs;
  var isLoading = false.obs;
  var dataNull = false.obs;
  var isInitial = false.obs;
  final TextEditingController searchController = TextEditingController();
  final flashOnController = TextEditingController(text: 'Flash on');
  final flashOffController = TextEditingController(text: 'Flash off');
  final cancelController = TextEditingController(text: 'Cancel');

  static final _possibleFormats = BarcodeFormat.values.toList()..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void onInit() {
    super.onInit();
    _getNumberOfCameras();
  }

  Future<void> _getNumberOfCameras() async {
    numberOfCameras.value = await BarcodeScanner.numberOfCameras;
  }

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': cancelController.text,
            'flash_on': flashOnController.text,
            'flash_off': flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: selectedCamera.value,
          autoEnableFlash: autoEnableFlash.value,
          android: AndroidOptions(
            aspectTolerance: aspectTolerance.value,
            useAutoFocus: useAutoFocus.value,
          ),
        ),
      );
      scanResult.value = result;
      if (scanResult.value?.type.toString() != "Cancelled") {
        getCardList(orderId: scanResult.value!.rawContent.isNotEmpty ? "?search=${scanResult.value!.rawContent}" : "");
      }
    } on PlatformException catch (e) {
      scanResult.value = ScanResult(
        rawContent: e.code == BarcodeScanner.cameraAccessDenied ? 'The user did not grant the camera permission!' : 'Unknown error: $e',
      );
    }
  }

  Future<Uint8List> svgToPng(String svgString, BuildContext context) async {
    final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), context);
    final image = await pictureInfo.picture.toImage(150, 150);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }
    final pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  Future<void> printDoc({
    required String orderText,
    required String itemText,
    required String descriptionText,
    required String colorText,
    required String plantDateText,
    required String smallText,
    required String pickArea,
    required String quantity,
  }) async {
    String svgQrCode = buildBarcodeSvg(Barcode.qrCode(), '$orderText|$itemText');
    Uint8List qrCodePng = await svgToPng(svgQrCode, Get.context!);
    final doc = pw.Document();
    final qrCodeImage = pw.MemoryImage(qrCodePng);
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (pw.Context context) {
          return buildPrintableData(
            image: qrCodeImage,
            orderText: orderText,
            itemText: itemText,
            descriptionText: descriptionText,
            smallText: smallText,
            pickArea: pickArea,
            plantDateText: plantDateText,
            quantity: quantity,
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  getCardList({String? orderId}) async {
    isLoading.value = true;
    isInitial.value = false;
    log("orderId: $orderId");
    try {
      http.Response response = await ApiClient().getRequest("https://django-project-weld.vercel.app/app/orderheader-info/$orderId");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        ResponseModel responseModel = ResponseModel.fromJson(jsonData);
        responseModelData.value = responseModel;
        await storeSearchRecord(orderId?.split('=')[1] ?? "");
        globalKeys.value = List.generate(responseModel.data?.firstOrNull?.results?.length ?? 0, (index) => GlobalKey());
        isLoading.value = false;
        if (responseModel.data!.isEmpty) {
          dataNull.value = true;
        } else {
          dataNull.value = false;
        }
      } else {
        log('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
  }

  Future<void> storeSearchRecord(String searchedItemNumber) async {
    final box = GetStorage();
    DateTime searchedTime = DateTime.now();
    SearchRecord newRecord = SearchRecord(
      searchedItemNumber: searchedItemNumber,
      searchedTime: searchedTime,
    );
    List<dynamic>? searchRecordsJson = box.read<List<dynamic>>('search_table')?.cast<dynamic>();
    List<SearchRecord> searchRecords =
        searchRecordsJson == null ? [] : searchRecordsJson.map((jsonString) => SearchRecord.fromJson(json.decode(jsonString))).toList();
    searchRecords.add(newRecord);
    await box.write('search_table', searchRecords.map((record) => json.encode(record.toJson())).toList());
  }
}
