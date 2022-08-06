import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';

import 'courseModel.dart';
import 'databaseManager.dart';
import 'databaseHelper.dart';
class CourseTile extends StatefulWidget{
  Course course;
  CourseTile ({required this.course});

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  String day=DateFormat('EEEE').format(DateTime.now());
  databaseManager? database=databaseHelper.database;
  loadData() async {
    var db = database;
    if (db != null) {
      databaseHelper.futureCourseList = db.getCourses(day);

    }
    setState(() {

    });

  }
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Course Deleted, Please Refresh'),
      ),
    );
  }
  _deleteData(BuildContext context){
    var db=database;
    if(db!=null&& widget.course.code!=null){
      db.delete(widget.course.code!, day);
    }
    // loadData();
    _showToast(context);
  }
  @override
  void initState(){
    super.initState();
    database=databaseManager();
    loadData();
  }
  @override
  Widget build(BuildContext context){
    return SlideInLeft(
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right:15,top: 10),
        child: Card(
          elevation: 2.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          shadowColor: Themes.darkBlue,
          child: Container(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SizedBox(
                      width:200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.course.code}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Themes.darkBlue,
                          ),
                          ),
                          Text("${widget.course.name}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          Text("Time : ${widget.course.time}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Themes.darkBlue,
                            ),
                          ),
                          Text("Venue : ${widget.course.venue}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Themes.darkBlue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
SizedBox(width: 30,),
                  InkWell(child: Icon(Icons.delete_outlined,color: Themes.darkBlue,size: 30,),
                    onTap: (){
                    _deleteData(context);
                    },
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