import 'courseModel.dart';
import 'databaseManager.dart';

class databaseHelper {
  static databaseManager? database;
  static Future<List<Course>>? futureCourseList;
  var db = database;
  static loadData() async {
    var db = database;
    if (db != null) {
      databaseHelper.futureCourseList = db.getCourses();

    }
  }


}