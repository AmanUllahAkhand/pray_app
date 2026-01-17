import 'package:adhan/adhan.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';

class PrayerTimeModel extends PrayerTime {
  PrayerTimeModel({
    required DateTime fajr,
    required DateTime dhuhr,
    required DateTime asr,
    required DateTime maghrib,
    required DateTime isha,
  }) : super(fajr: fajr, dhuhr: dhuhr, asr: asr, maghrib: maghrib, isha: isha);

  factory PrayerTimeModel.fromAdhan(PrayerTimes prayerTimes) {
    return PrayerTimeModel(
      fajr: prayerTimes.fajr,
      dhuhr: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha: prayerTimes.isha,
    );
  }
}