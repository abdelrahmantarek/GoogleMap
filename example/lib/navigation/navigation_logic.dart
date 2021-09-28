import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/Controllers/GoogleMapController.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';

class NavigationLogic extends GetxController {

  GoogleMapController? mapController;
  late Location? lastLocation;
  RxBool locationUpdate = false.obs;

  StreamSubscription? streamSubscriptionLocationUpdate;
  StreamSubscription? streamSubscriptionHeadingUpdate;


  Marker get markerMe{
    Marker markerMe = Marker("0", position: lastLocation, assets: "assets/icons/navigation_blue_have_shadows.png",);
    return markerMe;
  }


  @override
  void onReady() {
    super.onReady();
  }


  @override
  void onClose() {
    streamSubscriptionLocationUpdate?.cancel();
    streamSubscriptionHeadingUpdate?.cancel();
    super.onClose();
  }



  void onMapReady(GoogleMapController value) {
    mapController = value;
  }





  void getLocation() async{
    lastLocation = await mapController!.getLocation(Get.context!);
    if(lastLocation!=null){
      print("my location : " + lastLocation!.toJson().toString());
      mapController!.animateTo(lastLocation!);
      mapController!.addMarker(markerMe);
    }
  }

  void addPolyLine() {

    Polyline polyline = Polyline(points: routeExample2,strokeWidth: 5.0,color: Colors.black);

    mapController!.addPolyLine("1",polyline);
  }

  void runLocationUpdate() async{

    if(locationUpdate.value){
      locationUpdate.value = false;
      streamSubscriptionLocationUpdate?.cancel();
      streamSubscriptionHeadingUpdate?.cancel();
      mapController!.addPadding(top: 0.0,bottom: 0.0,right: 0.0,left: 0.0);
      return;
    }

    locationUpdate.value = true;
    mapController!.addPadding(top: MediaQuery.of(Get.context!).size.height * 50 / 100);

    streamSubscriptionHeadingUpdate = mapController!.onHeadingUpdate.listen((event) {
      UpdateMarker updateMarker = UpdateMarker();
      updateMarker.position = lastLocation!;
      updateMarker.isFlat = true;
      updateMarker.heading = event;
      mapController!.updateMarker("0", updateMarker);
      mapController!.animateTo(lastLocation!,zoom: 18,heading: event,viewingAngle: 40.0);
    });

    Stream<Location>? stream = await mapController!.onLocationUpdate(Get.context!);
    streamSubscriptionLocationUpdate = stream!.listen((event) {
      lastLocation = event;
    });

  }



}
