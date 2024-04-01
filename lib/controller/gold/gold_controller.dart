// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:intl/intl.dart';
// import 'package:trading_news/model/gold/gold_model.dart';

// class GoldMarketController extends GetxController {
//   var goldData = GoldModel().obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchGoldData();
//   }

//   Future<void> fetchGoldData() async {
//     final currentTime =
//         getCurrentTimeFormatted(); // Remove the unnecessary variable declaration
//     var currentDate = DateTime.now();
//     var startDateCalculation = currentDate.subtract(const Duration(days: 30));
//     var startDate = DateFormat('yyyy-MM-dd').format(startDateCalculation);
//     var endDate = DateFormat('yyyy-MM-dd').format(currentDate);

//     String url =
//         "https://api.metals.dev/v1/timeseries?api_key=3ZAAYRRPI3ILSFAGQGIY165AGQGIY&start_date=$startDate&end_date=$endDate";

//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final body = json.decode(utf8.decode(response.bodyBytes));
//       goldData(GoldModel.fromJson(
//         body['status'],
//         body['currency'],
//         body['unit'],
//         body['startDate'],
//         body['endDate'],
//         body['rates'],
//       ));
//     } else {
//       throw Exception('Failed to fetch gold data');
//     }
//   }

//   String getCurrentTimeFormatted() {
//     var now = DateTime.now();
//     var formattedDate = DateFormat('HH:mm, dd/MM/yyyy').format(now);
//     return formattedDate;
//   }
// }
