


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:low_calories_google_map/Widget/PopAskOpenGpsIos.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/Styles.dart';
import 'package:low_calories_google_map/GoogleMapView.dart';
import 'package:low_calories_google_map/model/UnknownMapIDError.dart';





class GoogleMapController{


  final int mapId;
  final Map<int, MethodChannel> _channels = {};
  final GoogleMapViewState _googleMapState;


  GoogleMapController._(this._googleMapState, {required this.mapId,}){
    ensureChannelInitialized(mapId);
  }


  static Future<GoogleMapController> init(int id, GoogleMapViewState googleMapState,) async {
    return GoogleMapController._(
      googleMapState,
      mapId: id,
    );
  }


  @visibleForTesting
  MethodChannel ensureChannelInitialized(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      channel = MethodChannel('plugins.flutter.io/google_maps_$mapId');
      channel.setMethodCallHandler((MethodCall call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
    return channel;
  }

  
  MethodChannel channel(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      throw UnknownMapIDError(mapId);
    }
    return channel;
  }


  _handleMethodCall(MethodCall call, int mapId) {
    print("MethodCall : " + call.method);
    switch(call.method){
      case "onMapCreate":
        break;
      default:
        throw MissingPluginException();
    }
    return Future<dynamic>.value();
  }




  Future<bool?> get gpsStatusAndroid async {
    final bool? version = await channel(mapId).invokeMethod('gpsStatusAndroid');
    return version;
  }


  Future<bool?> get gpsStatusIos async {
    final bool? version = await channel(mapId).invokeMethod('checkGpsIos');
    return version;
  }








  Future<bool?> stopLocationUpdate() async {
    final bool? version = await channel(mapId).invokeMethod('stopLocationUpdate');
    return version;
  }

  Future<bool?> stopHeadingUpdate() async {
    final bool? version = await channel(mapId).invokeMethod('stopHeadingUpdate');
    return version;
  }


  Future<bool?> startHeadingUpdate() async {
    final bool? version = await channel(mapId).invokeMethod('startHeadingUpdate');
    return version;
  }












  Future<bool?> get locationStatusAndroid async {
    final bool? version = await channel(mapId).invokeMethod('locationStatusAndroid');
    return version;
  }


  Future<bool?> get locationStatusIos async {
    final bool? version = await channel(mapId).invokeMethod('locationStatusIos');
    return version;
  }


  Future<bool?>  markerExist(String id) async {
    final bool? version = await channel(mapId).invokeMethod('markerExist',{"id":id});
    return version;
  }














  Future<Location?> getLocation(BuildContext? context)async{

    if(Platform.isAndroid){

      bool? location = await locationStatusAndroid;
      if(location! == false){
        bool data = await channel(mapId).invokeMethod('requestLocationPermissionAndroid');
        if(data == false){
          return null;
        }
      }


      bool? gps = await gpsStatusAndroid;
      if(gps! == false){
        bool data = await channel(mapId).invokeMethod('requestOpenGpsAndroid');
        if(data == false){
          return null;
        }
      }

    }


    if(Platform.isIOS){



      bool? gps = await gpsStatusIos;
      print("gps status =========  " + gps.toString());

      if(gps! == false){
        bool? result = await showDialog<bool>(context: context!,barrierDismissible: false, builder: (context){
          return PopAskopenGpsIos(
            onGoSettings: ()async{
              bool data = await channel(mapId).invokeMethod('requestOpenGpsIos');
              print("gps Request status =========  " + data.toString());
              Navigator.pop(context,data);
            },
            onCancel: (){
              Navigator.pop(context,false);
            },
          );
        });

        if(result == false){
          return null;
        }
      }


      bool? location = await locationStatusIos;
      print("permission status =========  " + location.toString());
      if(location! == false){
        bool data = await channel(mapId).invokeMethod('requestLocationPermissionIos');
        print("permission Request result =========  " + data.toString());
        if(data == false){
          return null;
        }
      }

    }

    final dynamic data = await channel(mapId).invokeMethod('getLocation');
    return Location.fromList(data);
  }








  Future<String?> animatePolyLine({List<Location>? points, String? overviewPolyline}) async {

    List<List<double?>> list = [];

    for(Location location in points!){
       list.add([location.lat,location.lng]);
    }

    final String? version = await channel(mapId).invokeMethod('animatePolyLine', [overviewPolyline != null ? decodePolyLine(overviewPolyline) : list]);
    return version;
  }





  Future<bool?> animateTo(Location location,{double zoom = 16.0,double heading = 0.0,double viewingAngle = 0.0}) async {
    final bool? version = await channel(mapId).invokeMethod('animateToMap',{
      "animateToMap.lat":location.lat,
      "animateToMap.lng":location.lng,
      "animateToMap.zoom":zoom,
      "animateToMap.heading":heading,
      "animateToMap.viewingAngle":viewingAngle,
    });
    return version;
  }























  Future<bool?> addMapStyle(MapStyle styleColor) async {
    final bool? version = await channel(mapId).invokeMethod('mapStyle', {"mapStyle": Styles.getStyle(styleColor)});
    return version;
  }





  Future<bool?> addMarker(Marker marker) async {

    if((await markerExist(marker.id))!){
      return false;
    }

    String? base64 = await marker.base64String();

    Map<String, dynamic> data = {
      "image": base64,
      "size.width": marker.width,
      "size.height": marker.height,
      "opacity": marker.opacity,
      "id": marker.id,
    };

    if(marker.heading != null){
      data["heading"] = marker.heading;
    }

    data["isFlat"] = marker.isFlat;

    if (marker.position != null) {
      data.addAll(marker.position!.toJson());
    }

    if (marker.scaleMarkerAnimation != null) {
      data.addAll(marker.scaleMarkerAnimation!.toJson());
    }

    bool? version = await channel(mapId).invokeMethod('addMarker', data);

    return version;
  }


















  Future<bool?> updateMarker(String id, UpdateMarker marker) async {

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

    final bool? version = await channel(mapId).invokeMethod('updateMarker', data);

    return version;
  }



  Future<bool?> addPadding({double top = 0.0,double bottom = 0.0,double right = 0.0,double left = 0.0}) async {
    Map<String, dynamic> data = {
      "mapPadding.top": top,
      "mapPadding.left": left,
      "mapPadding.bottom": bottom,
      "mapPadding.right": right,
    };
    final bool? version = await channel(mapId).invokeMethod('paddingMap', data);
    return version;
  }





  Stream<double> get onHeadingUpdate {
    channel(mapId).invokeMethod('startHeadingUpdate');
    return EventChannel('low_calories_google_map/headingUpdate_$mapId').receiveBroadcastStream().map<double>((dynamic event) => event);
  }


  Future<Stream<Location>?>? onLocationUpdate(BuildContext context)async{
    Location? location = await getLocation(context);
    if(location == null){
      return null;
    }
    channel(mapId).invokeMethod('startLocationUpdate');
    return EventChannel('low_calories_google_map/locationUpdate_$mapId').receiveBroadcastStream().map<Location>((dynamic event) => Location(event[0],event[1]));
  }



  void dispose() {
    channel(mapId).setMethodCallHandler(null);
    stopLocationUpdate();
    stopHeadingUpdate();
  }

  Future<bool?> addPolyLine(String s, Polyline polyline) async{
    final bool? version = await channel(mapId).invokeMethod('addPolyLine', polyline.toJson());
    return version;
  }



}