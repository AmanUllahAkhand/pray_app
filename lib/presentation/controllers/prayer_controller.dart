import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_colors.dart';

class Prayer {
  final String name;
  final String svgIcon;
  final String time;
  bool isNotificationActive;
  bool isChecked; // <-- new field for manual tick

  Prayer({
    required this.name,
    required this.svgIcon,
    required this.time,
    this.isNotificationActive = false,
    this.isChecked = false,
  });
}

class PrayerController extends GetxController {
  final currentPrayer = 'Isha'.obs;

  final prayerBgMap = {
    'Fajr': AppIcons.fajrBg,
    'Dhuhr': AppIcons.dhuhrBg,
    'Asr': AppIcons.asrBg,
    'Maghrib': AppIcons.maghribBg,
    'Isha': AppIcons.ishaBg,
  };

  String get currentBg =>
      prayerBgMap[currentPrayer.value] ?? prayerBgMap['Isha']!;

  final appBarColor = primaryColor.obs;

  final prayers = <Prayer>[
    Prayer(name: "Fajr", svgIcon: AppIcons.fajr, time: "06:24 am"),
    Prayer(name: "Dhuhr", svgIcon: AppIcons.dhuhr, time: "12:34 pm"),
    Prayer(name: "Asr", svgIcon: AppIcons.asr, time: "04:45 pm"),
    Prayer(name: "Maghrib", svgIcon: AppIcons.maghrib, time: "06:12 pm"),
    Prayer(name: "Isha", svgIcon: AppIcons.isha, time: "07:45 pm"),
  ].obs;

  final allNotification = false.obs;

  void toggleNotification(int index) {
    prayers[index].isNotificationActive = !prayers[index].isNotificationActive;
    updateAllNotification();
    update();
  }

  void toggleCheck(int index) {
    prayers[index].isChecked = !prayers[index].isChecked; // <-- manual tick
    update();
  }

  void toggleAllNotification(bool value) {
    allNotification.value = value;
    for (var prayer in prayers) {
      prayer.isNotificationActive = value;
    }
    update();
  }

  void updateAllNotification() {
    allNotification.value = prayers.every((p) => p.isNotificationActive);
  }

  void updateCurrentPrayer(String prayerName) {
    currentPrayer.value = prayerName;
    appBarColor.value = primaryColor;
    update();
  }
  /// Date management
  final currentDate = DateTime.now().obs;

  /// Increase date
  void nextDate() {
    currentDate.value = currentDate.value.add(const Duration(days: 1));
  }

  /// Decrease date
  void previousDate() {
    currentDate.value = currentDate.value.subtract(const Duration(days: 1));
  }

  /// Format Gregorian date
  String get formattedGregorianDate {
    final d = currentDate.value;
    return "${_weekDay(d.weekday)}, ${d.day} ${_month(d.month)} ${d.year}";
  }

  /// Dummy Hijri date (replace with actual Hijri conversion if needed)
  String get formattedHijriDate {
    return "Rajab ${currentDate.value.day}, 1447 AH";
  }

  String _weekDay(int weekday) {
    const names = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
    return names[weekday-1];
  }

  String _month(int month) {
    const names = ["January","February","March","April","May","June",
      "July","August","September","October","November","December"];
    return names[month-1];
  }

}
