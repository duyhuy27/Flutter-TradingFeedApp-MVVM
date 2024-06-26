import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trading_news/Clours.dart';
import 'package:trading_news/model/coin/chart_model.dart';
import 'package:trading_news/model/coin/coin_model.dart';

class SelectCoin extends StatefulWidget {
  final MarketCapModel selectItem;

  SelectCoin({required this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Details of ${widget.selectItem.symbol}',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: myHeight * 0.08,
                            child: Image.network(widget.selectItem.image)),
                        SizedBox(
                          width: myWidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectItem.id.toUpperCase(),
                              style: GoogleFonts.openSans(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              widget.selectItem.symbol.toUpperCase(),
                              style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$' + widget.selectItem.currentPrice.toString(),
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          widget.selectItem.marketCapChangePercentage24H
                                  .toString() +
                              '%',
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Low',
                              style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$' + widget.selectItem.low24H.toString(),
                              style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'High',
                              style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$' + widget.selectItem.high24H.toString(),
                              style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Vol',
                              style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              '\$' +
                                  widget.selectItem.totalVolume.toString() +
                                  'M',
                              style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.015,
                  ),
                  Container(
                    height: myHeight * 0.4,
                    width: myWidth,
                    // color: Colors.amber,
                    child: isRefresh == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffFBC700),
                            ),
                          )
                        : itemChart == null
                            ? Padding(
                                padding: EdgeInsets.all(myHeight * 0.06),
                                child: Center(
                                  child: Text(
                                    'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                    style: GoogleFonts.openSans(fontSize: 18),
                                  ),
                                ),
                              )
                            : SfCartesianChart(
                                trackballBehavior: trackballBehavior,
                                zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true, zoomMode: ZoomMode.x),
                                series: <CandleSeries>[
                                  CandleSeries<ChartModel, int>(
                                      enableSolidCandles: true,
                                      enableTooltip: true,
                                      bullColor: Colors.green,
                                      bearColor: Colors.red,
                                      dataSource: itemChart!,
                                      xValueMapper: (ChartModel sales, _) =>
                                          sales.time,
                                      lowValueMapper: (ChartModel sales, _) =>
                                          sales.low,
                                      highValueMapper: (ChartModel sales, _) =>
                                          sales.high,
                                      openValueMapper: (ChartModel sales, _) =>
                                          sales.open,
                                      closeValueMapper: (ChartModel sales, _) =>
                                          sales.close,
                                      animationDuration: 55)
                                ],
                              ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Center(
                    child: Container(
                      height: myHeight * 0.03,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: text.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: myWidth * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  textBool = [
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                  textBool[index] = true;
                                });
                                setDays(text[index]);
                                getChart();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: myWidth * 0.03,
                                    vertical: myHeight * 0.005),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: textBool[index] == true
                                      ? Clours.primary.withOpacity(0.3)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  text[index],
                                  style: GoogleFonts.openSans(fontSize: 18),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.04,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                        child: Text(
                          'News',
                          style: GoogleFonts.openSans(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.06,
                            vertical: myHeight * 0.01),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.openSans(
                                    color: Colors.grey, fontSize: 17),
                              ),
                            ),
                            Container(
                              width: myWidth * 0.25,
                              child: CachedNetworkImage(
                                imageUrl: widget.selectItem.image,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: Clours.primary,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              )),
              // Container(
              //   height: myHeight * 0.1,
              //   width: myWidth,
              // color: Colors.amber,
              // child: Column(
              //   children: [
              //     Divider(),
              //     SizedBox(
              //       height: myHeight * 0.01,
              //     ),
              //     Row(
              //       children: [
              //         SizedBox(
              //           width: myWidth * 0.05,
              //         ),
              //         Expanded(
              //           flex: 5,
              //           child: Container(
              //             padding:
              //                 EdgeInsets.symmetric(vertical: myHeight * 0.015),
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(50),
              //                 color: Color(0xffFBC700)),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(
              //                   Icons.add,
              //                   size: myHeight * 0.02,
              //                 ),
              //                 Text(
              //                   'Add to portfolio',
              //                   style: GoogleFonts.openSans(fontSize: 20),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: myWidth * 0.05,
              //         ),
              //         Expanded(
              //           flex: 2,
              //           child: Container(
              //             padding:
              //                 EdgeInsets.symmetric(vertical: myHeight * 0.012),
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(50),
              //                 color: Colors.grey.withOpacity(0.2)),
              //             child: Image.asset(
              //               'assets/logo.png',
              //               height: myHeight * 0.03,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: myWidth * 0.05,
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;

  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectItem.id +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
