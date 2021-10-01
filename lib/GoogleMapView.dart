

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map/Controllers/GoogleMapController.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/marker_view/marker_view_logic.dart';
import 'package:low_calories_google_map/marker_view/marker_view_view.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';


typedef void MapCreatedCallback(GoogleMapController controller);



class GoogleMapView extends StatefulWidget {
  final MapCreatedCallback? onMapCreate;
  final ValueChanged<Location>? onCameraMove;
  final ValueChanged<Location>? onCameraIdl;
  final MapStyle? mapStyle;
  const GoogleMapView({Key? key,
    this.onMapCreate,
    this.mapStyle = MapStyle.Standard, this.onCameraMove, this.onCameraIdl
  }) : super(key: key);
  @override
  GoogleMapViewState createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {


  @override
  void initState(){
    Get.put(GoogleMapController());
    Get.put(MarkerViewLogic());
    super.initState();
  }

  @override
  void dispose() async{
    Get.delete<GoogleMapController>();
    Get.delete<MarkerViewLogic>();
    super.dispose();
  }


  Future<void> onPlatformViewCreated(int id) async {
    Get.find<GoogleMapController>().init(this, id);
    if (widget.onMapCreate != null) {
        widget.onMapCreate!(Get.find<GoogleMapController>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MapView(state: this,);
  }

}

class MapView extends GetView<GoogleMapController> {
  final GoogleMapViewState? state;
  final Widget? child;
  const MapView({Key? key, this.child, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String viewType = 'plugins.flutter.io/google_maps';


    return Stack(
      children: [

        Platform.isIOS ? UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.rtl,
          creationParams: {"mapStyle": Styles.getStyle(state!.widget.mapStyle!)},
          onPlatformViewCreated: state!.onPlatformViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
        ) : Scaffold(
          body: Center(
            child: Text("is Android"),
          ),
        ),

        MarkerViewPage(),

        InfoWindowView(),

      ],
    );
  }
}







