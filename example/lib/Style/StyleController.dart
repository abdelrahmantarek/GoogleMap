


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';




class StyleController with ChangeNotifier{



  ThemeData themeData(BuildContext context) {

    const MaterialColor white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFFFFFFFF),
        100: const Color(0xFFFFFFFF),
        200: const Color(0xFFFFFFFF),
        300: const Color(0xFFFFFFFF),
        400: const Color(0xFFFFFFFF),
        500: const Color(0xFFFFFFFF),
        600: const Color(0xFFFFFFFF),
        700: const Color(0xFFFFFFFF),
        800: const Color(0xFFFFFFFF),
        900: const Color(0xFFFFFFFF),
      },
    );

    const MaterialColor black = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFF000000),
        100: const Color(0xFF000000),
        200: const Color(0xFF000000),
        300: const Color(0xFF000000),
        400: const Color(0xFF000000),
        500: const Color(0xFF000000),
        600: const Color(0xFF000000),
        700: const Color(0xFF000000),
        800: const Color(0xFF000000),
        900: const Color(0xFF000000),
      },
    );

    return ThemeData(
        fontFamily: "Cairo",
        accentColor: Color(0xFF1CA34A),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor:Colors.white,
            elevation: 0,
            selectedIconTheme: IconThemeData(
                color: Color(0xFF1CA34A),
              size: 30.sp
            ),
            unselectedIconTheme: IconThemeData(
                color: Colors.grey.withOpacity(0.5),
                size: 30.sp
            ),
            selectedLabelStyle: TextStyle(
              color: Color(0xFF1CA34A)
            ),
            unselectedLabelStyle: TextStyle(
                color: Colors.grey
            ),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedItemColor:   Color(0xFF1CA34A),
            unselectedItemColor:  Colors.grey
        ),
        primaryColorDark: Color(0xFF1CA34A),
        primaryColorLight: Color(0xFF1CA34A),
        primarySwatch:  black,

        iconTheme: IconThemeData(color: Colors.black),
        primaryColor:  Color(0xFF1CA34A), 
        backgroundColor:  Colors.white,
        indicatorColor:  Colors.black,
        buttonColor:  Color(0xFF1CA34A),
        hintColor:  Colors.grey,

        hoverColor:  Color(0xff4285F4),
        focusColor:  Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        textSelectionTheme: TextSelectionThemeData(selectionHandleColor: Colors.black,cursorColor: Colors.black),
        cardColor:  Colors.white,
        canvasColor:  Colors.transparent,
        scaffoldBackgroundColor:  Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF1CA34A)),
                side: MaterialStateProperty.all(BorderSide(width: 0.5,color: Color(0xFF1CA34A))),
                textStyle: MaterialStateProperty.all(TextStyle(
                    color: Colors.white
                ))
            )
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF1CA34A),
        ),
        // Color(0xFF1CA34A)
        accentIconTheme: IconThemeData(
          color: Color(0xFF1CA34A),
        ),
        primaryIconTheme:  IconThemeData(
          color: Color(0xFF1CA34A),
        ),
        appBarTheme: AppBarTheme(
            elevation: 0,
            textTheme: TextTheme(
                title: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  Color(0xFF1CA34A),
                  fontSize: 14.sp
                ),
            ),
            actionsIconTheme: IconThemeData(
              color: Color(0xFF1CA34A),
              size: 25.sp,
            ),
            iconTheme: IconThemeData(
                color: Color(0xFF1CA34A),
            ),
            backgroundColor: Colors.white
        ),



        inputDecorationTheme: InputDecorationTheme(
          isCollapsed: true,
          filled: true,
          hoverColor: Colors.white,
          fillColor: Colors.grey.withOpacity(0.2),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,width: 0.9,style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,width: 0.9,style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,width: 0.9,style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          alignLabelWithHint: true,
          labelStyle: TextStyle(color: Colors.grey,fontSize: 11.sp),
          hintStyle: TextStyle(color: Colors.grey,fontSize: 11.sp),
        ),



        textTheme: TextTheme(

            subtitle1: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
            bodyText2:TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
                fontFamily: "Prompt"
            ),
            caption:TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                color: Colors.grey
            ),
            headline2: Theme.of(context).textTheme.headline2!.copyWith(color: Color(0xFF1CA34A)),
            bodyText1:Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black,letterSpacing: 2,)
        )
    );
  }


}