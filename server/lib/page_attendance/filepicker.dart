import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class OpenFileAppHome extends StatelessWidget {
  const OpenFileAppHome({super.key});
  void _pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result == null) return;
    PlatformFile file = result.files.single;
    print(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _pickerFile,
        child: Text('Open File'),
      ),
    );
  }
}
