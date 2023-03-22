import 'package:consumir_api/api/controller/Characters.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

namesDatos() async {
  var characters = await obtenerDatos();

  List<dynamic> names = [];

  for (var entry in characters.entries) {
    names.add(entry.key);
  }

  return names;
}

imagesDatos() async {
  var characters = await obtenerDatos();

  List<dynamic> images = [];

  for (var entry in characters.entries) {
    images.add(entry.key);
  }

  return images;
}

class CharactersMarvel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CharactersMarvel();
  }
}

class _CharactersMarvel extends State<CharactersMarvel> {
  final _name = namesDatos();
  final _image = imagesDatos();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namesDatos();
    imagesDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_name),
    );
  }
}
