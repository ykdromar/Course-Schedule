// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/screens/CoursePage.dart';
import 'package:ykdromar_iitk_course_management/screens/addCourses.dart';
import 'package:ykdromar_iitk_course_management/screens/homeScreen.dart';
import 'package:ykdromar_iitk_course_management/utils/routes.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash2(),
      theme: Themes.myTheme,
      routes:{
        routes.courseRoute:(context)=>CoursePage(),
        routes.editRoute:(context)=>AddCourse(),
        routes.homeRoute:(context)=>Home(),

      }

    );
  }
}

class Splash2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
seconds: 2,
      navigateAfterSeconds: Home(),
      title:Text("Welcome", textScaleFactor: 2,style: TextStyle(color: Themes.darkBlue),),
      image: Image.asset("assets/images/splash.jpg", scale: 1,),
      loadingText: Text("Loading Please Wait..."),
      photoSize: 240.0,
      loaderColor: Themes.darkBlue,

    );
  }
}