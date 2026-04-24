import 'package:geolocator/geolocator.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';

abstract class PrayerRepository {
  Future<PrayerTime> getPrayerTimes(Position position, DateTime date);
  String getHijriDate();
  Map<String, String> getProhibitedTimes(Position position, DateTime date);
}