import 'package:flutter/material.dart';

class AutoComplete extends StatefulWidget {
  AutoComplete({Key? key, required this.files}) : super(key: key);
  List<String> files;
  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  final contorller = TextEditingController();
  late List<String> items;
  @override
  void initState() {
    items = widget.files;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: contorller,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue))),
          onChanged: searchFile,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return itemCart(
                item,
                contorller,
              );
            },
          ),
        ),
      ],
    );
  }

  void searchFile(String query) {
    final suggestions = widget.files.where((item) {
      final itemName = item.toLowerCase();
      final input = query.toLowerCase();
      return itemName.contains(input);
    }).toList();
    setState(() => items = suggestions);
  }

  Widget itemCart(String name, TextEditingController controller) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          controller.text = name;
        },
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontFamily: 'bnazanin',
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
