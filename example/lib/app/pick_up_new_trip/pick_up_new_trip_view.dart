import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/GoogleMapView.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map_example/app/pick_up_auto_complete_location/pick_up_auto_complete_location_logic.dart';
import 'package:low_calories_google_map_example/app/pick_up_auto_complete_location/pick_up_auto_complete_location_view.dart';
import 'pick_up_new_trip_logic.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class PickUpNewTripPage extends StatefulWidget {
  static const String routeName = "/PickUpNewTripPage";
  @override
  _PickUpNewTripPageState createState() => _PickUpNewTripPageState();
}

class _PickUpNewTripPageState extends State<PickUpNewTripPage> {
  final PickUpNewTripLogic controller = Get.put(PickUpNewTripLogic());


  @override
    Widget build(BuildContext context) {

      return Scaffold(

        body: Stack(
          children: [

            GoogleMapView(
              mapStyle: MapStyle.Dark,
              onMapCreate: controller.onMapCreate,
              onCameraMove: controller.onCameraMove,
              onCameraIdl: controller.onCameraIdl,
            ),

            // SlidingUpPanel(
            //   maxHeight: controller.maxHeight.value,
            //   minHeight: controller.minHeight.value,
            //   parallaxEnabled: true,
            //   parallaxOffset: .9,
            //   controller: controller.panelController,
            //   body:Container(
            //     margin: EdgeInsets.only(bottom: controller.minHeight.value),
            //     child: GoogleMapView(
            //       mapStyle: MapStyle.Dark,
            //       onMapCreate: controller.onMapCreate,
            //       onCameraMove: controller.onCameraMove,
            //       onCameraIdl: controller.onCameraIdl,
            //     ),
            //   ),
            //
            //   panelBuilder: (sc) => PickUpAutoCompleteLocationPage(),
            //
            //   onPanelSlide: (double pos) {
            //     controller.fabHeight.value = pos * (controller.maxHeight.value - controller.minHeight.value) + controller.initFabHeight.value;
            //   },
            //   onPanelClosed: (){
            //     Get.find<PickUpAutoCompleteLocationLogic>().focusOther.value = false;
            //     Get.find<PickUpAutoCompleteLocationLogic>().focusMyLocation.value = false;
            //     controller.showAppBar.value = false;
            //   },
            //   onPanelOpened: (){
            //     controller.showAppBar.value = true;
            //   },
            // ),
            //
            //
            //

            Obx((){
              return Positioned(
                right: 20.0,
                bottom: controller.fabHeight.value,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.gps_fixed,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: controller.getLocation,
                  backgroundColor: Colors.white,
                ),
              );
            }),
            //


          ],
        ),

      );
    }

  @override
  void dispose() {
    Get.delete<PickUpNewTripLogic>();
    super.dispose();
  }
}







/*

        Pin Option



                  Obx((){
                    var pin = controller.pinWork.value;
                    return AnimatedPositioned(right: 0,left: 0,bottom: pin ? 70 : 50,top: 0,duration: Duration(milliseconds: 100),child: Center(
                      child: Image.asset("assets/icons/pin_red.png",width: 20.sp,),
                    ),);
                  }),


                  Obx((){
                    var pin = controller.pinWork.value;
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 8,width: 8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black
                        ),
                      ),
                    );
                  }),


 */
