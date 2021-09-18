import 'dart:convert';
import 'dart:io';
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

  List<List<double>>? list = decodePolyLine("sbkvD_xs}DW?WDkBhBYTi@\\_Bp@s@ToA\\aJNk@DcBPa@Cs@A}@a@SEk@SeAk@w@u@aC_Ca@KMCcGmGwA_BwCyC{EmFePsPmHuH_FeFe@}@G{@A{@@WLy@HYBg@E[Qo@u@oAaAgB_AiCoAyDmC{I]oA|@]`Bs@");

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
    addNavigationMarker();
  }


  addNavigationMarker(){
    Marker marker3 = Marker("3");
    marker3.position = PositionMarker(list![0][0], list![0][1]);
    marker3.heading = getRotationToLocation(list![0][0], list![0][1], list![1][0], list![1][1]);
    marker3.height = 35;
    marker3.width = 35;
    marker3.isFlat = true;
    marker3.assets = "assets/icons/navigation.png";
    LowCaloriesGoogleMap.addMarker(marker3);
  }


  updateNavigationMarker()async{
    int index = 0;
    for(List<double> position in list!){
      UpdateMarker marker3 = UpdateMarker();
      marker3.position = PositionMarker(position[0], position[1]);
      marker3.height = 35;
      marker3.width = 35;
      marker3.heading = getRotationToLocation(position[0], position[1], list![index+1][0], list![index+1][1]);
      LowCaloriesGoogleMap.updateMarker("3", marker3);
      await Future.delayed(Duration(seconds: 2));
      index++;
    }
  }





  addMarkerDotAnimation(){
    Marker marker1 = Marker("1");
    marker1.scaleMarkerAnimation = ScaleMarkerAnimation(
      autoReverses: true,
      fromValue: 0.5,
      toValue: 1.0,
      duration: 2,
    );

    marker1.opacity = 0.5;
    marker1.position = PositionMarker(list![0][0], list![0][1]);
    marker1.height = 80;
    marker1.width = 80;
    marker1.assets = "assets/icons/circle.png";
    LowCaloriesGoogleMap.addMarker(marker1);


    Marker marker2 = Marker("2");
    marker2.position = PositionMarker(list![0][0], list![0][1]);
    marker2.height = 16;
    marker2.width = 16;
    marker2.assets = "assets/icons/circle-small.png";
    LowCaloriesGoogleMap.addMarker(marker2);
  }


  updateMarkerDot()async{
    for(List<double> position in list!){
      UpdateMarker marker1 = UpdateMarker();
      marker1.scaleMarkerAnimation = ScaleMarkerAnimation(
        autoReverses: true,
        fromValue: 0.5,
        toValue: 1.0,
        duration: 2,
      );
      marker1.opacity = 0.5;
      marker1.position = PositionMarker(position[0], position[1]);
      marker1.height = 80;
      marker1.width = 80;


      UpdateMarker marker2 = UpdateMarker();
      marker2.position = PositionMarker(position[0], position[1]);
      marker2.height = 16;
      marker2.width = 16;


      LowCaloriesGoogleMap.updateMarker("1", marker1);
      LowCaloriesGoogleMap.updateMarker("2", marker2);

      await Future.delayed(Duration(seconds: 2));
    }
  }



  getLocation()async{
    Location? location = await LowCaloriesGoogleMap.getLocation();
    print("location : " + location!.toJson().toString());
  }


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [


            GoogleMapLowCalories(
              styleColor: StyleColor.Silver,
            ),


            Positioned(child: Container(
              child: RaisedButton(
                onPressed: ()async{

                  updateNavigationMarker();

                },
                child: Text("move"),
              ),
            ),bottom: 0,right: 0,left: 0,)


          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getLocation,
          child: Icon(Icons.gps_fixed),
        ),
      ),
    );


  }

}
