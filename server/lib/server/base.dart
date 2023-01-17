import 'package:server/server/server.dart';
import 'package:server/server/student.dart';

class Base {
  static final Base _base = Base._internal();

  factory Base() {
    return _base;
  }

  Base._internal();

  Server server = Server();
  Students students = Students();
}
