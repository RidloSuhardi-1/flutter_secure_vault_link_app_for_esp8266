import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../app/model/realtime_distance.dart';

class RealtimeDistanceRepo {
  final _ref = FirebaseDatabase.instance.ref().child('distance');

  Stream<RealtimeDistance?> getDistanceQuery() {
    final controller = StreamController<RealtimeDistance?>();

    _ref.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final distance = RealtimeDistance.fromJson(json);
        controller.add(distance);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }
}
