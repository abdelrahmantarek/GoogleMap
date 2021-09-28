import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:low_calories_google_map/GoogleMapView.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'navigation_logic.dart';
import 'package:sizer/sizer.dart';

class NavigationPage extends StatefulWidget {
  static const String routeName = "/NavigationPage";
  @override
  _NavigationPageState createState() => _NavigationPageState();
}


class _NavigationPageState extends State<NavigationPage> {
  final NavigationLogic logic = Get.put(NavigationLogic());

  @override
    Widget build(BuildContext context) {
      return _NavigationPage();
    }

  @override
  void dispose() {
    Get.delete<NavigationLogic>();
    super.dispose();
  }
}


class _NavigationPage extends GetView<NavigationLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          GoogleMapView(
            mapStyle: MapStyle.Night,
            onMapCreate: controller.onMapReady,
          ),


          Positioned(child: Container(
            height: 170,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.blue,
                  // Colors.white,
                  Colors.transparent,
                ]
              )
            ),
            child: Row( // navigation_blue_have_shadows
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(child: IconButton(onPressed: (){
                  controller.addPolyLine();
                },icon: Icon(Icons.menu,size: 25.sp,color: Colors.white,))),

                GestureDetector(
                  onTap: controller.runLocationUpdate,
                  child: Container(
                    child: Obx((){
                      return AnimatedSwitcher(duration: Duration(seconds: 1),
                      child: controller.locationUpdate.value ? Lottie.asset('assets/animations/location_update.json',repeat: true,width: Get.width * 15 / 100) : Image.asset("assets/icons/navigation_blue_have_shadows.png",width: Get.width * 15 / 100,));
                    }),
                  ),
                ),

                Expanded(child: IconButton(onPressed: (){
                  controller.getLocation();
                },icon: Icon(Icons.add_location_alt_outlined,size: 25.sp,color: Colors.white,)))

              ],
            ),
          ),bottom: 0,right: 0,left: 0,)




        ],
      ),
    );
  }
}
