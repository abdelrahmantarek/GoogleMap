

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';



class GoogleMapLowCalories extends StatelessWidget {

  final StyleColor? styleColor;
  const GoogleMapLowCalories({Key? key, this.styleColor = StyleColor.Standard}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String viewType = '<platform-view-type>';

    if(Platform.isIOS){
      return UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.rtl,
        creationParams: {"mapStyle": Styles.getStyle(styleColor!)},
        onPlatformViewCreated: (d) {
          print("onPlatformViewCreated " + d.toString());
        },
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
