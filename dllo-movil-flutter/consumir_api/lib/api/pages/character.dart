import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../controller/Characters.dart';

class Personaje extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Character();
  }
}

class _Character extends State<Personaje> {
  dynamic personaje;

  Future<void> _personaje() async {
    const ts = '1';
    const apiKey = 'bd85ca0e2e42ccba38de40d9f2efa7ea';
    const hash = 'ac373c81c3b6380c033bc2fa423ac425';
    const id = '1010354';

    final List<dynamic> names = [];

    var response = await http.get(Uri.parse(
        'https://gateway.marvel.com:443/v1/public/characters?ts=$ts&apikey=$apiKey&hash=$hash&id=$id'));

    if (response.statusCode == 200) {
      setState(() {
        personaje = json.decode(response.body)['data']['results'][0];
      });
    } else {
      throw Exception('Failed to load character data');
    }
  }

  @override
  void initState() {
    super.initState();
    _personaje();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: personaje == null
          ? CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personaje['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Image.network(
                  '${personaje['thumbnail']['path']}.${personaje['thumbnail']['extension']}',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 10),
                Text(
                  personaje['description'],
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Cantidad de comics: ${personaje['comics']['available']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Cantidad de series: ${personaje['series']['available']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Cantidad de stories: ${personaje['stories']['available']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Cantidad de eventos: ${personaje['events']['available']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Primeras tres series:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                ...personaje['series']['items']
                    .take(3)
                    .map((e) => Text(e['name'], style: TextStyle(fontSize: 16)))
                    .toList(),
              ],
            ),
    );
  }
}
