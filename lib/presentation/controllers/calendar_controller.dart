import 'dart:convert';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

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

class CalendarController extends GetxController {
  /// Calendar state
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  /// API Data state
  var events = <IslamicEventModel>[].obs;
  var isLoading = false.obs;

  /// Hijri state
  RxInt selectedHijriMonth = 1.obs;
  RxInt selectedHijriYear = 1447.obs;

  /// Calendar type toggle
  RxBool isIslamic = true.obs;

  final List<String> hijriMonths = const [
    "Muharram",
    "Safar",
    "Rabiʿ al-Awwal",
    "Rabiʿ al-Thani",
    "Jumada al-Awwal",
    "Jumada al-Thani",
    "Rajab",
    "Shaʿban",
    "Ramadan",
    "Shawwal",
    "Dhu al-Qiʿdah",
    "Dhu al-Hijjah",
  ];

  @override
  void onInit() {
    super.onInit();

    final hijriNow = HijriCalendar.now();
    selectedHijriMonth.value = hijriNow.hMonth;
    selectedHijriYear.value = hijriNow.hYear;

    fetchEvents();
  }

  /// Fetch events
  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      final url = 'https://quran-api-production-eeb6.up.railway.app/api/islamic-events';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List list = decoded['data'];

        events.value =
            list.map((e) => IslamicEventModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Check event
  bool hasEvent(DateTime day) {
    return events.any((event) => isSameDay(event.dateTime, day));
  }

  /// Day select
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;

    final hDate = HijriCalendar.fromDate(selected);
    selectedHijriMonth.value = hDate.hMonth;
    selectedHijriYear.value = hDate.hYear;
  }

  /// Dropdown change (FIXED)
  void onHijriMonthChanged(int month) {
    selectedHijriMonth.value = month;

    final hijri = HijriCalendar()
      ..hYear = selectedHijriYear.value
      ..hMonth = month
      ..hDay = 1;

    final gregorian = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1,
    );

    focusedDay.value = gregorian;
    selectedDay.value = gregorian;

    fetchEvents();
  }

  /// Toggle calendar type
  void toggleCalendarType() {
    isIslamic.toggle();
  }

  String get hijriMonthYear =>
      "${hijriMonths[selectedHijriMonth.value - 1]}, $selectedHijriYear";

  String get gregorianMonthRange {
    final start = DateFormat("MMMM").format(focusedDay.value);
    final next =
    DateTime(focusedDay.value.year, focusedDay.value.month + 1);
    final end = DateFormat("MMMM, yyyy").format(next);
    return "$start – $end";
  }
}