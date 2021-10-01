import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_orders_logic.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final MyOrdersLogic logic = Get.put(MyOrdersLogic());

  @override
    Widget build(BuildContext context) {
      return Container();
    }

  @override
  void dispose() {
    Get.delete<MyOrdersLogic>();
    super.dispose();
  }
}