class RamadanTimeModel {
  final String sehriLast;
  final String iftarStart;
  final String sehriLabel;
  final String iftarLabel;

  RamadanTimeModel({
    required this.sehriLast,
    required this.iftarStart,
    required this.sehriLabel,
    required this.iftarLabel,
  });

  factory RamadanTimeModel.fromJson(Map<String, dynamic> json) {
    return RamadanTimeModel(
      sehriLast: json['sehri']['last_time'],
      iftarStart: json['iftar']['start_time'],
      sehriLabel: json['sehri']['label'],
      iftarLabel: json['iftar']['label'],
    );
  }
}