class Led {
  Led({this.datetime, this.status, this.servoStatus});

  DateTime? datetime;
  bool? status;
  bool? servoStatus;

  factory Led.fromJson(Map<dynamic, dynamic> json) => Led(
        datetime: DateTime.parse(json["date"]),
        status: json["status"],
        servoStatus: json["servo_status"],
      );
}
