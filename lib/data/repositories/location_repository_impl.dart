import 'package:geolocator/geolocator.dart';
import 'package:pray_app/data/datasources/location_datasource.dart';
import 'package:pray_app/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Position> getLocation() async {
    var position = await dataSource.getManualLocation();
    position ??= await dataSource.getCurrentLocation();
    if (position == null) {
      // Default to Dhaka
      position = Position(latitude: 23.8103, longitude: 90.4125, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0);
    }
    return position;
  }

  @override
  Future<void> setManualLocation(double lat, double lng) async {
    await dataSource.saveManualLocation(lat, lng);
  }
}