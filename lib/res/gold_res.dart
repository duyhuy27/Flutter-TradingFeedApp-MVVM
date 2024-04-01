import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:trading_news/model/gold/gold_model.dart';
import 'package:trading_news/widget/dialog_error.dart';

class GoldRepository {
  final Map<String, GoldModel> _cachedGold = {};

  Future<GoldModel> fetchGoldData(
      BuildContext context, String startDate, String endDate) async {
    // Kiểm tra xem dữ liệu đã được lưu trữ cho category này chưa
    if (_cachedGold.containsKey(startDate)) {
      // Trả về dữ liệu đã lưu trữ cho category này
      return _cachedGold[startDate]!;
    }

    String url =
        "https://api.metals.dev/v1/timeseries?api_key=3ZAAYRRPI3ILSFAGQGIY165AGQGIY&start_date=$startDate&end_date=$endDate";

    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final goldModel = GoldModel.fromJson(body);
        // Cập nhật dữ liệu đã lưu trữ cho category này
        _cachedGold[startDate] = goldModel;
        return goldModel;
      } else if (response.statusCode == 429) {
        print('rate time limit');
        showNoConnectionDialog(
            context, 'API rate limit exceeded. Please try again later.');
      } else {
        showNoConnectionDialog(
            context, 'Failed to fetch gold data. Please try again later.');
      }
    } catch (e) {
      print('Network error: $e');
      showNoConnectionDialog(
          context, 'Network error. Please check your internet connection.');
    }

    throw Exception('Error');
  }
}
