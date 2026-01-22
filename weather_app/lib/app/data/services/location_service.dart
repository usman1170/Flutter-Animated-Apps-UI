import 'package:geolocator/geolocator.dart';

enum LocationStatus { granted, denied, deniedForever, serviceDisabled }

class LocationService {
  Future<LocationStatus> checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationStatus.serviceDisabled;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return LocationStatus.denied;
    }
    if (permission == LocationPermission.deniedForever) {
      return LocationStatus.deniedForever;
    }
    return LocationStatus.granted;
  }

  Future<Position> getCurrentPosition() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
