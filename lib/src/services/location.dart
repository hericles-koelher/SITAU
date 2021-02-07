import 'dart:async';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  LocationAccuracy _accuracy;

  Location({LocationAccuracy accuracy = LocationAccuracy.medium})
      : assert(accuracy != null),
        _accuracy = accuracy;

  Future<Position> getCurrentPosition(
      {Duration intervalDuration = const Duration(hours: 1)}) async {
    bool locationEnabled;
    LocationPermission permission;

    locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (locationEnabled == false)
      return Future.error("Location services are disabled.");

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever)
      return Future.error("Location permissions are permanently denied.");
    else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always)
        return Future.error("Location permissions are denied");
    }

    return Geolocator.getCurrentPosition(desiredAccuracy: _accuracy);
  }

  Future<String> getCurrentCityName() async {
    Position position = await getCurrentPosition();

    var coordinates = Coordinates(position.latitude, position.longitude);

    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return addresses.first.subAdminArea;
  }
}
