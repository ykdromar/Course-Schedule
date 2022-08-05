
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import 'courseModel.dart';
class databaseManager{

   Database? _database;

  Future<Database?> get getDatabase async{
    if(_database!=null){
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }
  initDatabase()async{
    io.Directory documentDirectory =await getApplicationSupportDirectory();
    String path= join(documentDirectory.path,'coursesDatabase.db');
    WidgetsFlutterBinding.ensureInitialized();
    var database=await openDatabase(path, version:1,onCreate:_onCreate );
    return database;
  }
  _onCreate(Database database,int version )async{
    await database.execute(
      "CREATE TABLE Monday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Tuesday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Wednesday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Thursday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Friday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Saturday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
    await database.execute(
        "CREATE TABLE Sunday (id INTEGER PRIMARY KEY AUTOINCREMENT,code TEXT NOT NULL,name TEXT NOT NULL,time TEXT NOT NULL,hour TEXT NOT NULL,venue TEXT NOT NULL)"
    );
  }
  Future<Course> insert(Course course,String day) async{
    var dbClient= await getDatabase;
    if(dbClient!=null){
      await dbClient.insert('$day',course.toMap());
    }
    return course;
  }

  Future<List<Course>> getCourses(String day)async {
    Database? dbClient = await getDatabase;
    final List<Map<String, Object?>> queryResult;
    if (dbClient != null) {
      queryResult = await dbClient.query('$day');
      }
    else{
        print("NULL Database");
        queryResult=[];
      }

      return queryResult.map((e) => Course.fromMap(e)).toList();

  }

}