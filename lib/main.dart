import 'package:flutter/material.dart';
import 'package:ykdromar_iitk_course_management/screens/CoursePage.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';
void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: CoursePage(),
      theme: Themes.myTheme,

    );
  }
}