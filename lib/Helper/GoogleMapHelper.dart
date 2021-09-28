

import 'dart:math' as math;
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/Polyline.dart';
import 'package:vector_math/vector_math.dart';


double getRotationToLocation(double currentLatitude, double currentLongitude,
    double targetLatitude, double targetLongitude) {
  var la_rad = radians(currentLatitude);
  var lo_rad = radians(currentLongitude);

  var de_la = radians(targetLatitude);
  var de_lo = radians(targetLongitude);

  var toDegrees = degrees(math.atan(math.sin(de_lo - lo_rad) /
      ((math.cos(la_rad) * math.tan(de_la)) - (math.sin(la_rad) * math.cos(de_lo - lo_rad)))));
  if (la_rad > de_la) {
    if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
        toDegrees > 0.0 &&
        toDegrees <= 90.0) {
      toDegrees += 180.0;
    } else if (lo_rad <= de_lo &&
        lo_rad >= radians(-180.0) + de_lo &&
        toDegrees > -90.0 &&
        toDegrees < 0.0) {
      toDegrees += 180.0;
    }
  }
  if (la_rad < de_la) {
    if ((lo_rad > de_lo || lo_rad < radians(-180.0) + de_lo) &&
        toDegrees > 0.0 &&
        toDegrees < 90.0) {
      toDegrees += 180.0;
    }
    if (lo_rad <= de_lo &&
        lo_rad >= radians(-180.0) + de_lo &&
        toDegrees > -90.0 &&
        toDegrees <= 0.0) {
      toDegrees += 180.0;
    }
  }
  return toDegrees;
}


List<List<double>>? decodePolyLine(String overviewPolyline) {
return PolylineDecoded.Decode(encodedString: overviewPolyline, precision: 5)
    .decodedCoords;
}

List<Location>? decodePolyLineLocation(String overviewPolyline) {
  List<Location> list = [];
  for(List<double> s in PolylineDecoded.Decode(encodedString: overviewPolyline, precision: 5).decodedCoords!){
    list.add(Location(s[0], s[1]));
  }
  return list;
}
