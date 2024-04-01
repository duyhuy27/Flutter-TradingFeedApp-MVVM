import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:trading_news/model/news/news_model.dart';

class NewsController extends GetxController {
  RxList<NewsLatestModel> newsList = <NewsLatestModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoinMarket();
  }

  fetchCoinMarket({String category = 'Latest news'}) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(
          'https://min-api.cryptocompare.com/data/v2/news/?categories=$category&lang=EN'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["Data"];
        List<NewsLatestModel> news =
            responseData.map((data) => NewsLatestModel.fromJson(data)).toList();
        newsList.assignAll(news);
      } else if (response.statusCode == 429) {
        print("Rate limit exceeded");
      } else {
        print("Failed to fetch data, status code: ${response.statusCode}");
      }
    } finally {
      isLoading(false);
    }
  }
}
