import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map_example/Helper/LoadingDialog.dart';
import 'package:low_calories_google_map_example/app/Tabs/settings/settings_view.dart';
import 'package:sizer/sizer.dart';
import 'chat_logic.dart';



class ChatPage extends StatefulWidget {
  static const String routeName = "/ChatPage";
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatLogic logic = Get.put(ChatLogic());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 20,),


          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text("Messages",style: Get.textTheme.title!.copyWith(fontSize: 40.sp),),
          ),

          SizedBox(height: 50,),

          // Container(
          //   margin: EdgeInsets.only(left: 20),
          //   child: Text("Account",style: Get.textTheme.title!.copyWith(fontSize: 20.sp),),
          // ),


          Container(
            child: Row(
              children: [
                SizedBox(width: 20,),
                Expanded(child: TextField(
                  enabled: false,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.left,
                  autofocus: false,
                  showCursor: false,
                  decoration: InputDecoration(
                      hintText: "Search for message",
                      suffixIcon: Icon(Icons.search)
                  ),
                )),
                SizedBox(width: 20,),
              ],
            ),
          ),

          SizedBox(height: 20,),


          ItemChat(
            assets: "assets/images/person.jpg",
            title: "Mohamed Tarek",
            subTitle: "Hi There i'm Here need this",
            onTap: () {

            },
          ),


          ItemChat(
            assets: "assets/images/person2.jpg",
            title: "Mohamed Tarek",
            subTitle: "Hi There i'm Here need using this app please no comment about this  Here need using this app please no comment ab",
            onTap: () {

            },
          ),


          ItemChat(
            assets: "assets/images/person3.jpg",
            title: "Mohamed Tarek",
            subTitle:"Hi There i'm please no comment about this",
            onTap: () {

            },
          ),


          ItemChat(
            assets: "assets/images/person4.jpg",
            title: "Mohamed Tarek",
            subTitle: "There i'm Here neHi ed mment about thi using this s",
            onTap: () {},
          ),



          SizedBox(height: 250,)

        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChatLogic>();
    super.dispose();
  }
}


class ItemChat extends StatelessWidget {
  final String assets;
  final String title;
  final String? subTitle;
  final GestureTapCallback onTap;
  final Widget? childIcon;
  const ItemChat({Key? key,required this.assets,required this.title, this.subTitle,required this.onTap, this.childIcon}) : super(key: key);
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
                Text(title,maxLines: 1,style: Get.theme.textTheme.bodyText1!.copyWith(fontSize: 15.sp),),
                subTitle != null ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(subTitle!,maxLines: 3,textAlign: TextAlign.start,style: Get.theme.textTheme.bodyText2!.copyWith(fontSize: 11.0.sp),),
                ) : Container(),
              ],
            )),

            Expanded(child: childIcon ?? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.circle,color: Colors.green,size: 18,),
                Text("04:00 Am",style: Get.textTheme.bodyText2!.copyWith(fontSize: 8.5.sp),)
              ],
            ))


          ],
        ),
      ),
    );
  }
}

