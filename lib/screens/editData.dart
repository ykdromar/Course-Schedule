import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/utils/courseModel.dart';
import 'package:ykdromar_iitk_course_management/utils/routes.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';

import '../utils/databaseManager.dart';
import 'package:ykdromar_iitk_course_management/utils/databaseHelper.dart';
class EditData extends StatefulWidget{
  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
late String _day;
String? _daySelected;

late  String _code;

late  String _name;

late  String _venue;

late  String _time;

late  String  _hour;
String day=DateFormat('EEEE').format(DateTime.now());
databaseManager? database=databaseHelper.database;

String? _selectedTime;

// We don't need to pass a context to the _show() function
// You can safety use context as below
Future<void> _show() async {
  final TimeOfDay? result =
  await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (result != null) {

    setState(() {
      _selectedTime = result.format(context);
      _time=_selectedTime!;
      DateTime currTime=DateFormat.jm().parse("$_time");
      _hour=DateFormat("H").format(currTime);
    });
    // DateTime currTime=DateFormat.jm().parse("$result");
    // _hour=DateFormat("H").format(currTime);
  }
}

loadData() async {
  var db = database;
  if (db != null) {
    databaseHelper.futureCourseList = db.getCourses(day);

  }
  setState(() {

  });
}
final _formKey=GlobalKey<FormState>();
moveToHome(BuildContext context)async{
  if(_formKey.currentState!.validate()){


  }
}

@override
void initState(){
  super.initState();
  database=databaseManager();
  loadData();
}
var days=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
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

                      child: DropdownButton<String>(
                        value: _daySelected,
                        onChanged: (value){
                              _day=value!;
                          setState(() {
                            _daySelected=value;
                          });
                        },

                        items: days.map((e) => DropdownMenuItem(
                          value: e,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ))
                            .toList(),
                        hint: Center(child: Text("Select Day on which Course is to be added",style: TextStyle(color: Themes.darkBlue),),),
                      )
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
                      validator: (value){
                        if(value!=null&& value.isEmpty){
                          return "Please fill the Course Code";
                        }
                        return null;
                      },
                    ),

                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Name of Course",
                        hintText: "eg.INTRODUCTION TO ELECTRONICS",

                      ),
                      onChanged: (value){
                        _name=value;
                      },
                      validator: (value){
                        if(value!=null&& value.isEmpty){
                          return "Please fill the Course Name";
                        }
                        return null;
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
                      validator: (value){
                        if(value!=null&& value.isEmpty){
                          return "Please fill the Venue of Lecture";
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        _show();

                      },
                      child: Text(_selectedTime!=null? _selectedTime!: "Select Time"),
                  ),

                  ElevatedButton(

                      onPressed: (){
                        Course c=new Course(code: _code,name: _name,time: _time,hour: _hour,venue: _venue);
                        var db=database;
                        if(db!=null) {
                          db.insert(c,_day).then((value) {
                            print("DataAdded");
                            loadData();


                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        }
                        Navigator.pushNamed(context,routes.homeRoute );
                        // moveToHome(context);
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