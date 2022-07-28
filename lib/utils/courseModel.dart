import 'package:flutter/material.dart';

class Course {
  String? code;
  String? name;
  String? image;
  String? time;
  int? hour;
  String? lh;
  Course({this.code,this.name,this.image,this.time,this.hour,this.lh});
  factory Course.fromMap(Map<String,dynamic>map){
    return Course(
      code: map["code"],
      name: map["name"],
      image: map["image"],
        time:map["time"],
        hour: map["hour"],
        lh:map["lh"]

    );
  }
  toMap()=>{
    "code":code,
    "name":name,
    "image":image,
    "time":time,
    "hour":hour,
    "lh":lh
  };

}

class CourseModel{
  static var courseList=<Course>[];
}