import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/utils/courseModel.dart';
import 'package:ykdromar_iitk_course_management/utils/courseTile.dart';
import 'package:ykdromar_iitk_course_management/utils/databaseHelper.dart';
import 'package:ykdromar_iitk_course_management/utils/databaseManager.dart';
import 'package:ykdromar_iitk_course_management/utils/routes.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

class CoursePage extends StatefulWidget{

  @override
  State<CoursePage> createState() => _CoursePageState();
}
databaseManager? database=databaseHelper.database;
// Future<List<Course>>? futureCourseList;

class _CoursePageState extends State<CoursePage> {
  String day=DateFormat('EEEE').format(DateTime.now());
  int currTime=int.parse(DateFormat('H').format(DateTime.now()));



  // @override
  // void initState(){
  //   super.initState();
  //   LoadData();
  // }
  //
  // LoadData()async{
  //   var courseJson= await rootBundle.loadString("assets/files/courses.json") ;
  //   var decodedData=jsonDecode(courseJson);
  //   var productData=decodedData["$day"];
  //   CourseModel.courseList=List.from(productData).map<Course>((course)=>Course.fromMap(course)).toList();
  //
  //   setState((){});
  // }
   loadData() async {
    var db = database;
    if (db != null) {
      databaseHelper.futureCourseList = db.getCourses();

    }
    setState(() {

    });
  }


  @override
  void initState(){
    super.initState();
    database=databaseManager();
    loadData();



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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
                var db=database;
                if(db!=null) {
                  db.insert(
                    Course(code: 'yashghc',
                        name: 'yash,',
                        time: 'yash',
                        hour: "ds",
                        venue: 'yash'),
                  ).then((value) {
                    print("DataAdded");

                    setState((){
                      var db=database;
                      if(db!=null) {
                        databaseHelper.futureCourseList =db.getCourses();

                      }
                      // databaseHelper.futureCourseList=database!.getCourses();
                    });

                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                }
            },
          ),
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
            // Padding(padding: EdgeInsets.all(15),
            //         child: Text("Past Lectures",
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 19,
            //             color: Themes.darkBlue,
            //
            //           ),
            //         ),
            //         ),

                    // courseListPast()


                  ],
                ),
              )
          ),
        ),
      );


  }
}

class Header extends StatefulWidget{


  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
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
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, routes.editRoute);
                },
                //   var db=database;
                //   if(db!=null) {
                //     db.insert(
                //       Course(code: 'yash',
                //           name: 'yash,',
                //           time: 'yash',
                //           hour: 6,
                //           venue: 'yash'),
                //     ).then((value) {
                //       print("DataAdded");
                //
                //       setState((){
                //         var db=database;
                //         if(db!=null) {
                //           databaseHelper.futureCourseList =db.getCourses();
                //
                //         }
                //         // databaseHelper.futureCourseList=database!.getCourses();
                //       });
                //
                //     }).onError((error, stackTrace) {
                //       print(error.toString());
                //     });
                //   }
                // },

                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(Icons.edit,color:Themes.darkBlue,)),
              )

            ],
          ),
        ),
      );

  }
}



class courseList extends StatelessWidget {
  // var list=CourseModel.courseList.where((element) => (element.hour!>=int.parse(DateFormat('H').format(DateTime.now())))).toList();

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
          child: FutureBuilder(
          future: databaseHelper.futureCourseList,
          builder:(context,AsyncSnapshot<List<Course>> snapshot){
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: Themes.darkBlue,));
            }
              return ListView.builder(
                // shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CourseTile(course: snapshot.data![index]);
                },
              );

          },
        ),
      ),
    );

  }
}

// class courseListPast extends StatelessWidget {
//   var list=CourseModel.courseList.where((element) => (element.hour!<int.parse(DateFormat('H').format(DateTime.now())))).toList();
//
//   @override
//   Widget build(BuildContext context){
//     return Expanded(
//       child: Container(
//           child:ListView.builder(
//             shrinkWrap: true,
//             itemCount:list.length,
//             itemBuilder: (context,index){
//               return CourseTile(course: list[index]);
//
//
//
//
//             },
//           )
//       ),
//     );
//
//   }
// }