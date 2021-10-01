import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppLogic extends GetxController with SingleGetTickerProviderMixin{

  TabController? tabController;
  RxInt currentIndex = 0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    currentIndex.value = 0;
    tabController = TabController(initialIndex: currentIndex.value, vsync: this,length: 4);
    super.onInit();
  }

  void changePage(int index) {
    currentIndex.value = index;
    tabController!.animateTo(currentIndex.value,duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
