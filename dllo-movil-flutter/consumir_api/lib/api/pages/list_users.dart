import 'package:consumir_api/api/controller/Characters.dart';
//import 'package:flutter/material.dart';

Datos() async {
  var characters = obtenerDatos();

    @override
  String toString() {
    return characters.toString();
  }

  return characters;
}

void main() {
  print(Datos());
}

/*
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
*/