import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/repository/history_repo.dart';
import '../../../../res/colors/color.dart';
import '../../../../utils/date_formatter.dart';
import '../../../model/history.dart';
import '../../history/history_screen.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_container.dart';

class HomeLastHistory extends StatefulWidget {
  const HomeLastHistory({
    super.key,
  });

  @override
  State<HomeLastHistory> createState() => _HomeLastHistoryState();
}

class _HomeLastHistoryState extends State<HomeLastHistory> {
  Stream<List<History>?>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = HistoryRepo().getAllHistoryQuery();
  }

  @override
  void dispose() {
    _stream?.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<History>?>(
      stream: _stream,
      builder: (context, snapshot) {
        String? imgSrc = "assets/images/initial.png";
        String? lastStatus = "Belum ada data";
        String? lastTime = "-- -- --";
        String? year = "-";
        String? dayMonth = "-- --";

        if (snapshot.hasData) {
          final lastDate = snapshot.data!.last;
          final lastTimeline = lastDate.timeline!.last;

          switch (lastTimeline.status) {
            case "object-in-range":
              imgSrc = "assets/images/object-in-range.png";
              lastStatus = "Objek Diluar Jangkauan";
              break;
            case "object-detected":
              imgSrc = "assets/images/object-detected.png";
              lastStatus = "Paket memasuki gudang";
              break;
            case "object-away":
              imgSrc = "assets/images/object-away.png";
              lastStatus = "Objek Menjauh";
              break;
            default:
              imgSrc = "assets/images/initial.png";
              lastStatus = "Perangkat Aktif";
              break;
          }

          final dateSplit = lastDate.date!.split('-');

          year = dateSplit[0];
          dayMonth =
              "${dateSplit[2]} ${getMonthName(int.parse(year), int.parse(dateSplit[1]))}";

          lastTime = formatTime(
              DateTime.parse("${lastDate.date} ${lastTimeline.time}"));
        }

        return MyContainer(
          enableBorder: false,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Hasil Deteksi Terkini",
                  style: TextStyle(
                      color: kTitleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Container(
                    width: 46.0,
                    height: 46.0,
                    padding: const EdgeInsets.all(11.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kSecondaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Image.asset(imgSrc),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lastStatus,
                        style: const TextStyle(
                          color: kTitleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        lastTime,
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        year,
                        style: const TextStyle(
                          color: kTitleColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        dayMonth,
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 40.0,
                child: MyButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HistoryScreen.routeName);
                  },
                  foregroundColor: Colors.white,
                  backgroundColor: kPrimaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/svg/calendar.svg",
                          color: Colors.white, width: 15.0),
                      const SizedBox(width: 10.0),
                      const Text("Riwayat Deteksi",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
