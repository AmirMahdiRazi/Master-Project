import 'dart:io';

import 'package:excel/excel.dart';

class Student {
  Student(
      {required this.index,
      required this.fName,
      required this.lName,
      required this.stdNumber});
  int index;
  String fName;
  String lName;
  String stdNumber;
}

class Students {
  List<Student> student = [];
  String error = '';

  bool check(String path) {
    if(File(path).existsSync()){
      return true;
    }else{return false;}

  }

  void read() {
    var file = "./excel_file.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxCols);
      print(excel.tables[table]!.maxRows);
      List temp = [];
      for (var row in excel.tables["booksheet1"]!.rows) {
        temp.add(row.map((e) => e!.value).toList());
        student.add(Student(
            index: temp[0],
            fName: temp[1],
            lName: temp[2],
            stdNumber: temp[3]));
      }
    }
  }
}
