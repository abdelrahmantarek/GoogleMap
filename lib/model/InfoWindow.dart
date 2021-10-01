


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';

class InfoWindow{
  final Widget? child;
  final GestureTapCallback? onTap;
  final Location? position;
  final double? width;
  final double? height;
  Offset? offset;


  InfoWindow({required this.child, this.onTap,required this.position, this.width = 50.0, this.height = 50.0,}){
    Get.find<GoogleMapController>().getPointScreenFromMapView(position!).then((value){
      offset = value;
    });
  }


}