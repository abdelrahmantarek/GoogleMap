import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:low_calories_google_map/low_calories_google_map.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await Future.delayed(Duration(seconds: 2));
    LowCaloriesGoogleMap.addMapStyle(StyleColor.Silver);
    LowCaloriesGoogleMap.animatePolyLine(overviewPolyline: "sbkvD_xs}DW?WDkBhBYTi@\\_Bp@s@ToA\\aJNk@DcBPa@Cs@A}@a@SEk@SeAk@w@u@aC_Ca@KMCcGmGwA_BwCyC{EmFePsPmHuH_FeFe@}@G{@A{@@WLy@HYBg@E[Qo@u@oAaAgB_AiCoAyDmC{I]oA|@]`Bs@");
    String base = await base64String("assets/icons/dot.png");
    LowCaloriesGoogleMap.addMarker(base);
  }

  Future<String> base64String(String assets) async{
    ByteData bytes = await rootBundle.load(assets);
    var buffer = bytes.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    return m;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMapLowCalories(
          styleColor: StyleColor.Silver,
        ),
      ),
    );
  }

}
