import 'package:flutter/material.dart';

import '../../../../data/repository/history_repo.dart';
import '../../../../res/colors/color.dart';
import '../../../../utils/date_formatter.dart';
import '../../../model/history.dart';
import '../../widgets/datetime_container.dart';
import '../../widgets/timeline_list.dart';

class SemuaRiwayat extends StatefulWidget {
  const SemuaRiwayat({super.key});

  @override
  State<SemuaRiwayat> createState() => _SemuaRiwayatState();
}

class _SemuaRiwayatState extends State<SemuaRiwayat>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  Stream<List<History>?>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = HistoryRepo().getAllHistoryQuery();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder<List<History>?>(
      stream: _stream,
      builder: (context, snapshot) {
        String day = "-";
        String dayNumber = "-";
        String date = "- - -";
        String timeRange = "--:-- - --:--";

        List<History>? historyList = [];

        if (snapshot.hasData) {
          historyList = snapshot.data;
        }

        if (historyList!.isNotEmpty) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final data = historyList![index];

              // dapatkan tanggal dan hari (yyyy-mm-dd)
              final dateSplit = data.date!.split('-');

              final dateToDateTime = DateTime(int.parse(dateSplit[0]),
                  int.parse(dateSplit[1]), int.parse(dateSplit[2]));

              String month = getMonthName(
                  int.parse(dateSplit[0]), int.parse(dateSplit[1]));
              String year = dateSplit[0];
              dayNumber = dateSplit[2];
              day = getDayOfWeek(dateToDateTime);

              date = "$day, $dayNumber $month $year";

              // dapatkan rentang waktu dari timeline

              if (data.timeline!.isNotEmpty) {
                String firstTime = formatTime(DateTime.parse(
                    "${data.date} ${data.timeline!.first.time}"));
                String lastTime = formatTime(
                    DateTime.parse("${data.date} ${data.timeline!.last.time}"));

                timeRange = "$firstTime - $lastTime";
              }

              return Column(
                children: [
                  DateTimeContainer(
                    date: date,
                    time: timeRange,
                  ),
                  const SizedBox(height: 14.0),
                  data.timeline!.isNotEmpty
                      ? TimelineList(
                          date: data.date,
                          timelines: data.timeline,
                        )
                      : const Expanded(
                          child: Center(
                            child: Text(
                              "Belum ada data di tanggal ini.",
                              style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                ],
              );
            },
          );
        }

        return const Center(
          child: Text(
            "Belum ada data.",
            style: TextStyle(
                color: kTextColor, fontSize: 12.0, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
