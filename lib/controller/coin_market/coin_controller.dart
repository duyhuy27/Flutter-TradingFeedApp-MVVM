import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:trading_news/model/coin/coin_model.dart';

class CoinController extends GetxController {
  RxList<MarketCapModel> coinList = <MarketCapModel>[].obs;
  RxBool isLoading = true.obs;
  int requestCount = 0;
  List<MarketCapModel> previousData = [];

  @override
  void onInit() {
    super.onInit();
    fetchCoinMarket();
  }

  fetchCoinMarket() async {
    try {
      isLoading(true);
      // var connectivityResult = await Connectivity().checkConnectivity();
      // if (connectivityResult == ConnectivityResult.none) {
      //   // Không có kết nối mạng
      //   Get.snackbar("Network Error", "No Internet Connection",
      //       snackPosition: SnackPosition.BOTTOM);
      //   return;
      // }

      // Giới hạn số lần request
      if (requestCount >= 5) {
        Get.snackbar("Error", "Too many requests, try again",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h&locale=en'));

      if (response.statusCode == 200) {
        List<MarketCapModel> coins = marketCapModelFromJson(response.body);

        // Kiểm tra sự thay đổi từ API
        if (!isDataChanged(coins)) {
          return;
        }

        coinList.value = coins;
        previousData = coins;
      } else if (response.statusCode == 429) {
        print("loi mat rui");
      }
    } finally {
      isLoading(false);
    }
  }

  // Hàm kiểm tra sự thay đổi dữ liệu từ API
  bool isDataChanged(List<MarketCapModel> newData) {
    if (previousData.isEmpty) {
      return true; // Nếu dữ liệu trước đó là rỗng, coi như đã thay đổi
    }

    // So sánh dữ liệu mới và dữ liệu trước
    if (newData.length != previousData.length) {
      return true;
    }
    for (int i = 0; i < newData.length; i++) {
      if (newData[i].id != previousData[i].id) {
        return true;
      }
    }
    return false;
  }
}
