

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:low_calories_google_map/model/PositionMarker.dart';
import 'package:low_calories_google_map/model/ScaleMarkerAnimation.dart';


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
