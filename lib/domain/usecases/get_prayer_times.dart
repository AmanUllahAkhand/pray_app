import 'package:geolocator/geolocator.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';
import 'package:pray_app/domain/repositories/prayer_repository.dart';

class GetPrayerTimes {
  final PrayerRepository repository;

  GetPrayerTimes(this.repository);

  Future<PrayerTime> call(Position position, DateTime date) async {
    return await repository.getPrayerTimes(position, date);
  }

  String getHijri() {
    return repository.getHijriDate();
  }

  Map<String, String> getProhibited(Position position, DateTime date) {
    return repository.getProhibitedTimes(position, date);
  }
}