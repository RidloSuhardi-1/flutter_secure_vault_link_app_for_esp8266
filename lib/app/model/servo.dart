class Servo {
  Servo({this.datetime, this.status});

  DateTime? datetime;
  bool? status;

  factory Servo.fromJson(Map<dynamic, dynamic> json) => Servo(
        datetime: DateTime.parse(json["date"]),
        status: json["status"],
      );
}
