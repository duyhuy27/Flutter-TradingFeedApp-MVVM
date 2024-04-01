import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/model/gold/gold_model.dart';
import 'package:trading_news/pages/market_coin/components/gold/item_gold.dart';
import 'package:trading_news/widget/dialog_error.dart';

class GoldMarketScreen extends StatefulWidget {
  const GoldMarketScreen({Key? key}) : super(key: key);

  @override
  _GoldMarketScreenState createState() => _GoldMarketScreenState();
}

class _GoldMarketScreenState extends State<GoldMarketScreen> {
  late String currentTime;
  late String startDate;
  late String endDate;
  GoldModel? goldData;
  bool _isGoldDataLoaded = false;

  @override
  void initState() {
    super.initState();
    currentTime = getCurrentTimeFormatted();
    var currentDate = DateTime.now();
    var startDateCalculation = currentDate.subtract(const Duration(days: 30));
    startDate = DateFormat('yyyy-MM-dd').format(startDateCalculation);
    endDate = DateFormat('yyyy-MM-dd').format(currentDate);
    goldData = null;
    fetchGoldData();
  }

  String getCurrentTimeFormatted() {
    var now = DateTime.now();
    var formattedDate = DateFormat('HH:mm, dd/MM/yyyy').format(now);
    return formattedDate;
  }

  Future<void> fetchGoldData() async {
    if (_isGoldDataLoaded) {
      return; // Không gọi lại API nếu dữ liệu đã được tải
    }

    String url =
        "https://api.metals.dev/v1/timeseries?api_key=3ZAAYRRPI3ILSFAGQGIY165AGQGIY&start_date=$startDate&end_date=$endDate";

    try {
      final response = await http.get(Uri.parse(url));

      if (kDebugMode) {
        print(response.body);
      }

      if (response.statusCode == 200) {
        final body = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          goldData = GoldModel.fromJson(body);
          _isGoldDataLoaded = true;
        });
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
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentTime),
            SizedBox(height: 12),
            Expanded(
              child: goldData != null &&
                      goldData!.rates != null &&
                      goldData!.rates!.isNotEmpty
                  ? ItemGold(goldData: goldData, height: height, width: width)
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Clours.primary,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final goldModel = goldModelFromJson(jsonString);
