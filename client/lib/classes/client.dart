class Client {
  String code = '';
  String ipServer = '';
  int port = 0;
  String stdNumber = '';
  // ignore: non_constant_identifier_names
  String? id;

  Map<String, String>? result;

  // ignore: non_constant_identifier_names
  String combineData() => '$id-$code-$stdNumber';
}
