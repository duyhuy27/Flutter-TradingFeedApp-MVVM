import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sparkline/sparkline.dart';
import 'package:trading_news/model/gold/gold_model.dart';

class ItemGold extends StatelessWidget {
  const ItemGold({
    super.key,
    required this.goldData,
    required this.height,
    required this.width,
  });

  final GoldModel? goldData;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: goldData!.rates!.length,
      itemBuilder: (context, index) {
        var sortedDates = goldData!.rates!.keys.toList()
          ..sort((a, b) => b.compareTo(a)); // Sắp xếp ngày giảm dần
        var date = sortedDates[index];
        var rate = goldData!.rates![date]!;
        return Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$date',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset('assets/gold.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ': \$${rate.metals.gold.toString()}',
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/bars.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ': \$${rate.metals.silver.toString()}',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/platinum.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ': \$${rate.metals.platinum.toString()}',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset('assets/pall.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ': \$${rate.metals.palladium.toString()}',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.1,
                    width: width * 0.35,
                    child: Sparkline(
                      data: [
                        rate.metals.gold,
                        rate.metals.silver,
                        rate.metals.platinum,
                        rate.metals.palladium
                      ],
                      lineWidth: 2,
                      lineColor: Colors.amber,
                      fillMode: FillMode.below,
                      fillGradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.7],
                          colors: [Colors.amber, Colors.amber.shade100]),
                    ),
                  )
                ],
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }
}
