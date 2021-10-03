import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/ScaleMarkerAnimation.dart';



class Marker {
  String id;
  final ScaleMarkerAnimation? scaleMarkerAnimation;
  final double? width;
  final double? height;
  final double? opacity;
  final double? heading;
  final double? marginY;
  final double? marginX;
  final String? imageView;
  final String? assets;
  final bool isFlat = true;
  final Location? position;
  final Widget? child;
  final GestureTapCallback? onTap;
  Offset? offset;

  Marker(this.id, {
    this.onTap,
    this.child,
    this.scaleMarkerAnimation,
    this.heading = 0.0,
    this.imageView,
    this.assets,
    required this.position,
    this.height = 50.0,
    this.width = 50.0,
    this.opacity = 1.0,
    this.marginY,
    this.marginX,
  });

  Future<String?> base64String() async {
    ByteData bytes = await rootBundle.load(assets!);
    var buffer = bytes.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    return m;
  }



  double getX() {
    if(marginX == null){
      return offset!.dx;
    }
    return offset!.dx + marginX!;
  }


  double getY() {
    if(marginY == null){
      return offset!.dy;
    }
    return offset!.dy + marginY!;
  }


  void getPositionScreen() {
    Get.find<GoogleMapController>().getPointScreenFromMapView(position!).then((value){
      print(value.toString());
      offset = value;
    });
  }


}

class UpdateMarker {
  ScaleMarkerAnimation? scaleMarkerAnimation;
  double? width = 50.0;
  double? opacity = 1.0;
  double? height = 50.0;
  double? heading;
  bool? isFlat;
  Location? position;
  UpdateMarker();
}
