import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:sizer/sizer.dart';



class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


class InfoWindowLogic extends GetxController {


  GoogleMapController? mapController;
  Location? lastLocation;
  Rx<Offset?> locationMarker = Rx<Offset?>(null);




  void getLocation() async{
    lastLocation = await mapController!.getLocation(Get.context!);
    if(lastLocation!=null){

      mapController!.animateTo(lastLocation!);


      mapController!.addMarker(Marker("1", child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.grey,
              offset: Offset(0.0,1.5)
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(flex: 1,
              child: FloatingActionButton(
                onPressed: (){

                },
                child: Icon(Icons.location_on),
              ),
            ),
            SizedBox(width: 8,),
            Expanded(flex: 3,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("To Address",style: Get.textTheme.bodyText1!.copyWith(fontSize: 10.sp)),
                Text("25 a - Ramses Street",style: Get.textTheme.bodyText2!.copyWith(fontSize: 8.sp)),
              ],
            )),
          ],
        ),
      ),
           position: routeExample2!.last,
           width: Get.width * 40 / 100,height: 60
          ,marginX: 90.0,marginY: - 40)
      );

      mapController!.addMarker(Marker("0", child:lottie.Lottie.asset('assets/animations/location.json',repeat: true), position:  routeExample2!.last,));

      mapController!.addMarker(Marker("2", child: lottie.Lottie.asset('assets/animations/location_pin_red.json',repeat: true), position: routeExample2!.first,width: 50,heading: 50));

      locationMarker.value = await mapController!.getPointScreenFromMapView(lastLocation!);
    }
  }


  void onMapReady(GoogleMapController value) {
    mapController = value;
    getLocation();
    addPolyLine();
  }



  void addPolyLine() {

    Polyline polyline = Polyline(points: routeExample2,strokeWidth: 5.0,color: Colors.black);

    mapController!.addPolyLine("1",polyline);
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }



  void onCameraMove(Location location) async{
    if(lastLocation == null){
      return;
    }
    locationMarker.value = await mapController!.getPointScreenFromMapView(lastLocation!);
  }


}
