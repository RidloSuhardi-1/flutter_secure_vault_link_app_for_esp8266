import 'package:firebase_database/firebase_database.dart';

import '../../utils/date_formatter.dart';

class SetupRepo {
  final _ref = FirebaseDatabase.instance.ref();

  void getSetup() {
    _ref.once().then((DatabaseEvent event) async {
      final snapshot = event.snapshot;

      if (!snapshot.exists) {
        final datetime = await getCurrentDateTime();

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
          "system_notification": {},
        });
      }
    });
  }

  void firebaseInit() {
    _ref.once().then((DatabaseEvent event) async {
      final snapshot = event.snapshot;

      if (!snapshot.exists) {
        final datetime = await getCurrentDateTime();

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
          "system_notification": {},
        });
      }
    });
  }
}
