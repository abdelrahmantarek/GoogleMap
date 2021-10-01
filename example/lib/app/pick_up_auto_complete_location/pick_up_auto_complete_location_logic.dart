import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PickUpAutoCompleteLocationLogic extends GetxController with SingleGetTickerProviderMixin{


  TextEditingController text1 = TextEditingController(text: "3 - q Bostan El Tag");
  TextEditingController text2 = TextEditingController(text: "234 - Hillsdsw Road, Hstiman");

  RxBool focusMyLocation = false.obs;
  RxBool focusOther = false.obs;

  FocusNode nodeFocusMe = FocusNode();
  FocusNode nodeFocusOther = FocusNode();

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
