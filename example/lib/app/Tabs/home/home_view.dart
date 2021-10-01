import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:low_calories_google_map_example/Helper/LoadingDialog.dart';
import 'package:low_calories_google_map_example/app/main_app_view.dart';
import 'package:low_calories_google_map_example/app/pick_up_new_trip/pick_up_new_trip_view.dart';
import 'package:sizer/sizer.dart';
import 'home_logic.dart';



class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeLogic logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          SizedBox(height: 20,),

          _Avatar(),

          SizedBox(height: 50,),

          _Category(),

          SizedBox(height: 20,),

          Row(
            children: [
              SizedBox(width: 20,),
              Expanded(child: InkWell(
                onTap: (){
                  Get.toNamed(PickUpNewTripPage.routeName,);
                },
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: TextField(
                  enabled: false,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.left,
                  autofocus: false,
                  showCursor: false,
                  decoration: InputDecoration(
                      hintText: "Search Another Place",
                      suffixIcon: Icon(Icons.search)
                  ),
                ),
              )),
              SizedBox(width: 20,),
            ],
          )



        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }
}





class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(width: 20,),

        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Hello Mohamed",style: Get.textTheme.bodyText2,),
            SizedBox(height: 15,),
            Text("Welcome Back !",style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("4 Days For You",style: Get.textTheme.headline4!.copyWith(color: Get.theme.accentColor,fontWeight: FontWeight.bold),),

          ],
        ),flex: 4,),


        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Image.asset("assets/images/person.jpg",width: 50,height: 50,),
        ),


        SizedBox(width: 20,)

      ],
    );
  }
}


class _Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Where Are You Go",style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("choose your destination",style: Get.textTheme.bodyText2,),
              ],
            ),
          ),

          SizedBox(height: 5,),

          Container(
            height: 160,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [

                _ItemDestinationSaved(
                  image: "assets/icons/add.png",
                  title: "Add",
                  onTap: () {

                  },
                  color: Colors.black,
                ),

                _ItemDestinationSaved(
                  image: "assets/icons/home.png",
                  title: "Home",
                  onTap: () {

                  },
                  color: color1,
                ),


                _ItemDestinationSaved(
                  image: "assets/icons/work.png",
                  title: "Work",
                  onTap: () {

                  }, color: color2,
                ),


                SizedBox(width: 100,)

              ],
            ),
          )


        ],
      ),
    );
  }
}


class _ItemDestinationSaved extends StatelessWidget {

  final String title;
  final String image;
  final GestureTapCallback onTap;
  final Color color;
  const _ItemDestinationSaved({Key? key,required this.title,required this.image,required this.onTap,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10,left: 20),
      width: Get.width * 30 / 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 5,
            offset: Offset(0.0,3.0)
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: Image.asset(image,),
              ))
            ],
          ),
          
          SizedBox(height: 10,),
          
          Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: FittedBox(
                  child: Text(title,style: Get.textTheme.headline5!.copyWith(color: Colors.white),
                )),
              ))
            ],
          )

          
        ],
      ),
    );
  }
}




