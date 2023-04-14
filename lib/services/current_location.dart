import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/utils.dart';

class CurrentLocation {
  Future getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Utilities().showMessage('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Utilities()
          .showMessage('Location permissions are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    return place.locality;
  }
}
