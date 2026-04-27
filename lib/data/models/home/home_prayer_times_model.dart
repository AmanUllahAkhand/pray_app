class HomePrayerTimesModel {
  final PrayerSlot fajr;
  final PrayerSlot dhuhr;
  final PrayerSlot asr;
  final PrayerSlot maghrib;
  final PrayerSlot isha;

  HomePrayerTimesModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory HomePrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return HomePrayerTimesModel(
      fajr: PrayerSlot.fromJson(json['fajr']),
      dhuhr: PrayerSlot.fromJson(json['dhuhr']),
      asr: PrayerSlot.fromJson(json['asr']),
      maghrib: PrayerSlot.fromJson(json['maghrib']),
      isha: PrayerSlot.fromJson(json['isha']),
    );
  }
}

class PrayerSlot {
  final String start;
  final String end;

  PrayerSlot({
    required this.start,
    required this.end,
  });

  factory PrayerSlot.fromJson(Map<String, dynamic> json) {
    return PrayerSlot(
      start: json['start'],
      end: json['end'],
    );
  }
}
class Prayer {
  final String name;
  final String svgIcon;
  final String time;
  final String endTime;
  bool isNotificationActive;
  bool isChecked;

  Prayer({
    required this.name,
    required this.svgIcon,
    required this.time,
    required this.endTime,
    this.isNotificationActive = false,
    this.isChecked = false,
  });
}