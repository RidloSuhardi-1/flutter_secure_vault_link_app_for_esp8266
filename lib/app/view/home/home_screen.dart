import 'package:flutter/material.dart';

import '../../../res/colors/color.dart';
import 'components/home_header.dart';
import 'components/home_last_history.dart';
import 'components/home_led_status.dart';
import 'components/home_realtime_detection.dart';
import 'components/home_setting.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: kSecondaryColor, width: 1.0)),
              ),
            ),
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HomeHeader(),
                  SizedBox(height: 22.0),
                  HomeLedStatus(),
                  SizedBox(height: 20.0),
                  HomeRealtimeDetection(),
                  SizedBox(height: 20.0),
                  HomeSetting(),
                  SizedBox(height: 20.0),
                  HomeLastHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
