import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:low_calories_google_map/model/Locaiton.dart';
import 'package:low_calories_google_map/model/Polyline.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
export 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart';



class ScaleMarkerAnimation {
  final double duration;
  final double fromValue;
  final double toValue;
  final bool autoReverses;
  ScaleMarkerAnimation(
      {this.duration = 1.0,
      this.fromValue = 0.5,
      this.toValue = 2.0,
      this.autoReverses = true});
  Map<String, dynamic> toJson() {
    return {
      "scale.duration": duration,
      "scale.fromValue": fromValue,
      "scale.toValue": toValue,
      "scale.autoReverses": autoReverses,
    };
  }
}

class PositionMarker {
   double? lat;
   double? lng;
  PositionMarker(this.lat, this.lng);

  PositionMarker.fromMap(Map<String,dynamic> data){
    lat = data["lat"];
    lng = data["lng"];
  }

  Map<String, dynamic> toJson() {
    return {
      "position.lat": lat,
      "position.lng": lng,
    };
  }
}

class LocationData extends PositionMarker {
  LocationData.fromMap(Map<String, dynamic> data) : super.fromMap(data);
  LocationData(double? lat, double? lng) : super(lat, lng);
}

class Marker {
  String id;
  ScaleMarkerAnimation? scaleMarkerAnimation;
  double? width = 50.0;
  double? opacity = 1.0;
  double? height = 50.0;
  double? heading;
  String? assets;
  bool? isFlat;
  PositionMarker? position;

  Marker(this.id);

  Future<String> base64String() async {
    ByteData bytes = await rootBundle.load(assets!);
    var buffer = bytes.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    return m;
  }
}

class UpdateMarker {
  ScaleMarkerAnimation? scaleMarkerAnimation;
  double? width = 50.0;
  double? opacity = 1.0;
  double? height = 50.0;
  double? heading;
  bool? isFlat;
  PositionMarker? position;
  UpdateMarker();
}




class LowCaloriesGoogleMap {

  static const MethodChannel _channel = const MethodChannel('low_calories_google_map');
  final _eventChannel = const EventChannel('low_calories_google_map/channels');


  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> animatePolyLine(
      {List<List<double>>? list, String? overviewPolyline}) async {
    final String? version = await _channel.invokeMethod('animatePolyLine',
        [overviewPolyline != null ? decodePolyLine(overviewPolyline) : list]);
    return version;
  }

  static Future<String?> addMapStyle(StyleColor styleColor) async {
    final String? version = await _channel
        .invokeMethod('mapStyle', {"mapStyle": _getStyle(styleColor)});
    return version;
  }

  static Future<Location?> getLocation()async{
    final dynamic data = await _channel.invokeMethod('getLocation');
    return Location.fromJson(data);
  }

  Stream<LocationData> get onLocationChanged {
    return _eventChannel
        .receiveBroadcastStream()
        .map<LocationData>((dynamic event) {
          return LocationData.fromMap(Map<String, dynamic>.of(event.cast<String, dynamic>()));
    });
  }


  static Future<String?> addMarker(Marker marker) async {
    Map<String, dynamic> data = {
      "base64": await marker.base64String(),
      "size.width": marker.width,
      "size.height": marker.height,
      "opacity": marker.opacity,
      "id": marker.id,
    };

    if(marker.heading != null){
      data["heading"] = marker.heading;
    }
    if(marker.isFlat != null){
       data["isFlat"] = marker.isFlat;
    }
    if (marker.position != null) {
      data.addAll(marker.position!.toJson());
    }

    if (marker.scaleMarkerAnimation != null) {
      data.addAll(marker.scaleMarkerAnimation!.toJson());
    }

    final String? version = await _channel.invokeMethod('addMarker', data);

    return version;
  }



  static Future<String?> updateMarker(String id, UpdateMarker marker) async {

    Map<String, dynamic> data = {
      "size.width": marker.width,
      "size.height": marker.height,
      "opacity": marker.opacity,
      "id": id,
    };

    if(marker.heading != null){
      data["heading"] = marker.heading;
    }
    if(marker.isFlat != null){
      data["isFlat"] = marker.isFlat;
    }
    if (marker.position != null) {
       data.addAll(marker.position!.toJson());
    }

    if (marker.scaleMarkerAnimation != null) {
       data.addAll(marker.scaleMarkerAnimation!.toJson());
    }

    final String? version = await _channel.invokeMethod('updateMarker', data);

    return version;
  }


  static List<List<double>>? decodePolyLine(String overviewPolyline) {
    return PolylineDecoded.Decode(encodedString: overviewPolyline, precision: 5)
        .decodedCoords;
  }
}





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

/*
  final networkStream = _eventChannel
      .receiveBroadcastStream()
      .distinct()
      .map((dynamic event) => intToConnection(event as int));
 */

class GoogleMapLowCalories extends StatelessWidget {
  final StyleColor? styleColor;
  const GoogleMapLowCalories({Key? key, this.styleColor = StyleColor.Standard}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String viewType = '<platform-view-type>';
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.rtl,
      creationParams: {"mapStyle": _getStyle(styleColor!)},
      onPlatformViewCreated: (d) {
        print("onPlatformViewCreated " + d.toString());
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

String _getStyle(StyleColor styleColor) {

  var style = Styles.standard;

  switch (styleColor) {
    case StyleColor.Standard:
      style = Styles.standard;
      break;
    case StyleColor.Silver:
      style = Styles.sliver;
      break;
    case StyleColor.Retro:
      style = Styles.retro;
      break;
    case StyleColor.Dark:
      style = Styles.dark;
      break;
    case StyleColor.Night:
      style = Styles.night;
      break;
    case StyleColor.Aubergine:
      style = Styles.aubergine;
      break;
  }
// How do I remove building interiors from Google maps using styles
// https://stackoverflow.com/questions/14442599/how-do-i-remove-building-interiors-from-google-maps-using-styles
  List list = [
// {"stylers": [{ "visibility": "off" },]},
    {
      "featureType": "road",
      "stylers": [
        {"visibility": "on"}
      ]
    },
  ];
  list.addAll(style);
  return jsonEncode(list);
}
