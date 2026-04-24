import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  /// Calendar state
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  /// Hijri state
  RxInt selectedHijriMonth = 1.obs;
  RxInt selectedHijriYear = 1447.obs;

  /// ✅ Hijri month names (manual – REQUIRED)
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

  /// Calendar type
  RxBool isIslamic = true.obs;

  @override
  void onInit() {
    super.onInit();

    final hijriNow = HijriCalendar.now();
    selectedHijriMonth.value = hijriNow.hMonth;
    selectedHijriYear.value = hijriNow.hYear;
  }

  /// Called when a day is selected
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  /// Hijri month text
  String get hijriMonthYear =>
      "${hijriMonths[selectedHijriMonth.value - 1]}, $selectedHijriYear";

  /// Gregorian month range
  String get gregorianMonthRange {
    final start = DateFormat("MMMM").format(focusedDay.value);
    final end = DateFormat(
      "MMMM, yyyy",
    ).format(DateTime(
      focusedDay.value.year,
      focusedDay.value.month + 1,
    ));
    return "$start–$end";
  }

  void onHijriMonthChanged(int month) {
    selectedHijriMonth.value = month;
  }

  void toggleCalendarType() {
    isIslamic.toggle();
  }
}
