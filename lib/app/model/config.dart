class Config {
  Config({
    this.farthestDistance,
    this.nearestDistance,
    this.servoPauseTime,
    this.servoEnabled,
  });

  int? farthestDistance;
  int? nearestDistance;
  int? servoPauseTime;
  bool? servoEnabled;

  factory Config.fromJson(Map<dynamic, dynamic> json) => Config(
        farthestDistance: json["farthest_distance_sensor"],
        nearestDistance: json["nearest_distance_sensor"],
        servoPauseTime: json["servo_pause_time"],
        servoEnabled: json["servo_enabled"],
      );

  Map<dynamic, dynamic> toJson() => {
        "farthest_distance_sensor": farthestDistance,
        "nearest_distance_sensor": nearestDistance,
        "servo_enabled": servoEnabled,
        "servo_pause_time": servoPauseTime,
      };
}
