import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';

class PrayerDataSource {
  PrayerTimes getPrayerTimes(Position position, DateTime date) {
    final coordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
    return PrayerTimes.today(coordinates, params);
  }

  String getHijriDate() {
    final hijri = HijriCalendar.now();
    return '${hijri.hMonth} ${hijri.hDay}, ${hijri.hYear} AH';
  }

  // Calculate prohibited times based on prayer times (e.g., sunrise to dhuhr, etc.)
  Map<String, String> getProhibitedTimes(PrayerTimes prayerTimes) {
    // Logic to calculate dawn (after fajr to sunrise), afternoon (midday), evening (after asr to maghrib)
    // For example:
    return {
      'Dawn': '${prayerTimes.fajr.add(const Duration(minutes: 15)).hour}:${prayerTimes.fajr.add(const Duration(minutes: 15)).minute} - Sunrise',
      // Add others similarly
    };
  }
}