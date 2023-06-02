import 'package:flutter/material.dart';

import '../../../../data/repository/servo_repo.dart';
import '../../../../res/colors/color.dart';
import '../../../../utils/date_formatter.dart';
import '../../../model/servo.dart';
import '../../widgets/my_container.dart';

class HomeServoStatus extends StatefulWidget {
  const HomeServoStatus({
    super.key,
  });

  @override
  State<HomeServoStatus> createState() => _HomeServoStatusState();
}

class _HomeServoStatusState extends State<HomeServoStatus> {
  Stream<Servo>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = ServoRepo().getStatusQuery();
  }

  @override
  void dispose() {
    _stream?.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Servo>(
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

        if (snapshot.hasError) {
          debugPrint("Gagal mendapatkan data: ${snapshot.error}");
          tanggalWaktu = "Gagal mendapatkan data";
        }

        return MyContainer(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 40.0,
                child: Image.asset("assets/images/icon.png"),
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status Servo",
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
              Text("Pintu ${status! ? 'terbuka' : 'tertutup'}",
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
        );
      },
    );
  }
}
