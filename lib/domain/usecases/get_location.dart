import 'package:geolocator/geolocator.dart';
import 'package:pray_app/domain/repositories/location_repository.dart';

class GetLocation {
  final LocationRepository repository;

  GetLocation(this.repository);

  Future<Position> call() async {
    return await repository.getLocation();
  }
}