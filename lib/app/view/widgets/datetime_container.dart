import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../res/colors/color.dart';
import 'my_container.dart';

class DateTimeContainer extends StatelessWidget {
  const DateTimeContainer({super.key, required this.date, required this.time});

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: 18.0,
                child: SvgPicture.asset("assets/images/svg/calendar.svg",
                    color: kTitleColor),
              ),
              const SizedBox(width: 6.0),
              Text(date,
                  style: const TextStyle(
                      color: kTitleColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 18.0,
                child: SvgPicture.asset("assets/images/svg/clock.svg",
                    color: kTitleColor),
              ),
              const SizedBox(width: 6.0),
              Text(time,
                  style: const TextStyle(
                      color: kTitleColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
