import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:low_calories_google_map/Helper/GoogleMapHelper.dart';
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
export 'package:low_calories_google_map/model/Locaiton.dart';
export 'package:low_calories_google_map/Helper/GoogleMapHelper.dart';
export 'package:low_calories_google_map/GoogleMapView.dart';








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






















  static Future<String?> animatePolyLine({List<List<double>>? list, String? overviewPolyline}) async {
    final String? version = await _channel.invokeMethod('animatePolyLine', [overviewPolyline != null ? decodePolyLine(overviewPolyline) : list]);
    return version;
  }

























  static Future<bool?> addMapStyle(StyleColor styleColor) async {
    final bool? version = await _channel.invokeMethod('mapStyle', {"mapStyle": Styles.getStyle(styleColor)});
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






}










/*
  final networkStream = _eventChannel
      .receiveBroadcastStream()
      .distinct()
      .map((dynamic event) => intToConnection(event as int));
 */



