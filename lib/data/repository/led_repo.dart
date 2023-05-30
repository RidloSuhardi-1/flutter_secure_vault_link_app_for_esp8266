import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../app/model/led.dart';

class LedRepo {
  final _ref = FirebaseDatabase.instance.ref().child('led_status');

  Stream<Led> getStatusQuery() {
    final controller = StreamController<Led>();

    _ref.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final status = Led.fromJson(json);
        controller.add(status);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }
}
