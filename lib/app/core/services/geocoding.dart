import 'package:geocoding/geocoding.dart';

class GeoCodingService {
  Future<Map?> searchFromAddress(String addres) async {
    List<Location> placeMarks = await locationFromAddress(addres);
    if (placeMarks.isNotEmpty) {
      Location placeMark = placeMarks.first;
      double latitude = placeMark.latitude;
      double longitude = placeMark.longitude;
      return {'latitude': latitude, 'longitude': longitude};
    }
    return null;
  }
}
