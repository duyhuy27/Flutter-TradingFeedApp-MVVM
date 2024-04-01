import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trading_news/pages/home/home_screen.dart';
import 'package:trading_news/pages/market_coin/market_coin_screen.dart';
import 'package:trading_news/pages/search/search_screen.dart';
import 'package:trading_news/pages/setting/setting_screen.dart';

import '../../Clours.dart';

class NavController extends StatefulWidget {
  const NavController({super.key});

  @override
  State<NavController> createState() => _NavControllerState();
}

class _NavControllerState extends State<NavController> {
  int _selectedIndex = 0;

  // List các màn hình tương ứng với từng tab
  final List<Widget> _screens = [
    HomeScreen(), // Thay thế Container() bằng màn hình home nếu có
    MarketCoinScreen(),
    SearchScreen(), // Màn hình market cap
    SettingScreen(), // Màn hình more
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[
          _selectedIndex], // Hiển thị màn hình tương ứng với tab được chọn
      bottomNavigationBar: GNav(
        gap: 8,
        rippleColor: Colors.grey,
        // tab button ripple color when pressed
        hoverColor: Clours.gray_ash,
        backgroundColor: Colors.black,
        haptic: true,
        // haptic feedback
        tabBorderRadius: 15,
        duration: Duration(milliseconds: 500),
        // tab animation duration
        activeColor: Clours.primary,
        color: Clours.gray_dim,
        padding: EdgeInsets.all(20),
        selectedIndex: _selectedIndex,
        onTabChange: (value) {
          // Set lại giá trị của selectedIndex khi người dùng chọn tab mới
          setState(() {
            _selectedIndex = value;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
          ),
          GButton(
            icon: Icons.show_chart_outlined,
            text: 'Market',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.menu,
            text: 'More',
          ),
        ],
      ),
    );
  }
}
