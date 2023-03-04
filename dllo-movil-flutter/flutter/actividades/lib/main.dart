import 'package:flutter/material.dart';

import 'Actividad3/Inferior.dart';
import 'Actividad3/Superior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Container(
              color: Colors.green.shade900,
              child: Column(
                children: [
                  Superior(
                      "https://cdn.pixabay.com/photo/2021/08/11/20/48/bird-6539424_640.png"),
                  Inferior()],
              ))),
    );
  }
}
