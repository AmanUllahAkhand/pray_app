class DailyHadithModel {
  final String date;
  final String hadith;
  final String source;

  DailyHadithModel({
    required this.date,
    required this.hadith,
    required this.source,
  });

  factory DailyHadithModel.fromJson(Map<String, dynamic> json) {
    return DailyHadithModel(
      date: json['date'] ?? "",
      hadith: json['hadith'] ?? "",
      source: json['source'] ?? "Source Unknown",
    );
  }
}