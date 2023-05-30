import 'package:flutter/material.dart';

import '../../../res/colors/color.dart';
import 'components/status_servo.dart';
import 'components/ubah_pengaturan.dart';

class ChangeConfigScreen extends StatelessWidget {
  static const String routeName = '/change_configuration';

  const ChangeConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Perbarui Pengaturan",
          style: TextStyle(
            color: kTitleColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: kTitleColor,
          splashRadius: 20.0,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {},
              color: kTitleColor,
              splashRadius: 20.0,
              icon: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: kSecondaryColor, width: 1.0)),
            ),
          ),
          SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: kGreenColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    "Perangkat membutuhkan waktu untuk menerapkan perubahan",
                    style: TextStyle(
                      color: kGreenColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                const UbahPengaturan(),
                const SizedBox(height: 20.0),
                const StatusServo(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
