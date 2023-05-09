import 'dart:io';

import 'package:excel/excel.dart';
import 'package:server/classes/base.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Student {
  Student(
      {required this.index,
      required this.fName,
      required this.lName,
      required this.stdNumber,
      required this.statusPresent,
      this.time,
      this.day,
      this.date,
      this.id});
  String index;
  String fName;
  String lName;
  String stdNumber;
  String statusPresent;
  String? time;
  String? day;
  String? date;
  String? id;
}

class Course {
  static final Course _course = Course._internal();

  factory Course() {
    return _course;
  }

  Course._internal();

  late String courseName;
  late String numberMeeting;
  late Function def;

  List<Student> studentsPresent = [], students = [];

  void readExcel() {
    Course().students = [];
    Course().studentsPresent = [];
    var file = "${Base().path}/Files/$courseName/$courseName.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    Sheet sheetObject = excel["booksheet $numberMeeting"];

    List<String> temp;
    for (var row in sheetObject.rows) {
      temp = row.map((e) => e!.value.toString()).toList();
      if (temp[4] == "1") {
        studentsPresent.insert(
            0,
            Student(
              index: temp[0],
              fName: temp[1],
              lName: temp[2],
              stdNumber: temp[3],
              statusPresent: temp[4],
              time: temp[5],
              day: temp[6],
              date: temp[7],
              id: temp[8],
            ));
      }
      students.add(Student(
          index: temp[0],
          fName: temp[1],
          lName: temp[2],
          stdNumber: temp[3],
          statusPresent: temp[4]));
    }
  }

  bool updateExcel(int row, String id) {
    var file = "${Base().path}/Files/$courseName/$courseName.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    Sheet sheetObject = excel["booksheet $numberMeeting"];
    def();
    try {
      DateTime now = DateTime.now();
      Jalali nowJalali = now.toJalali();
      // !!
      Course().students[row].statusPresent = '1';
      Course().students[row].time =
          '${nowJalali.hour}:${nowJalali.minute}:${nowJalali.second}';
      Course().students[row].day = nowJalali.day.toString();
      Course().students[row].date =
          "${nowJalali.year}/${nowJalali.month}/${nowJalali.day}";
      Course().students[row].id = id;
      Course().studentsPresent.insert(0, Course().students[row]);
      // !!
      sheetObject.updateCell(
          CellIndex.indexByColumnRow(rowIndex: row, columnIndex: 4), Course().students[row].statusPresent);
      sheetObject.updateCell(
          CellIndex.indexByColumnRow(rowIndex: row, columnIndex: 5),
          Course().students[row].time);
      sheetObject.updateCell(
          CellIndex.indexByColumnRow(rowIndex: row, columnIndex: 6),
          Course().students[row].day);
      sheetObject.updateCell(
          CellIndex.indexByColumnRow(rowIndex: row, columnIndex: 7),
          Course().students[row].date);
      sheetObject.updateCell(
          CellIndex.indexByColumnRow(rowIndex: row, columnIndex: 8), Course().students[row].id);
      var fileBytes = excel.save();
      File fileExcel = File(
          "${Base().path}/Files/${Course().courseName}/${Course().courseName}.xlsx");
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
}
