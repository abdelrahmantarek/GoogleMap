import 'package:get/get.dart';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map/model/InfoWindow.dart';


class MarkerViewLogic extends GetxController {

  RxList<Marker> markers = RxList<Marker>([]);
  RxList<InfoWindow> infoWindows = RxList<InfoWindow>([]);

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
}
