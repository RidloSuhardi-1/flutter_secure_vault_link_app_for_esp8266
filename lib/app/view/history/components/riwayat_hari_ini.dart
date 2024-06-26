import 'package:flutter/material.dart';

import '../../../../data/repository/history_repo.dart';
import '../../../../res/colors/color.dart';
import '../../../../utils/date_formatter.dart';
import '../../../model/history.dart';
import '../../widgets/datetime_container.dart';
import '../../widgets/timeline_list.dart';

class RiwayatHariIni extends StatefulWidget {
  const RiwayatHariIni({super.key});

  @override
  State<RiwayatHariIni> createState() => _RiwayatHariIniState();
}

class _RiwayatHariIniState extends State<RiwayatHariIni>
    with AutomaticKeepAliveClientMixin {
  Stream<History?>? _stream;
  ScrollController? _scrollController;

  String currentDay = "-";
  String currentDate = "-";
  String formattedDate = "-";

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    getCurrentDateTime().then((value) {
      final datetimeSplit = value.split(' ');
      final dateSplit = datetimeSplit[0].split('-');

      String year = dateSplit[0];
      String month = getMonthName(int.parse(year), int.parse(dateSplit[1]));
      String day = dateSplit[2];

      final selectedDate = DateTime(int.parse(dateSplit[0]),
          int.parse(dateSplit[1]), int.parse(dateSplit[2]));

      setState(() {
        currentDay = getDayOfWeek(selectedDate);
        currentDate = "$day $month $year";
        formattedDate = datetimeSplit[0];
      });
      _stream = HistoryRepo().getHistoryByDate(formattedDate);
    });

    // stream data
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<History?>(
      stream: _stream,
      builder: (context, snapshot) {
        String? date = "-";
        String? firstTime = "--:--";
        String? lastTime = "--:--";

        Widget? widgetBuilder = const Center(
          child: SizedBox(
            width: 46.0,
            height: 46.0,
            child: CircularProgressIndicator(color: kPrimaryColor),
          ),
        );

        if (snapshot.hasData) {
          final data = snapshot.data;

          if (data!.timeline!.isNotEmpty) {
            date = data.date;
            firstTime = formatTime(
                DateTime.parse("${data.date} ${data.timeline!.first.time}"));
            lastTime = formatTime(
                DateTime.parse("${data.date} ${data.timeline!.last.time}"));

            widgetBuilder = SingleChildScrollView(
              controller: _scrollController,
              child: TimelineList(
                date: date,
                timelines: data.timeline,
              ),
            );

            if (_scrollController!.hasClients) {
              _scrollController!.animateTo(
                _scrollController!.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          }
        } else {
          widgetBuilder = const Center(
            child: Text(
              "Belum ada data di tanggal ini",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400),
            ),
          );
        }

        if (snapshot.hasError) {
          debugPrint("Gagal mendapatkan data: ${snapshot.error}");

          widgetBuilder = const Center(
            child: Text(
              "Gagal mendapatkan data",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400),
            ),
          );
        }

        return Column(
          children: [
            DateTimeContainer(
              date: "$currentDay, $currentDate",
              time: "$firstTime - $lastTime",
            ),
            const SizedBox(height: 14.0),
            Expanded(child: widgetBuilder),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
