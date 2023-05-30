import 'dart:async';
import '../../res/strings/global_key.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../app/model/history.dart';

class HistoryRepo {
  final _ref = FirebaseDatabase.instance.ref().child('system_notification');

  Stream<List<History>?> getAllHistoryQuery() {
    var controller = StreamController<List<History>>();

    _ref.onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      List<History>? historyList = [];

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;

        json.forEach((key, value) {
          String? date = key;
          List<Message>? timeline = [];

          final jsonTimeline = value as Map<dynamic, dynamic>;

          List<MapEntry<dynamic, dynamic>> sortedList = jsonTimeline.entries
              .toList()
            ..sort((a, b) => a.key.compareTo(b.key));

          for (var entry in sortedList) {
            final timelineValue = entry.value as Map<dynamic, dynamic>;

            final m = Message.fromJson({
              'time': entry.key,
              'message': timelineValue['message'],
              'status': timelineValue['status'],
            });

            timeline.add(m);
          }

          historyList.add(History(
            date: date,
            timeline: timeline,
          ));
        });
        controller.add(historyList);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }

  Stream<History> getHistoryByDate(String path) {
    final controller = StreamController<History>();

    _ref.orderByChild(path).onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      History? history;

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;

        json.forEach((key, value) {
          String? date = key;
          List<Message>? timeline = [];

          final jsonTimeline = value as Map<dynamic, dynamic>;

          List<MapEntry<dynamic, dynamic>> sortedList = jsonTimeline.entries
              .toList()
            ..sort((a, b) => a.key.compareTo(b.key));

          for (var entry in sortedList) {
            final timelineValue = entry.value as Map<dynamic, dynamic>;

            final m = Message.fromJson({
              'time': entry.key,
              'message': timelineValue['message'],
              'status': timelineValue['status'],
            });

            timeline.add(m);
          }

          history = History(
            date: date,
            timeline: timeline,
          );
        });
        controller.add(history!);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }

  void deleteAllHistory() {
    _ref.remove().then((_) {
      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Semua riwayat dibersihkan"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
