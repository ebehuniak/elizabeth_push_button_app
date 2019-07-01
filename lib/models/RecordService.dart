import 'RecordList.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class RecordService {
  Future<String> _loadRecordsAsset() async {
    return await rootBundle.loadString('assets/data/records.json');
  }

  //the loadRecords() function parses the records.json file
  //it also and maps it into a recordsList object that holds
  //a list of Record objects
  //"Future" is used to perform asynchronous operation in Dart
  //Future objects (futures) represent the results of asynchronous operations.
  Future<RecordList> loadRecords() async {
    String jsonString = await _loadRecordsAsset();
    final jsonResponse = json.decode(jsonString);
    RecordList records = new RecordList.fromJson(jsonResponse);
    return records;
  }
}
