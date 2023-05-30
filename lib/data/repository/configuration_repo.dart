import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../app/model/config.dart';
import '../../res/strings/global_key.dart';

class ConfigurationRepo {
  final _ref = FirebaseDatabase.instance.ref().child('configuration');

  Stream<Config> getConfigQuery() {
    final controller = StreamController<Config>();

    _ref.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final config = Config.fromJson(json);

        controller.add(config);
      }
    }).onError((error) {
      debugPrint("Gagal mendapatkan data: $error");
    });

    return controller.stream;
  }

  Future<Config?> getConfigOnce() async {
    Config? config;

    final event = await _ref.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      final json = snapshot.value as Map<dynamic, dynamic>;
      config = Config.fromJson(json);
    }

    return config;
  }

  void updateConfigQuery(int nearestDistance, int pauseTime) async {
    await _ref.update({
      "nearest_distance_sensor": nearestDistance,
      "farthest_distance_sensor": nearestDistance * 2,
      "servo_pause_time": pauseTime,
    }).then((_) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Konfigurasi berhasil diperbarui"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void updateServoQuery(bool value) async {
    await _ref.update({
      "servo_enabled": value,
    }).then((_) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Servo berhasil diperbarui"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
