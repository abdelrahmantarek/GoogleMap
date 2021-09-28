import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart' as resize;
import 'package:flutter/services.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/ScaleMarkerAnimation.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'dart:ui' as ui;

class Marker {
  String id;
  final ScaleMarkerAnimation? scaleMarkerAnimation;
  final double? width;
  final double? opacity;
  final double? height;
  final double? heading;
  final String? imageView;
  final String? assets;
  final bool isFlat = true;
  final Location? position;

  Marker(this.id,{this.scaleMarkerAnimation, this.heading = 0.0, this.imageView, this.assets, this.position,this.height = 50.0,this.width = 50.0,this.opacity = 1.0});

  Future<String?> base64String() async {
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
  Location? position;
  UpdateMarker();
}
