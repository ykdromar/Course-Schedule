// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/screens/CoursePage.dart';
import 'package:ykdromar_iitk_course_management/screens/editData.dart';
import 'package:ykdromar_iitk_course_management/utils/routes.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
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
        routes.homeRoute:(context)=>CoursePage(),
        routes.editRoute:(context)=>EditData(),

      }

    );
  }
}

class Splash2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
seconds: 3,
      navigateAfterSeconds: CoursePage(),
      title:Text("Welcome Yash", textScaleFactor: 2,style: TextStyle(color: Themes.darkBlue),),
      image: Image.asset("assets/images/dna3.png", scale: 2,),
      loadingText: Text("Loading Please Wait..."),
      photoSize: 220.0,
      loaderColor: Themes.darkBlue,

    );
  }
}