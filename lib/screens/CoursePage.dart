import 'package:flutter/cupertino.dart';
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
  int currTime=int.parse(DateFormat('H').format(DateTime.now()));

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
          gradient: LinearGradient(colors: [
            Themes.darkBlue,

            Colors.blueAccent,
            Colors.white
          ]

          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),

                  SizedBox(height: 2,),
                  Padding(padding: EdgeInsets.all(15),
                    child: Text("Upcoming Lectures",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 19,
                        color: Themes.darkBlue,

                      ),
                    ),
                  ),

                  courseList(),
                  Padding(padding: EdgeInsets.all(15),
                  child: Text("Past Lectures",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Themes.darkBlue,

                    ),
                  ),
                  ),

                  courseListPast()


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
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Themes.darkBlue,

            Colors.blueAccent,
            // Colors.blue,
            Colors.white
          ]

          )
      ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Courses Semester III",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,

                    ),
                  ),
                  Text("Biological Sciences & Bioengineering",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
              SizedBox(width: 65,),
              Icon(CupertinoIcons.profile_circled,color: Themes.darkBlue,),
              SizedBox(width: 10,),
              Icon(CupertinoIcons.settings_solid,color:Themes.darkBlue,)
              
            ],
          ),
        ),
      );

  }
}



class courseList extends StatelessWidget {
  var list=CourseModel.courseList.where((element) => (element.hour!>=int.parse(DateFormat('H').format(DateTime.now())))).toList();

  @override
  Widget build(BuildContext context){
    return Container(

      child:ListView.builder(
        shrinkWrap: true,
          itemCount:list.length,
          itemBuilder: (context,index){
          return CourseTile(course: list[index]);




  },
      )
    );

  }
}

class courseListPast extends StatelessWidget {
  var list=CourseModel.courseList.where((element) => (element.hour!<int.parse(DateFormat('H').format(DateTime.now())))).toList();

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
          child:ListView.builder(
            shrinkWrap: true,
            itemCount:list.length,
            itemBuilder: (context,index){
              return CourseTile(course: list[index]);




            },
          )
      ),
    );

  }
}