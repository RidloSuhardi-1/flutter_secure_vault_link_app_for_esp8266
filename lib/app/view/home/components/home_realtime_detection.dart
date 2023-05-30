import 'package:flutter/material.dart';
import 'package:iot_keamanan_barang_app/data/repository/realtime_distance_repo.dart';

import '../../../../res/colors/color.dart';
import '../../widgets/my_container.dart';
import '../../../model/realtime_distance.dart';

class HomeRealtimeDetection extends StatefulWidget {
  const HomeRealtimeDetection({
    super.key,
  });

  @override
  State<HomeRealtimeDetection> createState() => _HomeRealtimeDetectionState();
}

class _HomeRealtimeDetectionState extends State<HomeRealtimeDetection> {
  Stream<RealtimeDistance>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = RealtimeDistanceRepo().getDistanceQuery();
  }

  @override
  void dispose() {
    _stream?.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RealtimeDistance>(
      stream: _stream,
      builder: (context, snapshot) {
        String? cm = "0";
        String? inch = "0";

        if (snapshot.hasData) {
          final data = snapshot.data;

          cm = data?.cm?.toStringAsFixed(2);
          inch = data?.inch?.toStringAsFixed(2);
        }

        return MyContainer(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Deteksi Waktu Nyata",
                style: TextStyle(
                    color: kTitleColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("CM",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Text("$cm cm",
                            style: const TextStyle(
                                color: kTitleColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Inch",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8.0),
                        Text("$inch Inch",
                            style: const TextStyle(
                                color: kTitleColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
