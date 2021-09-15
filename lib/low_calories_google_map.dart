import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:low_calories_google_map/model/Locaiton.dart';
import 'package:low_calories_google_map/model/LocationData.dart';
import 'package:low_calories_google_map/model/Marker.dart';
import 'package:low_calories_google_map/model/Polyline.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
export 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';
export 'package:low_calories_google_map/model/PositionMarker.dart';
export 'package:low_calories_google_map/model/LocationData.dart';
export 'package:low_calories_google_map/model/Marker.dart';
export 'package:low_calories_google_map/model/ScaleMarkerAnimation.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart';
export 'package:low_calories_google_map/model/Locaiton.dart';









class LowCaloriesGoogleMap {











  static const MethodChannel _channel = const MethodChannel('low_calories_google_map');
  final _eventChannel = const EventChannel('low_calories_google_map/channels');








  static Future<bool?> get gpsStatusAndroid async {
    final bool? version = await _channel.invokeMethod('gpsStatusAndroid');
    return version;
  }



  static Future<bool?> get locationStatusAndroid async {
    final bool? version = await _channel.invokeMethod('locationStatusAndroid');
    return version;
  }



  static Future<Location?> getLocation()async{

    if(Platform.isAndroid){

      bool? location = await locationStatusAndroid;
      if(location! == false){
        bool data = await _channel.invokeMethod('requestLocationPermissionAndroid');
        if(data == false){
          return null;
        }
      }


      bool? gps = await gpsStatusAndroid;
      if(gps! == false){
        bool data = await _channel.invokeMethod('requestOpenGpsAndroid');
        if(data == false){
          return null;
        }
      }

    }


    if(Platform.isIOS){

    }


    final dynamic data = await _channel.invokeMethod('getLocation');
    return Location.fromList(data);
  }





  static Future<String?> animatePolyLine(
      {List<List<double>>? list, String? overviewPolyline}) async {
    final String? version = await _channel.invokeMethod('animatePolyLine',
        [overviewPolyline != null ? decodePolyLine(overviewPolyline) : list]);
    return version;
  }









  static Future<bool?> addMapStyle(StyleColor styleColor) async {
    final bool? version = await _channel
        .invokeMethod('mapStyle', {"mapStyle": _getStyle(styleColor)});
    return version;
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

    if(Platform.isIOS){
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

    return Scaffold(
      body: Center(
        child: Text("is Android"),
      ),
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
