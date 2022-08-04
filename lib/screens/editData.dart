import 'package:flutter/material.dart';
import 'package:ykdromar_iitk_course_management/utils/courseModel.dart';
import 'package:ykdromar_iitk_course_management/utils/routes.dart';

import '../utils/databaseManager.dart';
import 'package:ykdromar_iitk_course_management/utils/databaseHelper.dart';
class EditData extends StatefulWidget{
  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
late  String _day;

late  String _code;

late  String _name;

late  String _venue;

late  String _time;

late  String  _hour;

databaseManager? database=databaseHelper.database;
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
    return SafeArea(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  Form(

                      child: TextFormField(
                        decoration:InputDecoration(
                          labelText:"Day on which Course is to be added",
                          hintText: "eg. Monday",

                        ),
                        onChanged:(value){
                          _day=value;
                        },
                      ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Course Code",
                        hintText: "eg. ESC201A",

                      ),
                      onChanged:(value){
                        _code=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Name of Course",
                        hintText: "eg.INTRODUCTION TO ELECTRONICS",

                      ),
                      // onChanged:(value){
                      //   _name=value;
                      // },
                      onChanged: (value){
                        _name=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Venue",
                        hintText: "eg. L-20",

                      ),
                      onChanged:(value){
                        _venue=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Time",
                        hintText: "eg. 8:00 AM - 9:00 AM",

                      ),
                      onChanged:(value){
                        _time=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Hour (In 24 hour format",
                        hintText: "eg. for 1:00 PM it should be 13",

                      ),
                      onChanged:(value){
                        _hour=value;
                      },
                    ),
                  ),
                  ElevatedButton(

                      onPressed: (){
                        Course c=new Course(code: _code,name: _name,time: _time,hour: _hour,venue: _venue);
                        var db=database;
                        if(db!=null) {
                          db.insert(c).then((value) {
                            print("DataAdded");
                            loadData();


                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        }
                        Navigator.pushNamed(context,routes.homeRoute );
                      },

                      child: Text("Save")
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}