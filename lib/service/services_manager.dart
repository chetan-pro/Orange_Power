// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:orange_power_task/util/constant.dart';
import 'package:orange_power_task/model/tariff_model.dart';

Future getTariffList({periodFrom, periodTo}) async {
  var client = http.Client();
  try {
    var response = await client.get(Constants.baseUrl +
        "period_from=${periodFrom}T00:00:00Z&period_to=${periodTo}T00:00:00Z");

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return TariffData.fromJson(jsonMap).results;
    }
  } catch (e) {
    return null;
  }
  return null;
}
