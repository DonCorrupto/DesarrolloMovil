import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class listItinerario extends StatefulWidget {
  const listItinerario(
      {super.key, required this.cit, required this.pa, required this.email});

  final dynamic cit;
  final dynamic email;
  final dynamic pa;

  @override
  State<listItinerario> createState() => _listItinerarioState();
}

class _listItinerarioState extends State<listItinerario> {

  List<dynamic> listaActividades = [];
  List<dynamic> listActivity = [];

  Future<void> obtenerListaActividades() async {
    //no esta funcionando el limite
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/listaactividades.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          listaActividades = jsonData.values.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          //print(listaActividades);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerListaActividades();
  }

  @override
  Widget build(BuildContext context) {
    final emailUser = widget.email;
    final city = widget.cit;
    final pais = widget.pa;

    print(widget.cit);
    print(widget.email);
    print(widget.pa);

    for (var actividadUser in listaActividades) {
      if (actividadUser['email'] == emailUser &&
          city == actividadUser['ciudad'] &&
          pais == actividadUser['pais']) {
        setState(() {
          listActivity.add(actividadUser);
        });
      }
    }

    print(listActivity);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Lista de Itinerario",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$city ($pais)",
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                physics: FixedExtentScrollPhysics(),
                itemExtent: 250,
                diameterRatio: 6,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: listActivity.length,
                  builder: (context, index) {
                    return Container(
                      height: 400,
                      margin: EdgeInsets.only(bottom: 15, top: 10),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(listActivity[index]['imagen']),
                            fit: BoxFit.cover,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(listActivity[index]['name'],
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      shape: StadiumBorder()),
                                  icon: Icon(
                                    CupertinoIcons.bin_xmark_fill,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
