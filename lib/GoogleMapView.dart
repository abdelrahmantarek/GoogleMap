

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:low_calories_google_map/Controllers/GoogleMapController.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';


typedef void MapCreatedCallback(GoogleMapController controller);


class GoogleMapView extends StatefulWidget {
  final MapCreatedCallback? onMapCreate;
  final MapStyle? mapStyle;
  const GoogleMapView({Key? key,
    this.onMapCreate,
    this.mapStyle = MapStyle.Standard
  }) : super(key: key);
  @override
  GoogleMapViewState createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async{
    super.dispose();
    GoogleMapController controller = await _controller.future;
    controller.dispose();
  }




  Future<void> onPlatformViewCreated(int id) async {
    print("onPlatformViewCreated " + id.toString());
    final GoogleMapController controller = await GoogleMapController.init(id, this,);
    _controller.complete(controller);
    if (widget.onMapCreate != null) {
        widget.onMapCreate!(controller);
    }
  }


  @override
  Widget build(BuildContext context) {

    final String viewType = 'plugins.flutter.io/google_maps';

    if(Platform.isIOS){
      return UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.rtl,
        creationParams: {"mapStyle": Styles.getStyle(widget.mapStyle!)},
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Scaffold(
      body: Center(
        child: Text("is Android"),
      ),
    );

  }
}


