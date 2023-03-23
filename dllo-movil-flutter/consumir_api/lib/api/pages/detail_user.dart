import 'package:flutter/material.dart';
import '../controller/Characters.dart';

class DetailUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailUser();
  }
}

class _DetailUser extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    //User args = ModalRoute.of(context)?.settings.arguments as User;

    //String user_name = args.name;
    return Container(
      child: Center(
        //child: Text(user_name),
      ),
    );
  }
}