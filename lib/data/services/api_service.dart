import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volv_message/models/associated_drug.dart';
import 'package:volv_message/notifiers/medicine_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:volv_message/utils/internet_connection.dart';
import 'package:volv_message/utils/snack_bar_view.dart';

class ApiService {
  static const String apiEndpoint =
      "https://run.mocky.io/v3/d497251a-8a41-4df1-8712-c567ec9adf3c";

  static getMedicine(
      MedicineNotifier medicineNotifier, BuildContext context) async {
    if (await InternetConnection.check(context)) {
      http.get(Uri.parse(apiEndpoint)).then((response) {
        if (response.statusCode == 200) {
          var dMed = jsonDecode(response.body);
          _associatedDrugList.clear();
          arrayConvert(dMed);

          medicineNotifier.setDragList(_associatedDrugList);
        } else {
          showSnackBar('Something want wrong, Error code: ${response.statusCode}');
        }
      });
    }
  }

  static final List<AssociatedDrug> _associatedDrugList = <AssociatedDrug>[];

  /// convert json to desired drug list
  static arrayConvert(Map<String, dynamic> json) {
    json.forEach((key, value) {
      debugPrint('keys :: $key => ${key.contains('associatedDrug')}');

      if (key.contains('associatedDrug')) {
        debugPrint('json parce :: ${value[0]}');
        _associatedDrugList.add(AssociatedDrug.fromJson(value[0]));
      }

      var obj = json[key];

      if (obj != null) {
        if (obj is List) {
          obj.forEach((element) {
            arrayConvert(element);
          });
        } else {
          if (obj is Map<String, dynamic>) {
            arrayConvert(obj);
          }
        }
      }
    });
  }
}
