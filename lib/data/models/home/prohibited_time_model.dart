class ProhibitedTimeModel {
  final String start;
  final String end;

  ProhibitedTimeModel({
    required this.start,
    required this.end,
  });

  factory ProhibitedTimeModel.fromJson(Map<String, dynamic> json) {
    return ProhibitedTimeModel(
      start: json['start'],
      end: json['end'],
    );
  }
}