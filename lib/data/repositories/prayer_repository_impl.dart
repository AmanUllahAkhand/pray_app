import 'package:geolocator/geolocator.dart';
import 'package:pray_app/data/datasources/prayer_datasource.dart';
import 'package:pray_app/data/models/home/prayer_time_model.dart';
import 'package:pray_app/domain/entities/prayer_time.dart';
import 'package:pray_app/domain/repositories/prayer_repository.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerDataSource dataSource;

  PrayerRepositoryImpl(this.dataSource);

  @override
  Future<PrayerTime> getPrayerTimes(Position position, DateTime date) async {
    final prayerTimes = dataSource.getPrayerTimes(position, date);
    return PrayerTimeModel.fromAdhan(prayerTimes);
  }

  @override
  String getHijriDate() {
    return dataSource.getHijriDate();
  }

  @override
  Map<String, String> getProhibitedTimes(Position position, DateTime date) {
    final prayerTimes = dataSource.getPrayerTimes(position, date);
    return dataSource.getProhibitedTimes(prayerTimes);
  }
}