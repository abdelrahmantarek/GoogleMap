import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map_example/Helper/LoadingDialog.dart';
import 'package:low_calories_google_map_example/app/Tabs/chat/chat_view.dart';
import 'package:low_calories_google_map_example/app/Tabs/home/home_view.dart';
import 'package:low_calories_google_map_example/app/Tabs/settings/settings_view.dart';
import 'package:sizer/sizer.dart';
import 'main_app_logic.dart';

Color color1 = Color(0xFF49B583);
Color color2 = Color(0xFFFF4171);
Color color3 = Color(0xFFFFBD69);
Color color4 = Color(0xFF7F86FF);

class MainAppPage extends StatefulWidget {
  static const String routeName = "/MainAppPage";
  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  final MainAppLogic controller = Get.put(MainAppLogic());

  @override
  Widget build(BuildContext context) {

    return Theme(
        data: ThemeData.light().copyWith(
            accentColor: Color(0xFF49B583),
            textTheme: TextTheme(
              // bottom navigation
              headline1: TextStyle(color: Colors.black87, fontSize: 10.sp),
            ),
            // edit text
            inputDecorationTheme: InputDecorationTheme(
              isCollapsed: true,
              filled: true,
              hoverColor: Colors.white,
              fillColor: Colors.grey.withOpacity(0.2),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 0.9, style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 0.9, style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 0.9, style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: Colors.grey, fontSize: 11.sp),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
            )),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                    child: TabBarView(
                  controller: controller.tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomePage(),
                    ChatPage(),
                    Container(
                      alignment: Alignment.center,
                      child: EmptyWidget(
                        title: "Any",
                      ),
                    ),
                    SettingsPage(),
                  ],
                )),
                Positioned(
                  child: Obx(() {
                    return BottomNavigationHe(
                      titles: [
                        "Home",
                        "Chat",
                        "Trips",
                        "Settings",
                      ],
                      icons: [
                        "assets/icons/home.png",
                        "assets/icons/chat.png",
                        "assets/icons/destination.png",
                        "assets/icons/settings.png",
                      ],
                      onTap: controller.changePage,
                      currentIndex: controller.currentIndex.value,
                    );
                  }),
                  bottom: 0,
                  right: 10,
                  left: 10,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    Get.delete<MainAppLogic>();
    super.dispose();
  }
}

class BottomNavigationHe extends StatelessWidget {
  final int currentIndex;
  final List<String> icons;
  final List<String> titles;
  final ValueChanged<int> onTap;
  const BottomNavigationHe(
      {Key? key,
      this.currentIndex = 0,
      required this.icons,
      required this.titles,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget>? list() {
      List<Widget> ss = [];
      int index = 0;
      print(currentIndex);
      for (String s in icons) {
        int myIndex = index;
        ss.add(Expanded(
            child: InkWell(
          onTap: () {
            print(myIndex);
            onTap(myIndex);
          },
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Column(
            children: [
              Image.asset(
                icons[index],
                scale: 3.8.sp,
                color: currentIndex == index
                    ? Get.theme.accentColor
                    : Colors.white,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                titles[index],
                style: Get.theme.textTheme.bodyText2!.copyWith(
                  color: currentIndex == index
                      ? Get.theme.accentColor
                      : Colors.white,
                ),
              )
            ],
          ),
        )));
        index++;
      }
      return ss;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: list()!),
    );
  }
}
