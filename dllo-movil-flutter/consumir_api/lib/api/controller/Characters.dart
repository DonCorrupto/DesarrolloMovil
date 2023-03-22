import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<dynamic, dynamic>> obtenerDatos() async {
  var personajes = {};

  var response = await http.get(Uri.parse(
      'https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=bd85ca0e2e42ccba38de40d9f2efa7ea&hash=ac373c81c3b6380c033bc2fa423ac425'));
  final marvel = jsonDecode(response.body)["data"]["results"];

  for (var element in marvel) {
    var character = Personaje.fromJson(element);
    var image = Imagen.fromJson(element);
    personajes[character] = image;
  }

  return personajes;
}

class Personaje {
  late String name;

  Personaje.fromJson(Map<String, dynamic> json) {
    name = json["name"];
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

/*
void main() async {
  var characters = await obtenerDatos();
  print(characters);
}
*/
