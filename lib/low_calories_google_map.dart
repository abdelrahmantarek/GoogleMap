import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:low_calories_google_map/model/Polyline.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
export 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';


class LowCaloriesGoogleMap {

  static const MethodChannel _channel = const MethodChannel('low_calories_google_map');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> animatePolyLine({List<List<double>>? list,String? overviewPolyline}) async {
    final String? version = await _channel.invokeMethod('animatePolyLine',[overviewPolyline!=null ? decodePolyLine(overviewPolyline) : list]);
    return version;
  }

  static Future<String?> addMapStyle(StyleColor styleColor) async {
    final String? version = await _channel.invokeMethod('mapStyle',{
      "mapStyle":_getStyle(styleColor)
    });
    return version;
  }

  static Future<String?> addMarker(String base64) async {
    final String? version = await _channel.invokeMethod('addMarker',{
      "base64": base64
    });
    return version;
  }

  static List<List<double>>? decodePolyLine(String overviewPolyline){
    return PolylineDecoded.Decode(encodedString: overviewPolyline, precision: 5).decodedCoords;
  }

}

class GoogleMapLowCalories extends StatelessWidget {
  final StyleColor? styleColor;
  const GoogleMapLowCalories({Key? key, this.styleColor = StyleColor.Standard}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String viewType = '<platform-view-type>';
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.rtl,
      creationParams: {
        "mapStyle":_getStyle(styleColor!)
      },
      onPlatformViewCreated: (d){
        print("onPlatformViewCreated " + d.toString());
      },
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}


String _getStyle(StyleColor styleColor){
  var style = Styles.standard;

  switch(styleColor){
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
    {"featureType": "road","stylers": [{ "visibility": "on" }]},
  ];
  list.addAll(style);
  return jsonEncode(list);
}
