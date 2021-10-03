import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/Controllers/GoogleMapController.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/Locaiton.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PickUpNewTripLogic extends GetxController{


  PanelController panelController = PanelController();
  GoogleMapController? mapController;
  RxBool pinWork = false.obs;
  RxBool showAppBar = false.obs;
  RxDouble fabHeight = ((Get.height * 30 / 100) + 25).obs;
  RxDouble maxHeight = (Get.height * 80 / 100).obs;
  RxDouble minHeight = (Get.height * 0 / 100).obs;
  RxDouble initFabHeight = ((Get.height * 30 / 100) + 25).obs;


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreate(GoogleMapController controller) {
     mapController = controller;
     getLocation();
  }

  void onCameraMove(Location value) {
    pinWork.value = true;
  }

  void onCameraIdl(Location value) {
    pinWork.value = false;
  }

  void getLocation() async{
    Location? lastLocation = await GoogleMapController.getLocation(Get.context!);
    if(lastLocation!=null){
      mapController!.animateTo(lastLocation,zoom: 18);
      // await Future.delayed(Duration(seconds: 1));
      mapController!.addMarker(Marker("0", child:lottie.Lottie.asset('assets/animations/location_update.json',repeat: true), position:lastLocation,));

      refresh();
    }
  }




  void showPickUpLocation1() {

  }

  void showPickUpLocation2() {

  }

}
