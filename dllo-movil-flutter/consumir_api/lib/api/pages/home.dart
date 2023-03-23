import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  String clave = "";
  late String url =
      "https://i.pinimg.com/736x/3f/36/c1/3f36c1314414dd1f4d86a65ceaf6e875.jpg";
  bool? isActive = false;
  void onChanged1(bool? value) {
    setState(() {
      isActive = value;
      clave = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(url));
  }
}
