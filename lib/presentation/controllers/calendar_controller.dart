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

    // Sync dropdown with current Hijri date
    final hijriNow = HijriCalendar.now();
    selectedHijriMonth.value = hijriNow.hMonth;
    selectedHijriYear.value = hijriNow.hYear;

    // Fetch events from API
    fetchEvents();
  }

  /// Fetch events from API
  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      final url = 'https://quran-api-production-eeb6.up.railway.app/api/islamic-events';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        final List list = decodedData['data'];

        events.value = list.map((e) => IslamicEventModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if a specific calendar day has an event
  bool hasEvent(DateTime day) {
    return events.any((event) => isSameDay(event.dateTime, day));
  }

  /// Called when a day is selected in TableCalendar
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;

    // Update Hijri dropdown to match selected day
    final hDate = HijriCalendar.fromDate(selected);
    selectedHijriMonth.value = hDate.hMonth;
    selectedHijriYear.value = hDate.hYear;
  }

  /// Hijri month text for top bar
  String get hijriMonthYear =>
      "${hijriMonths[selectedHijriMonth.value - 1]}, $selectedHijriYear";

  /// Gregorian month range for top bar sub-text
  String get gregorianMonthRange {
    final start = DateFormat("MMMM").format(focusedDay.value);
    final nextMonth = DateTime(focusedDay.value.year, focusedDay.value.month + 1);
    final end = DateFormat("MMMM, yyyy").format(nextMonth);
    return "$start–$end";
  }

  void onHijriMonthChanged(int month) {
    selectedHijriMonth.value = month;
    // Logic to jump calendar to that Hijri month could be added here
  }

  void toggleCalendarType() {
    isIslamic.toggle();
  }
}