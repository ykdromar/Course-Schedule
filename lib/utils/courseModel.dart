import 'package:flutter/material.dart';

class Course {
  String? code;
  String? name;
  String? image;
  String? time;
  int? hour;
  Course({this.code,this.name,this.image,this.time,this.hour});
  factory Course.fromMap(Map<String,dynamic>map){
    return Course(
      code: map["code"],
      name: map["name"],
      image: map["image"],
        time:map["time"],
        hour: map["hour"]

    );
  }
  toMap()=>{
    "code":code,
    "name":name,
    "image":image,
    "time":time,
    "hour":hour
  };

}

class CourseModel{
  static var courseList=<Course>[];
}