import 'dart:io';

import 'package:excel/excel.dart';
import 'package:server/classes/base.dart';

class Student {
  Student({
    required this.index,
    required this.fName,
    required this.lName,
    required this.stdNumber,
    required this.statusPresent,
  });
  String index;
  String fName;
  String lName;
  String stdNumber;
  String statusPresent;
}

class Course {
  static final Course _course = Course._internal();

  factory Course() {
    return _course;
  }

  Course._internal();

  late String courseName;
  late String numberMeeting;
  late Stream<List<Student>> def;

  List<Student> studentsPresent = [], students = [];

  void readExcel() {
    var file = "${Base().path}/Datas/$courseName/$courseName.xlsx";

    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    Sheet sheetObject = excel["booksheet $numberMeeting"];
    List<String> temp;
    for (var row in sheetObject.rows) {
      temp = row.map((e) => e!.value.toString()).toList();

      students.add(Student(
          index: temp[0],
          fName: temp[1],
          lName: temp[2],
          stdNumber: temp[3],
          statusPresent: temp[4]));
    }
  }

  bool updateExcel(int row) {
    var file = "${Base().path}/Datas/$courseName/$courseName.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    Sheet sheetObject = excel["booksheet $numberMeeting"];
    def;
    try {
      sheetObject.updateCell(
          CellIndex.indexByColumnRow(rowIndex: row, columnIndex: 4), '1');
      var fileBytes = excel.save();
      File fileExcel = File(
          "${Base().path}/Datas/${Course().courseName}/${Course().courseName}.xlsx");
      if (fileExcel.existsSync()) {
        fileExcel.writeAsBytesSync(fileBytes!);
      } else {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  late String path;

  // Stream<List<Student>> get getPresentStudent async* {
  //   def();
  //   yield studentsPresent;
  // }
}
