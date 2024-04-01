import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading_news/Clours.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          child: Image.asset(
            'assets/logo.png',
            colorBlendMode: BlendMode.darken,
          ),
        ),
        SizedBox(width: 5),
        Text(
          'TRADINGFEED',
          style: GoogleFonts.montserrat(
            color: Clours.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
