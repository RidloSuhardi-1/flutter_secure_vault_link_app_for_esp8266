import 'dart:async';
import '../../res/strings/global_key.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../app/model/history.dart';
import '../../utils/date_formatter.dart';

class HistoryRepo {
  final _ref = FirebaseDatabase.instance.ref().child('system_notification');

  Stream<List<History>?> getAllHistoryQuery() {
    final controller = StreamController<List<History>?>();

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
      } else {
        controller.add([]);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }

  Stream<History?> getHistoryByDate(String date) {
    final controller = StreamController<History?>();

    _ref.child(date).onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot;

      History? history;
      List<Message>? timeline = [];

      if (snapshot.value != null) {
        final json = snapshot.value as Map<dynamic, dynamic>;

        List<MapEntry<dynamic, dynamic>> sortedList = json.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));

        for (var entry in sortedList) {
          final jsonTimeData = entry.value as Map<dynamic, dynamic>;
          final m = Message.fromJson({
            'time': entry.key,
            'message': jsonTimeData["message"],
            'status': jsonTimeData["status"],
          });

          timeline.add(m);
        }

        history = History(
          date: date,
          timeline: timeline,
        );

        controller.add(history);
      } else {
        controller.add(history);
      }
    }).onError((error) {
      debugPrint("Kesalahan dalam mendapatkan data: $error");
    });

    return controller.stream;
  }

  void deleteAllHistory() {
    _ref.remove().then((_) {
      createReference();

      scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Semua riwayat dibersihkan"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  void createReference() async {
    final datetime = await getCurrentDateTime();
    final datetimeSplit = datetime.split(' ');

    await _ref.set({
      datetimeSplit[0]: {
        datetimeSplit[1]: {
          "message": "Database ditambahkan",
          "status": "initial",
        }
      },
    });
  }
}
