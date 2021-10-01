import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:sizer/sizer.dart';
import 'info_window_logic.dart';



class InfoWindowPage extends StatefulWidget {
  static const String routeName = "/InfoWindowPage";
  @override
  _InfoWindowPageState createState() => _InfoWindowPageState();
}

class _InfoWindowPageState extends State<InfoWindowPage> {
  final InfoWindowLogic logic = Get.put(InfoWindowLogic());

  @override
    Widget build(BuildContext context) {
      return _InfoWindowPage();
    }

  @override
  void dispose() {
    Get.delete<InfoWindowLogic>();
    super.dispose();
  }
}

class _InfoWindowPage extends GetView<InfoWindowLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GoogleMapView(
        mapStyle: MapStyle.Silver,
        onMapCreate: controller.onMapReady,
        onCameraMove: controller.onCameraMove,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.getLocation();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}