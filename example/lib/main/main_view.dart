import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map_example/app/main_app_view.dart';
import 'package:low_calories_google_map_example/info_window/info_window_view.dart';
import 'package:low_calories_google_map_example/navigation/navigation_view.dart';

import 'main_logic.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "/MainPage";
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainLogic logic = Get.put(MainLogic());

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
          children: [

            SizedBox(height: Get.height * 10 / 100,),

            ItemPage(
              title: "Navigation",
              subTitle: "navigation screen is map - marker - go to destination",
              onTap: (){
                Get.toNamed(NavigationPage.routeName);
              },
            ),

            ItemPage(
              title: "Info Window",
              subTitle: "info window - route - markers",
              onTap: (){
                Get.toNamed(InfoWindowPage.routeName);
              },
            ),

            ItemPage(
              title: "App Test",
              subTitle: "for - test - new app",
              onTap: (){
                Get.toNamed(MainAppPage.routeName);
              },
            ),


            SizedBox(height: Get.height * 10 / 100,),

          ],
        ),
      );
    }

  @override
  void dispose() {
    Get.delete<MainLogic>();
    super.dispose();
  }
}


class ItemPage extends GetView<MainLogic> {
  final String? title;
  final String? subTitle;
  final GestureTapCallback? onTap;

  ItemPage({this.title, this.subTitle, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        minVerticalPadding: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        onTap: onTap,
        leading: Icon(Icons.add),
        title: Text(title!),
        subtitle: Text(subTitle!),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

