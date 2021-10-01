import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/Controllers/GoogleMapController.dart';
import 'marker_view_logic.dart';



class MarkerViewPage extends GetView<MarkerViewLogic> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Positioned.fill(child: Stack(
        overflow: Overflow.visible,
        children: controller.markers.where((element) => element.child!=null && element.offset!=null).map<Widget>((e){
          Offset offset = Offset(e.getX(), e.getY());
          return Positioned.fromRect(rect: Rect.fromCenter(center: offset, width: e.width!, height: e.height!), child: Container(
            child: IgnorePointer(
              ignoring: e.onTap == null,
              child:GestureDetector(
                onTap: e.onTap,
                child: e.child!,
              ),
            ),
          ) );
        }).toList(),
      ));
    });
  }
}





class InfoWindowView extends GetView<MarkerViewLogic> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Positioned.fill(child: Stack(

        children: controller.infoWindows.where((element) => element.child!=null && element.offset!=null).map<Widget>((e){
          return Positioned.fromRect(rect: Rect.fromCenter(center: e.offset!, width: e.width!, height: e.height!), child: IgnorePointer(
            ignoring: e.onTap == null,
            child:GestureDetector(
              onTap: e.onTap,
              child: e.child!,
            ),
          ) );
        }).toList(),
      ));
    });
  }
}
