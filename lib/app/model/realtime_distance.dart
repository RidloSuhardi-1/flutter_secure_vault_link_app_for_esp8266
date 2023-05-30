class RealtimeDistance {
  RealtimeDistance({
    this.cm,
    this.inch,
  });

  double? cm;
  double? inch;

  factory RealtimeDistance.fromJson(Map<dynamic, dynamic> json) =>
      RealtimeDistance(
        cm: json["cm"],
        inch: json["inch"],
      );
}
