import 'dart:convert';

import 'package:http/http.dart' as http;

obtenerDatos() async {
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

class Names {
  late String name;

  Names.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
  }

  @override
  String toString() {
    return name.toString();
  }
}

class Imagen {
  late String urlImagen;

  Imagen.fromJson(Map<String, dynamic> json) {
    urlImagen = json["thumbnail"]["path"];
  }

  @override
  String toString() {
    return urlImagen.toString() + ".jpg";
  }
}
