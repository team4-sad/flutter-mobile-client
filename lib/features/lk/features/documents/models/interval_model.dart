class IntervalModel {
  final int startDay;
  final int endDay;

  IntervalModel({required this.startDay, required this.endDay});

  factory IntervalModel.fromJson(Map<String, dynamic> json) => IntervalModel(
      startDay: json["start_day"],
      endDay: json["end_day"]
  );
}