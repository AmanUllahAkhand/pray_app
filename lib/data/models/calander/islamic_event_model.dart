import 'package:easy_localization/easy_localization.dart';

class IslamicEventModel {
  final String title;
  final String hijriDate;
  final String gregorianDate;

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

  /// ✅ FIX: Getter for 'formattedHijri'
  String get formattedHijri {
    try {
      final parts = hijriDate.split('-'); // Splits "10-01-1448"
      int day = int.parse(parts[0]);
      int monthIndex = int.parse(parts[1]) - 1;
      String year = parts[2];

      const months = [
        "Muharram", "Safar", "Rabiʿ al-Awwal", "Rabiʿ al-Thani",
        "Jumada al-Awwal", "Jumada al-Thani", "Rajab", "Shaʿban",
        "Ramadan", "Shawwal", "Dhu al-Qiʿdah", "Dhu al-Hijjah"
      ];

      return "$day ${months[monthIndex]}, $year"; // Result: "10 Muharram, 1448"
    } catch (e) {
      return hijriDate;
    }
  }

  /// ✅ FIX: Getter for 'formattedGregorian'
  String get formattedGregorian {
    try {
      final parts = gregorianDate.split('-'); // Splits "25-06-2026"
      final date = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0])
      );
      return DateFormat("dd MMMM, yyyy").format(date); // Result: "25 June, 2026"
    } catch (e) {
      return gregorianDate;
    }
  }

  /// DateTime object used for calendar markers
  DateTime get dateTime {
    final parts = gregorianDate.split('-');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }
}