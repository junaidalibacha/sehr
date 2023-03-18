import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationServices {
  final Location location = Location();
  HomeViewModel() {
    myLoction();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Position? position;

  myLoction() async {
    print("my location caliing");
    position = await _determinePosition();
    print(
        "lat>>>>>>>>>>>>   ${position!.latitude}    lng>>>>>>>>>>>>>>>> ${position!.longitude * (-1)}");
    try {
      List<geo.Placemark> placemarks =
          await geo.placemarkFromCoordinates(34.0046716, -71.5029527);
      List<geo.Location> locations = await geo
          .locationFromAddress("Jahangir Abad, Peshawar 25000, Pakistan");
      // print("the lat and lon is ${locations.last.latitude.toString() + locations.last.longitude.toString()}");
      print(
          "the add is ${placemarks.last.locality.toString() + placemarks.last.administrativeArea.toString() + placemarks.last.street.toString()}");
    } catch (e) {
      print("give me error ${e.toString()}");
    }
  }
}
