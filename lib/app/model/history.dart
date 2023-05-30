class History {
  History({
    this.date,
    this.timeline,
  });

  String? date;
  List<Message>? timeline;

  factory History.fromJson(Map<dynamic, dynamic> json) => History(
        date: json['date'],
        timeline: json['timeline'],
      );
}

class Message {
  Message({this.time, this.message, this.status});

  String? time;
  String? message;
  String? status;

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
      time: json["time"], message: json["message"], status: json["status"]);

  Map<dynamic, dynamic> toJson() => {
        'time': time,
        'message': message,
        'status': status,
      };
}
