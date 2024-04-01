import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/model/coin/coin_model.dart';
import 'package:trading_news/pages/market_coin/components/coins/details_coins.dart';

class ItemCoinsWidget extends StatelessWidget {
  final RxList<MarketCapModel> coinList;
  final Function(double) formatPercentage;
  final Function(double) formatCurrency;
  final Function(double) formatMarketCap;

  const ItemCoinsWidget({
    Key? key,
    required this.coinList,
    required this.formatPercentage,
    required this.formatCurrency,
    required this.formatMarketCap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: coinList.length,
      itemBuilder: (context, index) {
        final coins = coinList[index];
        final isPlus = coins.priceChangePercentage1HInCurrency > 0;
        return GestureDetector(
          onTap: () {
            // Navigate to coin details or wherever you want
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectCoin(
                          selectItem: coins,
                        )));
          },
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            child: CachedNetworkImage(
                              imageUrl: coins.image,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: Clours.primary,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coins.symbol.toUpperCase(),
                                style: GoogleFonts.openSans(fontSize: 16),
                              ),
                              Text(
                                coins.name,
                                style: GoogleFonts.openSans(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            formatPercentage(coins
                                .priceChangePercentage1HInCurrency
                                .toDouble()),
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: isPlus ? Colors.green : Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            formatCurrency(coins.currentPrice.toDouble()),
                            style: GoogleFonts.openSans(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vol (24h) : ${formatMarketCap(coins.totalVolume.toDouble())}',
                        style: GoogleFonts.openSans(fontSize: 12),
                      ),
                      Text(
                        'Market Cap: : ${formatMarketCap(coins.marketCap.toDouble())}',
                        style: GoogleFonts.openSans(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
