import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';


class LoadingDialog {
  static Widget getLoading({double size: 200.0,Color? color}){
    if(color == null){
      color = Theme.of(Get.context!).textTheme.bodyText1!.color;
    }
    return Center(
      child: Container(
        child:Lottie.asset('assets/animations/loadingProgress.json',repeat: true,width: size,height: size),
      ),
    );
  }
}

class LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/animations/loadingProgress.json',repeat: true),
      ],
    );
  }
}

class EmptyList extends StatelessWidget {
  final GestureTapCallback? onTap;
  final dynamic iconData;
  final String text;
  const EmptyList({this.onTap,this.iconData = Icons.list, this.text = "Empty"});
  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(child: iconData is IconData ? Icon(iconData,color: Colors.white,size: 120,) : iconData,opacity: 0.2,),
            SizedBox(height: 30,),
            Opacity(child: Container(
              margin: EdgeInsets.only(right: 100,left: 100),
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(text,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline3,)),
            ),opacity: 0.8,),
          ],
        ),
      ),
    );
  }
}

class CustomTextGrey extends StatelessWidget {
  final String text;
  final double? size;
  CustomTextGrey(this.text,{this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: size ?? 30.sp),),
    );
  }
}


class EmptyWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final double? textSize;
  final double? iconSize;
  const EmptyWidget({this.icon, this.title, this.textSize, this.iconSize});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title!,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.withOpacity(0.7),fontSize: textSize ?? 30.sp),),
              Icon(icon,size:iconSize ?? 25.sp,color: Colors.grey.withOpacity(0.5),),
            ],
          )
      ),
    );
  }
}


success(String text){
  showSimpleNotification(
      Text(text,style: TextStyle(fontSize: 10.sp),),
      background: Colors.green);
}
error(String text){
  showSimpleNotification(
      Text(text,style: TextStyle(fontSize: 10.sp)),
      background: Colors.red);
}