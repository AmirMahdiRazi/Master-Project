import 'dart:io';

class Base {
  static final Base _base = Base._internal();

  factory Base() {
    return _base;
  }

  Base._internal();
  String path = '';
  bool page = true;
  late List<String> data;

  void readData(String destination) {
    List<String> temp = File('$path/Files/$destination').readAsLinesSync();
    data = List.from(temp.reversed);
  }
}
