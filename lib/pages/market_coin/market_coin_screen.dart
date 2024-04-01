import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/pages/market_coin/components/gold/list_gold.dart';
import 'package:trading_news/pages/market_coin/components/coins/list_coin.dart';

class MarketCoinScreen extends StatefulWidget {
  const MarketCoinScreen({super.key});

  @override
  State<MarketCoinScreen> createState() => _MarketCoinScreenState();
}

class _MarketCoinScreenState extends State<MarketCoinScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Market Cap',
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Clours.primary,
          unselectedLabelColor: Clours.gray_ash,
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.currency_bitcoin_outlined,
                color: Colors.black,
              ),
            ),
            Tab(
              icon: ImageIcon(
                AssetImage('assets/gold_icon.png'),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ListCoin(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: GoldMarketScreen(),
          ),
        ],
      ),
    );
  }
}
