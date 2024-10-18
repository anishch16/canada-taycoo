class SearchRecord {
  final String searchedItemNumber;
  final DateTime searchedTime;

  SearchRecord({required this.searchedItemNumber, required this.searchedTime});

  // Convert SearchRecord to JSON format
  Map<String, dynamic> toJson() => {
    'searchedItemNumber': searchedItemNumber,
    'searchedTime': searchedTime.toIso8601String(),
  };

  // Convert JSON to SearchRecord
  factory SearchRecord.fromJson(Map<String, dynamic> json) {
    return SearchRecord(
      searchedItemNumber: json['searchedItemNumber'],
      searchedTime: DateTime.parse(json['searchedTime']),
    );
  }
}
