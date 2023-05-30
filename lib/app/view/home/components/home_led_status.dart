import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../data/repository/led_repo.dart';
import '../../../../res/colors/color.dart';
import '../../../../utils/date_formatter.dart';
import '../../../model/led.dart';
import '../../widgets/my_container.dart';

class HomeLedStatus extends StatefulWidget {
  const HomeLedStatus({
    super.key,
  });

  @override
  State<HomeLedStatus> createState() => _HomeLedStatusState();
}

class _HomeLedStatusState extends State<HomeLedStatus> {
  Stream<Led>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = LedRepo().getStatusQuery();
  }

  @override
  void dispose() {
    _stream?.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Led>(
      stream: _stream,
      builder: (context, snapshot) {
        bool? status = false;
        String? tanggalWaktu = "Tidak ada koneksi";

        if (snapshot.hasData) {
          final data = snapshot.data;
          // pisah tanggal waktu dengan jam
          final datetimeSplit = (data!.datetime.toString()).split(' ');
          // pisah tgl,bln,thn
          final dateSplit = datetimeSplit[0].split('-');

          String year = dateSplit[0];
          String month = getMonthName(int.parse(year), int.parse(dateSplit[1]));
          String day = dateSplit[2];

          status = data.status;
          tanggalWaktu = "$day $month $year ${formatTime(data.datetime)}";
        }

        return MyContainer(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 40.0,
                child: Image.asset("assets/images/lamp.png"),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status LED",
                      style: TextStyle(
                        color: kTitleColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 4.0),
                  Text(tanggalWaktu,
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 20.0,
                child: SvgPicture.asset(
                  "assets/images/svg/led_status.svg",
                  color: status! ? kGreenColor : kRedColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
