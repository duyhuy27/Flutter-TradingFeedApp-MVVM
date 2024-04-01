import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../nav/nav_controller.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavController()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/splash.gif'),
              Column(
                children: [
                  Text(
                    'MetaFeed',
                    style: GoogleFonts.openSans(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Learn more about cryptocurrency, look to',
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Text(
                    ' the future in IO Crypto',
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       decoration: BoxDecoration(
              //           color: Clours.primary,
              //           borderRadius: BorderRadius.circular(50)),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal: myWidth * 0.05,
              //             vertical: myHeight * 0.013),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'Get Started  ',
              //               style: GoogleFonts.openSans(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.normal,
              //               ),
              //             ),
              //             RotationTransition(
              //                 turns: AlwaysStoppedAnimation(310 / 360),
              //                 child: Icon(Icons.arrow_forward_rounded))
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
