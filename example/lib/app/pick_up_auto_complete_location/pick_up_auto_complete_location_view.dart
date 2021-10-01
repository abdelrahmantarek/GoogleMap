import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map_example/app/pick_up_new_trip/pick_up_new_trip_logic.dart';
import 'package:sizer/sizer.dart';
import 'pick_up_auto_complete_location_logic.dart';



class PickUpAutoCompleteLocationPage extends StatefulWidget {
  @override
  _PickUpAutoCompleteLocationPageState createState() => _PickUpAutoCompleteLocationPageState();
}

class _PickUpAutoCompleteLocationPageState extends State<PickUpAutoCompleteLocationPage> {
  final PickUpAutoCompleteLocationLogic controller = Get.put(PickUpAutoCompleteLocationLogic());

  @override
    Widget build(BuildContext context) {
      return Stack(
        children: [
          Column(
            children: [

              Obx((){
                return AnimatedSize(curve: Curves.linear, duration: Duration(milliseconds: 500),
                  reverseDuration: Duration(milliseconds: 500),
                  vsync: controller,
                  child: Container(
                    color: Colors.transparent,

                    height: controller.focusMyLocation.value ||  controller.focusOther.value ? 40 : 0.0,
                    // alignment: Alignment.centerLeft,
                    // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                    // child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                  ),);
              }),


              TowPointWidget(
                address1: controller.text1,
                address2: controller.text2,
              ),


              Expanded(child: ListView(
                children: [

                ],
              )),


            ],
          ),
          

        ],
      );
    }


  @override
  void dispose() {
    Get.delete<PickUpAutoCompleteLocationLogic>();
    super.dispose();
  }
}

class TowPointWidget extends GetView<PickUpAutoCompleteLocationLogic> {
  final TextEditingController address1;
  final TextEditingController address2;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;
  const TowPointWidget({Key? key,required this.address1,required this.address2, this.onTap1, this.onTap2}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 40,),

          Container(
            // height: controller.focusOther.value ? 0 : null,
            width: null,
            child: Row(
              children: [

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Icon(Icons.location_on,color: Colors.black,size: 30,),
                      SizedBox(height: 5,),
                      Container(height: 10,width: 2,decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),),
                      SizedBox(height: 5,),
                      Container(height: 10,width: 2,decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),),

                    ],
                  ),
                ),



                SizedBox(width: 20,),



                Expanded(flex: 3,child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Your Location",style: Get.theme.textTheme.bodyText2!.copyWith(fontSize: 12.sp),),
                    SizedBox(height: 5,),
                    // Text(address1,style: Get.theme.textTheme.bodyText1!.copyWith(fontSize: 15.sp),),
                    TextField(
                      controller: controller.text1,
                      focusNode: controller.nodeFocusMe,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search)
                      ),
                      onChanged: (t){
                        controller.focusOther.value = true;
                        controller.focusMyLocation.value = true;
                        Get.find<PickUpNewTripLogic>().panelController.open();
                      },
                    )
                  ],
                )),


              ],
            ),),

          SizedBox(height: 20,),

          Row(
            children: [

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(height: 10,width: 2,decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),),
                    SizedBox(height: 5,),
                    Container(height: 10,width: 2,decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),),
                    Icon(Icons.location_on,color: Colors.black,size: 30,),

                  ],
                ),
              ),

              SizedBox(width: 20,),

              Expanded(flex: 3,child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text("Your Delivery Address",style: Get.theme.textTheme.bodyText2!.copyWith(fontSize: 12.sp),),
                  SizedBox(height: 5,),
                  // Text(address2,style: Get.theme.textTheme.bodyText1!.copyWith(fontSize: 15.sp),),
                  TextField(
                    focusNode: controller.nodeFocusOther,
                    controller: controller.text2,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search)
                    ),
                    onChanged: (w){
                      controller.focusOther.value = true;
                      controller.focusMyLocation.value = true;
                      Get.find<PickUpNewTripLogic>().panelController.open();
                    },
                  )

                ],
              )),

            ],
          ),

        ],
      ),
    );
  }
}