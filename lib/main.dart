import 'package:flutter/material.dart';
import 'package:labeled_divider_example/widgets/labeled_divider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Widget with a custom RenderObject'),
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: const LabeledDivider(
                  label: 'Divider Label',
                  thickness: 8.0,
                  color: Colors.red,
                ),
              )
            ],
          )),
    );
  }
}
