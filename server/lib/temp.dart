import 'package:flutter/material.dart';

List<Widget> widgets = [
  const Icon(Icons.abc),
  const Icon(Icons.access_alarm),
  const Icon(Icons.access_time_filled_rounded)
];

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> with SingleTickerProviderStateMixin {
  late final TabController controller;
  int _index = 0;

  @override
  void initState() {
    controller = TabController(
      length: widgets.length,
      initialIndex: _index,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: controller,
            children: widgets,
          ),
          Positioned(
            bottom: 40,
            child: TabPageSelector(
              controller: controller,
              color: Colors.black38,
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton.small(
            onPressed: () {
              (_index != widgets.length - 1) ? _index++ : _index = 0;
              controller.animateTo(_index);
            },
            child: const Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
