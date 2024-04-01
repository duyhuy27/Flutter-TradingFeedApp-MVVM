import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading_news/Clours.dart';

void showNoConnectionDialog(BuildContext context, String mess) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Clours.gray_dim,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/error-404.png',
                width: 72,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  mess,
                  style: GoogleFonts.montserrat(
                      color: Clours.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  'Please check your wifi or mobile network connection',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reload quảng cáo khi người dùng bật lại kết nối mạng
                  },
                  child: Text(
                    'Retry !',
                    style: GoogleFonts.montserrat(
                      color: Clours.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      );
    },
  );
}
