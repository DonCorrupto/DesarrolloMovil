import 'package:consumir_api/api/controller/Characters.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> obtenerDatos() async {
  List<List<dynamic>> personajes = [];
  final List<dynamic> names_imagenes = [];

  var response = await http.get(Uri.parse(
      'https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=bd85ca0e2e42ccba38de40d9f2efa7ea&hash=ac373c81c3b6380c033bc2fa423ac425'));
  final marvel = jsonDecode(response.body)["data"]["results"];

  for (var element in marvel) {
    names_imagenes.add(Names.fromJson(element));
    names_imagenes.add(Imagen.fromJson(element));
  }

  for (int i = 0; i < names_imagenes.length; i += 2) {
    if (i + 1 < names_imagenes.length) {
      personajes.add([names_imagenes[i], names_imagenes[i + 1]]);
    } else {
      personajes.add([names_imagenes[i]]);
    }
  }

  //print(personajes);
  return personajes;
}

class CharactersMarvel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CharactersMarvel();
  }
}

class _CharactersMarvel extends State<CharactersMarvel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: obtenerDatos(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
                child: ListView.separated(
              itemCount: snapshot.data.toString().length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(snapshot.data[index][1].toString(),),
                title: Text(snapshot.data[index][0].toString()),
              ),
            ));
          }
        },
      ),
    );
  }
}
