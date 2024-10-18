import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../data/remote/models/search_record_model.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final count = 0.obs;
  var searchRecordsList = <SearchRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStoredSearchRecords();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  getStoredSearchRecords() async {
    final box = GetStorage();
    List<dynamic>? searchRecordsJson = box.read<List<dynamic>>('search_table')?.cast<dynamic>();

    if (searchRecordsJson == null) {
      return [];
    }
    List<SearchRecord> searchRecords = searchRecordsJson.map((jsonString) => SearchRecord.fromJson(json.decode(jsonString))).toList();
    searchRecordsList.value = searchRecords;
  }

  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else if (diff.inSeconds > 0) {
      return '${diff.inSeconds} second${diff.inSeconds > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

}
