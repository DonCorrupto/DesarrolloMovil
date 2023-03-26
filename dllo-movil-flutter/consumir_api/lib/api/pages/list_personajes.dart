import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ListaPersonajes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListaPersonajes();
  }
}

class _ListaPersonajes extends State<ListaPersonajes> {
  List<dynamic> personaje = [];

  Future<void> obtenerPersonaje() async {
    //no esta funcionando el limite
    const url =
        'https://gateway.marvel.com:443/v1/public/characters?ts=2000&apikey=bd85ca0e2e42ccba38de40d9f2efa7ea&hash=d16b26d4add5cf2eb2745c1bca283dbd&limit=40&offset=180';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        personaje = jsonData['data']['results'];
      });
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerPersonaje();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: personaje.isEmpty
                ? CircularProgressIndicator()
                : MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          final name = personaje[index]['name'];
                          final image = personaje[index]['thumbnail']['path'] +
                              '.' +
                              personaje[index]['thumbnail']['extension'];
                          final description = personaje[index]['description'];
                          final comics =
                              personaje[index]['comics']['available'];
                          final series =
                              personaje[index]['series']['available'];
                          final stories =
                              personaje[index]['stories']['available'];
                          final events =
                              personaje[index]['events']['available'];
                          late dynamic tres_primeras_series = personaje[index]
                                  ['series']['items']
                              .take(3)
                              .map((e) => e['name'])
                              .toString();
                          return Card(
                            color: Colors.black,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Image.network(
                                    image,
                                  ),
                                  tooltip: name,
                                  iconSize: 120,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                              title: Text(name,
                                                  textAlign: TextAlign.center),
                                              children: [
                                                Image.network(
                                                  image,
                                                ),
                                                SimpleDialogOption(
                                                  child: Text(description),
                                                ),
                                                SimpleDialogOption(
                                                  child: Text(
                                                      "Cantidad de Comics: $comics"),
                                                ),
                                                SimpleDialogOption(
                                                  child: Text(
                                                      "Cantidad de Series: $series"),
                                                ),
                                                SimpleDialogOption(
                                                  child: Text(
                                                      "Cantidad de Stories: $stories"),
                                                ),
                                                SimpleDialogOption(
                                                  child: Text(
                                                      "Cantidad de Events: $events"),
                                                ),
                                                SimpleDialogOption(
                                                  child: Text(
                                                      "Nombre de las 3 primeras series: $tres_primeras_series"),
                                                ),
                                              ],
                                            ));
                                  },
                                ),
                                Text(""),
                                Text(
                                  name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          );
                        }),
                  )));
  }
}
