import 'package:easy_localization/easy_localization.dart';

class IslamicEventModel {
  final String title;
  final String hijriDate; // From API: "10-01-1448"
  final String gregorianDate; // From API: "25-06-2026"

  IslamicEventModel({
    required this.title,
    required this.hijriDate,
    required this.gregorianDate,
  });

  factory IslamicEventModel.fromJson(Map<String, dynamic> json) {
    return IslamicEventModel(
      title: json['title'] ?? '',
      hijriDate: json['hijri_date'] ?? '',
      gregorianDate: json['gregorian_date'] ?? '',
    );
  }

  /// Converts "10-01-1448" -> "10 Muharram, 1448"
  String get formattedHijri {
    try {
      final parts = hijriDate.split('-');
      int day = int.parse(parts[0]);
      int monthIndex = int.parse(parts[1]) - 1; // 01 becomes index 0
      String year = parts[2];

      // Array of Hijri Month Names
      const months = [
        "Muharram", "Safar", "Rabiʿ al-Awwal", "Rabiʿ al-Thani",
        "Jumada al-Awwal", "Jumada al-Thani", "Rajab", "Shaʿban",
        "Ramadan", "Shawwal", "Dhu al-Qiʿdah", "Dhu al-Hijjah"
      ];

      return "$day ${months[monthIndex]}, $year";
    } catch (e) {
      return hijriDate; // Fallback to raw string if error
    }
  }

  /// Converts "25-06-2026" -> "25 June, 2026"
  String get formattedGregorian {
    try {
      final parts = gregorianDate.split('-');
      final date = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      return DateFormat("dd MMMM, yyyy").format(date);
    } catch (e) {
      return gregorianDate;
    }
  }

  /// DateTime object for calendar markers
  DateTime get dateTime {
    final parts = gregorianDate.split('-');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }
}