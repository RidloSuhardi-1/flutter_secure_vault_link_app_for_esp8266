import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../app/model/servo.dart';

class ServoRepo {
  final _ref = FirebaseDatabase.instance.ref().child('servo_status');

  Stream<Servo> getStatusQuery() {
    final controller = StreamController<Servo>();

    _ref.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final status = Servo.fromJson(json);
        controller.add(status);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }
}
