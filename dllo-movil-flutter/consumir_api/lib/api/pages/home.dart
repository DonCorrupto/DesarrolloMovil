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
      "https://i.pinimg.com/564x/60/4c/dd/604cdd9a0981eefbd80e179cd2a1b4e0.jpg";
  bool? isActive = false;
  void onChanged1(bool? value) {
    setState(() {
      isActive = value;
      clave = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black, child: url == null ? CircularProgressIndicator(): Image.network(url), width: 1080, height: 2400,);
  }
}
