class Client {
  String code = '';
  String ipServer = '';
  int port = 0;
  String stdNumber = '';
  // ignore: non_constant_identifier_names
  String? ID;

  Map<String, String>? result;

  List<String> logs = [];

  // ignore: non_constant_identifier_names
  String combine_data() => '$ID-$code-$stdNumber';
}
