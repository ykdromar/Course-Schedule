import 'package:flutter/material.dart';

class Course {
  String? code;
  String? name;
  // String? image;
  String? time;
  String hour;
  String? venue;
  Course({this.code,this.name,this.time,required this.hour,this.venue});
  factory Course.fromMap(Map<String,dynamic>map){
    return Course(
      code: map["code"],
      name: map["name"],
      // image: map["image"],
        time:map["time"],
        hour: map["hour"],
        venue: map["venue"]

    );
  }
  toMap()=>{
    "code":code,
    "name":name,
    // "image":image,
    "time":time,
    "hour":hour,
    "venue":venue
  };

}

class CourseModel{
  static var courseList=<Course>[];
}