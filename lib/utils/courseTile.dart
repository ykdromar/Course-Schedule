import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';

import 'courseModel.dart';

class CourseTile extends StatelessWidget{
  Course course;
  CourseTile ({required this.course});
  @override
  Widget build(BuildContext context){
    return RollIn(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 1.2,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
shadowColor: Themes.darkBlue,
          
          child: Container(
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       // begin: FractionalOffset.topLeft,
              //       // end: FractionalOffset.bottomRight,
              //       colors: [
              //         Colors.white,
              //         // Colors.tealAccent,
              //         Colors.teal
              //       ],
              //
              //
              //     )
              // ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(child: Image.asset("${course.image}"),
                  height:50,
                    width:65,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${course.code}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Themes.darkBlue,
                        ),
                        ),
                        Text("${course.name}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text("Time : ${course.time}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Themes.darkBlue,
                          ),
                        ),
                        Text("Lecture Hall : ${course.lh}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Themes.darkBlue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )


          ),
        ),
      ),
    );
  }
}