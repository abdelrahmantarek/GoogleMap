

import 'package:low_calories_google_map/model/PositionMarker.dart';

class LocationData extends PositionMarker {
  LocationData.fromMap(Map<String, dynamic> data) : super.fromMap(data);
  LocationData(double? lat, double? lng) : super(lat, lng);
}
