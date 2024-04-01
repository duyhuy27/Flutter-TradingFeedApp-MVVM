import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/controller/coin_market/coin_controller.dart';
import 'package:trading_news/pages/market_coin/components/coins/coins_item.dart';

class ListCoin extends StatefulWidget {
  const ListCoin({Key? key}) : super(key: key);

  @override
  State<ListCoin> createState() => _ListCoinState();
}

class _ListCoinState extends State<ListCoin> {
  final CoinController coinController = Get.put(CoinController());

  String formatCurrency(double price) {
    final formatter = NumberFormat.currency(locale: 'en', symbol: '\$');
    return formatter.format(price);
  }

  String formatPercentage(double percentage) {
    final formattedPercentage = percentage.toStringAsFixed(1);
    return '${formattedPercentage} %';
  }

  String formatMarketCap(double marketCap) {
    final formattedMarketCap = (marketCap / 1000000000).toStringAsFixed(2);
    return '\$$formattedMarketCap B';
  }

  Future<void> _refresh() async {
    await coinController.fetchCoinMarket();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: RefreshIndicator(
        backgroundColor: Colors.grey,
        color: Clours.primary,
        displacement: 40,
        strokeWidth: 2,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        edgeOffset: 100,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Your header widgets
              Obx(() {
                final isLoading = coinController.isLoading.value;
                final coinList = coinController.coinList;
                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.transparent,
                        ),
                      )
                    : ItemCoinsWidget(
                        coinList: coinList,
                        formatPercentage: formatPercentage,
                        formatCurrency: formatCurrency,
                        formatMarketCap: formatMarketCap,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
