import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:low_calories_google_map/low_calories_google_map.dart';
import 'package:low_calories_google_map_example/Style/StyleController.dart';
import 'package:low_calories_google_map_example/main/main_view.dart';
import 'package:low_calories_google_map_example/navigation/navigation_view.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}



bool isLandScape(){
  return  MediaQuery.of(Get.context!).orientation == Orientation.landscape;
}

//

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (_,s,__){
        return GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild!.unfocus();
            }
          },
          child: OverlaySupport.global(child: GetMaterialApp(
            title: 'Low Calories',
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.locale,
            debugShowCheckedModeBanner: false,
            // It is not mandatory to use named routes, but dynamic urls are interesting.
            initialRoute:MainPage.routeName,
            defaultTransition: Transition.cupertino,
            // locale: Locale('en', 'US'),
            // theme: ThemeApp().themeDark(),
            theme: StyleController().themeData(context),
            getPages: [
              GetPage(name: NavigationPage.routeName, page: () => NavigationPage(),),
              GetPage(name: MainPage.routeName, page: () => MainPage(),),
              //profile settings
            ],
          )) ,
        );
      },
    );
  }
}






// class Example extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<Example> {
//
//   List<Location>? list = decodePolyLineLocation("sbkvD_xs}DW?WDkBhBYTi@\\_Bp@s@ToA\\aJNk@DcBPa@Cs@A}@a@SEk@SeAk@w@u@aC_Ca@KMCcGmGwA_BwCyC{EmFePsPmHuH_FeFe@}@G{@A{@@WLy@HYBg@E[Qo@u@oAaAgB_AiCoAyDmC{I]oA|@]`Bs@");
//   GoogleMapController? controller;
//
//
//   @override
//   void initState() {
//     super.initState();
//     // initPlatformState();
//     // addGreenMarker();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     await Future.delayed(Duration(seconds: 2));
//     controller!.addMapStyle(MapStyle.Silver);
//     controller!.animatePolyLine(overviewPolyline: "sbkvD_xs}DW?WDkBhBYTi@\\_Bp@s@ToA\\aJNk@DcBPa@Cs@A}@a@SEk@SeAk@w@u@aC_Ca@KMCcGmGwA_BwCyC{EmFePsPmHuH_FeFe@}@G{@A{@@WLy@HYBg@E[Qo@u@oAaAgB_AiCoAyDmC{I]oA|@]`Bs@");
//     addNavigationMarker();
//   }
//
//
//   addNavigationMarker(){
//     Marker marker3 = Marker("3");
//     marker3.position = Location(list![0].lat, list![0].lng);
//     marker3.heading = getRotationToLocation(list![0].lat!, list![0].lng!, list![1].lat!, list![1].lng!);
//     marker3.height = 35;
//     marker3.width = 35;
//     marker3.isFlat = true;
//     marker3.assets = "assets/icons/navigation.png";
//     controller!.addMarker(marker3);
//   }
//
//
//   updateNavigationMarker()async{
//     int index = 0;
//     for(Location position in list!){
//       UpdateMarker marker3 = UpdateMarker();
//       marker3.position = Location(position.lat, position.lng);
//       marker3.height = 35;
//       marker3.width = 35;
//       marker3.heading = getRotationToLocation(position.lat!, position.lng!, list![index+1].lat!, list![index+1].lng!);
//       controller!.updateMarker("3", marker3);
//       await Future.delayed(Duration(seconds: 2));
//       index++;
//     }
//   }
//
//
//
//
//   addGreenMarker(){
//
//     Marker marker2 = Marker("2");
//     marker2.position = Location(list![0].lat, list![0].lng);
//     marker2.height = 50;
//     marker2.width = 50;
//     marker2.assets = "assets/icons/navigation_green.png";
//     marker2.scaleMarkerAnimation = ScaleMarkerAnimation(
//       autoReverses: true,
//       fromValue: 1.0,
//       toValue: 1.2,
//       duration: 1,
//     );
//
//     controller!.addMarker(marker2);
//
//
//
//
//     // Marker marker1 = Marker("1");
//     // marker1.scaleMarkerAnimation = ScaleMarkerAnimation(
//     //   autoReverses: true,
//     //   fromValue: 3.0,
//     //   toValue: 5.0,
//     //   duration: 1,
//     // );
//     //
//     //
//     // marker1.opacity = 0.5;
//     // marker1.position = PositionMarker(list![0][0], list![0][1]);
//     // marker1.height = 20;
//     // marker1.width = 20;
//     // marker1.isFlat = true;
//     // marker1.assets = "assets/icons/background_navigation_green.png";
//     // LowCaloriesGoogleMap.addMarker(marker1);
//     //
//
//
//
//
//
//   }
//
//
//   addMarkerDotAnimation(){
//     Marker marker1 = Marker("1");
//     marker1.scaleMarkerAnimation = ScaleMarkerAnimation(
//       autoReverses: true,
//       fromValue: 0.5,
//       toValue: 1.0,
//       duration: 2,
//     );
//
//     marker1.opacity = 0.5;
//     marker1.position = Location(list![0].lat, list![0].lng);
//     marker1.height = 80;
//     marker1.width = 80;
//     marker1.assets = "assets/icons/circle.png";
//     controller!.addMarker(marker1);
//
//
//     Marker marker2 = Marker("2");
//     marker2.position = Location(list![0].lat, list![0].lng);
//     marker2.height = 16;
//     marker2.width = 16;
//     marker2.assets = "assets/icons/circle-small.png";
//     controller!.addMarker(marker2);
//   }
//
//
//   updateMarkerDot()async{
//     for(Location position in list!){
//       UpdateMarker marker1 = UpdateMarker();
//       marker1.scaleMarkerAnimation = ScaleMarkerAnimation(
//         autoReverses: true,
//         fromValue: 0.5,
//         toValue: 1.0,
//         duration: 2,
//       );
//       marker1.opacity = 0.5;
//       marker1.position = Location(position.lat, position.lng);
//       marker1.height = 80;
//       marker1.width = 80;
//
//
//       UpdateMarker marker2 = UpdateMarker();
//       marker2.position = Location(position.lat, position.lng);
//       marker2.height = 16;
//       marker2.width = 16;
//
//
//       controller!.updateMarker("1", marker1);
//       controller!.updateMarker("2", marker2);
//
//       await Future.delayed(Duration(seconds: 2));
//     }
//   }
//
//   Location? location;
//
//
//
//   getLocation()async{
//     location = await controller!.getLocation(context);
//     print("location : " + location!.toJson().toString());
//
//     Marker marker2 = Marker("2");
//     marker2.position = Location(location!.lat, location!.lng);
//     marker2.height = 50;
//     marker2.width = 50;
//     marker2.assets = "assets/icons/navigation_green.png";
//     marker2.scaleMarkerAnimation = ScaleMarkerAnimation(
//       autoReverses: true,
//       fromValue: 1.0,
//       toValue: 1.2,
//       duration: 1,
//     );
//
//     controller!.addMarker(marker2);
//
//     controller!.animateTo(location!,zoom: 14);
//   }
//
//
//
//   late StreamSubscription<double>? streamSubscription;
//   late StreamSubscription<Location>? streamLocationUpdate;
//
//   @override
//   void dispose() {
//     streamSubscription?.cancel();
//     streamLocationUpdate?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           GoogleMapView(
//             mapStyle: MapStyle.Silver,
//             onMapCreate: (GoogleMapController controller){
//               this.controller = controller;
//             },
//           ),
//
//           Positioned(child: Container(
//             child: Column(
//               children: [
//
//
//                 RaisedButton(
//                   onPressed: ()async{
//                     controller!.addPadding(top: MediaQuery.of(context).size.height * 50 / 100);
//
//                     Stream<Location>? streamlocation = await controller!.onLocationUpdate(context);
//
//                     streamLocationUpdate = streamlocation!.listen((event) {
//                       this.location = event;
//                     });
//
//                   },
//                   child: Text("start Location Update"),
//                 ),
//
//                 RaisedButton(
//                   onPressed: ()async{
//                     streamLocationUpdate!.cancel();
//                   },
//                   child: Text("stop Location Update"),
//                 ),
//
//                 RaisedButton(
//                   onPressed: ()async{
//                     controller!.addPadding(top: MediaQuery.of(context).size.height * 50 / 100);
//                     streamSubscription = controller!.onHeadingUpdate.listen((event) {
//                       // print("heading flutter : " + event.toString());
//                       UpdateMarker marker2 = UpdateMarker();
//                       marker2.position = Location(location!.lat, location!.lng);
//                       marker2.height = 50;
//                       marker2.width = 50;
//                       marker2.heading = event;
//                       controller!.updateMarker("2", marker2);
//                       controller!.animateTo(location!,zoom: 18,heading: event,viewingAngle: 40.0);
//                     });
//                   },
//                   child: Text("start Heading"),
//                 ),
//                 RaisedButton(
//                   onPressed: ()async{
//                     streamSubscription!.cancel();
//                   },
//                   child: Text("stop Heading"),
//                 )
//               ],
//             ),
//           ),bottom: 0,right: 0,left: 0,)
//
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getLocation,
//         child: Icon(Icons.gps_fixed),
//       ),
//     );
//
//   }
//
// }
