import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/view/widgets/custom_messagedialog.dart';
import '../../utils/date_formatter.dart';

class SetupRepo {
  final _ref = FirebaseDatabase.instance.ref();

  void getSetup() {
    firebaseInit();
  }

  void firebaseInit() {
    _ref.once().then((DatabaseEvent event) async {
      final snapshot = event.snapshot;

      if (!snapshot.exists) {
        final datetime = await getCurrentDateTime();
        final datetimeSplit = datetime.split(' ');

        await _ref.set({
          "configuration": {
            "farthest_distance_sensor": 100,
            "nearest_distance_sensor": 50,
            "servo_enabled": true,
            "servo_max_degree": 180,
            "servo_min_degree": 90,
            "servo_pause_time": 0,
          },
          "distance": {
            "cm": 0.0,
            "inch": 0.0,
          },
          "led_status": {"date": datetime, "status": false},
          "system_notification": {
            datetimeSplit[0]: {
              datetimeSplit[1]: {
                "message": "Database ditambahkan",
                "status": "initial",
              }
            }
          },
        });
      }
    });
  }

  void getUpdateDetail(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      bool isFreshInstall = prefs.getBool('fresh_install') ?? true;

      if (isFreshInstall) {
        showDialog(
          context: context,
          builder: (context) {
            return const CustomMessageDialog(
              title: "Informasi Update",
              text: """
- Perbaikan bug riwayat hari ini
- Perbaikan bug fitur hapus
- Menambahkan pembuatan db baru ketika db masih kosong
- Perbaikan kecil
""",
            );
          },
        );
      }

      prefs.setBool('fresh_install', false).then((_) => null);
    });
  }
}
