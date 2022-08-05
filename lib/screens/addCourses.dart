import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ykdromar_iitk_course_management/utils/courseModel.dart';
import 'package:ykdromar_iitk_course_management/utils/routes.dart';
import 'package:ykdromar_iitk_course_management/utils/theme.dart';

import '../utils/databaseManager.dart';
import 'package:ykdromar_iitk_course_management/utils/databaseHelper.dart';
class AddCourse extends StatefulWidget{
  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
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
  void _processData() {
    // Process your data and upload to server
    if(_formKey.currentState!.validate()){
      _formKey.currentState?.reset();
      _daySelected=null;
      setState(() {

      });
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
    return Scaffold(
      resizeToAvoidBottomInset:true ,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0) , // here the desired height
        child: AppBar(
          title: Center(child: Text("Add Course",style: TextStyle(color: Themes.darkBlue, fontSize: 23,fontWeight: FontWeight.w900), )),
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(80))),
        ),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(

          child: Form(
            key: _formKey,

              child:Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _daySelected,
                    onChanged: (value){
                      _day=value!;
                      setState(() {
                        _daySelected=value;
                      });
                    },
                    validator: (value){
                      if(value!=null&& value.isEmpty){
                        return "Please Select the Day";
                      }
                      return null;
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
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
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
                  SizedBox(height: 10,),
                  TextFormField(
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
                  SizedBox(height: 10,),
                  TextFormField(
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
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 300,

                    child: ElevatedButton.icon(
                      icon: Icon(Icons.access_time,color: Themes.darkBlue,),
                      onPressed: (){
                        _show();
                        },
                      label: Text(_selectedTime!=null? _selectedTime!: "Select Time", style: TextStyle(color: Themes.darkBlue),),


                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add),

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
                          _processData();
                        },


                        label: Text("Add")
                    ),
                  )
                ],
              ),

          ),
        ),
      ),
    );
  }
}