class Led {
  Led({this.datetime, this.status});

  DateTime? datetime;
  bool? status;

  factory Led.fromJson(Map<dynamic, dynamic> json) => Led(
        datetime: DateTime.parse(json["date"]),
        status: json["status"],
      );
}
