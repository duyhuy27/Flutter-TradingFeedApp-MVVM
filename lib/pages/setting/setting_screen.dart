import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:trading_news/pages/setting/components/policy_webview.dart';

import 'components/setting_item.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // const Text(
              //   "Account",
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   width: double.infinity,
              //   child: Row(
              //     children: [
              //       Image.asset("assets/avatar.png", width: 70, height: 70),
              //       const SizedBox(width: 20),
              //       const Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Uranus Code",
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //           SizedBox(height: 10),
              //           Text(
              //             "Youtube Channel",
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.grey,
              //             ),
              //           )
              //         ],
              //       ),
              //       const Spacer(),
              //       ForwardButton(
              //         onTap: () {
              //           // Navigator.push(
              //           //   context,
              //           //   MaterialPageRoute(
              //           //     builder: (context) => const EditAccountScreen(),
              //           //   ),
              //           // );
              //         },
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 40),
              // const Text(
              //   "Settings",
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Language",
                icon: Icons.language,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Currency",
                icon: Icons.currency_exchange,
                bgColor: Colors.blue.shade100,
                value: 'USD',
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Mode",
                icon: Icons.mode,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: 'System',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Feedback",
                icon: Icons.feedback_outlined,
                bgColor: Colors.yellow.shade100,
                iconColor: Colors.yellow.shade900,
                value: 'Send',
                onTap: () async {
                  final Email email = Email(
                    body: 'Email body',
                    subject: 'Report about ',
                    recipients: ['dhuy.ftmobile@gmail.com'],
                    isHTML: false,
                  );

                  await FlutterEmailSender.send(email);
                },
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Privacy policy",
                icon: Icons.policy_outlined,
                bgColor: Colors.lightGreen.shade100,
                iconColor: Colors.lightGreen,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PolicyWebview(
                              url: 'https://metafeed-94cf9.web.app/')));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
