import 'package:flutter/material.dart';

import '../../../res/colors/color.dart';
import '../../../utils/date_formatter.dart';
import '../../model/history.dart';
import 'vertical_dotted_line.dart';

class TimelineList extends StatelessWidget {
  const TimelineList(
      {super.key,
      required this.date,
      required this.timelines,
      this.enableScroll = false});

  final String? date;
  final List<Message>? timelines;

  final bool? enableScroll;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: enableScroll! ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: timelines?.length,
      itemBuilder: (BuildContext context, int index) {
        double defaultHeight = 80;

        if (timelines!.isNotEmpty) {
          final data = timelines![index];

          final dateSplit = date!.split("-");
          final time = data.time!.split(":");

          final year = dateSplit[0];
          final month = getMonthName(int.parse(year), int.parse(dateSplit[1]));
          final day = dateSplit[2];

          final hour = time[0];
          final minute = time[1];

          return Stack(
            children: [
              SizedBox(
                height: index != timelines!.length - 1 ? defaultHeight : 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$hour:$minute",
                          style: const TextStyle(
                              color: kTitleColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          "$day $month",
                          style: const TextStyle(
                              color: kTextColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24.0),
                    Flexible(
                      child: Text(
                        "${data.message}",
                        style: const TextStyle(
                            color: kTitleColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 48,
                child: Container(
                  width: 8.0,
                  margin: const EdgeInsets.only(top: 4.0),
                  child: Image.asset("assets/images/blue_dot.png"),
                ),
              ),
              if (index != timelines!.length - 1)
                Positioned(
                  left: 52,
                  child: Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: VerticalDottedLine(
                      height: defaultHeight,
                      color: kPrimaryColor,
                      strokeWidth: 1.0,
                      dashSpace: 5.0,
                      dashWidth: 5.0,
                    ),
                  ),
                ),
            ],
          );
        } else {
          return Row(
            children: [
              Expanded(child: Container(height: 1.0, color: kSecondaryColor)),
              const SizedBox(width: 8.0),
              const Text("Belum ada data di tanggal ini",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400)),
              const SizedBox(width: 8.0),
              Expanded(child: Container(height: 1.0, color: kSecondaryColor)),
            ],
          );
        }
      },
    );
  }
}
