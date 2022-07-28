import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/utils/courseModel.dart';
import 'package:ykdromar_iitk_course_management/utils/courseTile.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

class CoursePage extends StatefulWidget{

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String day=DateFormat('EEEE').format(DateTime.now());

  @override
  void initState(){
    super.initState();
    LoadData();
  }

  LoadData()async{
    var courseJson= await rootBundle.loadString("assets/files/courses.json") ;
    var decodedData=jsonDecode(courseJson);
    var productData=decodedData["$day"];
    CourseModel.courseList=List.from(productData).map<Course>((course)=>Course.fromMap(course)).toList();

    setState((){});
  }
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            // begin: FractionalOffset.topLeft,
            // end: FractionalOffset.bottomRight,
            colors: [
              Colors.white,
              Colors.tealAccent,
              Colors.teal
            ],


          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Material(
              child: Column(
                children: [
                  Header(),

                  SizedBox(height: 2,),
                  courseList(),

                ],
              ),
            )
        ),
      ),
    );

  }
}

class Header extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Courses Semester III",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Themes.darkBlue,

                ),
              ),
              Text("Biological Sciences & Bioengineering",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black
              ),
              ),
            ],
          ),
        ),
      );

  }
}

class courseList extends StatefulWidget{
  @override
  State<courseList> createState() => _courseListState();
}

class _courseListState extends State<courseList> {
  int currHour=int.parse(DateFormat('H').format(DateTime.now()));

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        child:ListView.builder(
          shrinkWrap: true,
            itemCount: CourseModel.courseList.length,
            itemBuilder: (context,index){

        Course course=CourseModel.courseList[index];

        return CourseTile(course: course);




  },
        )
      ),
    );

  }
}