import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map_example/Helper/LoadingDialog.dart';
import 'package:low_calories_google_map_example/app/Tabs/home/home_view.dart';
import 'package:sizer/sizer.dart';
import 'settings_logic.dart';



class SettingsPage extends StatefulWidget {
  static const String routeName = "/SettingsPage";
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final SettingsLogic logic = Get.put(SettingsLogic());


  @override
    Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 20,),

          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text("Settings",style: Get.textTheme.title!.copyWith(fontSize: 40.sp),),
          ),

          SizedBox(height: 50,),

          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text("Account",style: Get.textTheme.title!.copyWith(fontSize: 20.sp),),
          ),

          SizedBox(height: 50,),

          ItemSettings(
            assets: "assets/images/person.jpg",
            title: "Mohamed Tarek",
            subTitle: "Personal Info",
            onTap: () {

            },
          ),

          SizedBox(height: 50,),

          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text("Settings",style: Get.textTheme.title!.copyWith(fontSize: 25.sp),),
          ),

          SizedBox(height: 50,),

          ItemSettings(
            assets: "assets/icons/translate.png",
            title: "Language",
            subTitle: "English",
            onTap: () {

            },
          ),

          ItemSettings(
            assets: "assets/icons/bell.png",
            title: "Notification",
            subTitle: "Off",
            onTap: () {

            },
          ),

          ItemSettings(
            assets: "assets/icons/moon.png",
            title: "Dark Mode",
            subTitle: "Off",
            childIcon: CupertinoSwitch(
              onChanged: (value){

              }, value: true,
            ),
            onTap: () {

            },
          ),

          ItemSettings(
            assets: "assets/icons/question.png",
            title: "Help",
            onTap: () {

            },
          ),

          ItemSettings(
            assets: "assets/icons/power-off.png",
            title: "Log Out",
            onTap: () {

            },
          ),

          SizedBox(height: 250,)

        ],
      ),
    );
    }

  @override
  void dispose() {
    Get.delete<SettingsLogic>();
    super.dispose();
  }
}


class ItemSettings extends StatelessWidget {
  final String assets;
  final String title;
  final String? subTitle;
  final GestureTapCallback onTap;
  final Widget? childIcon;
  const ItemSettings({Key? key,required this.assets,required this.title, this.subTitle,required this.onTap, this.childIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AvatarUser(
              assets: assets,
            ),

            SizedBox(width: 10,),

            Expanded(flex: 2,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,style: Get.theme.textTheme.bodyText1!.copyWith(fontSize: 15.sp),),
                subTitle != null ? Text(subTitle!,style: Get.theme.textTheme.bodyText2!.copyWith(fontSize: 12.sp),) : Container(),
              ],
            )),

            childIcon ?? ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: FittedBox(
                  child: Container(
                    margin: EdgeInsets.all(25),
                      child: Icon(Icons.arrow_forward_ios)),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}



class AvatarUser extends StatelessWidget {
  final String? assets;
  const AvatarUser({Key? key,required this.assets}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Image.asset(assets!,width: 50,height: 50,),
    );
  }
}




