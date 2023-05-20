import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';

class listDeseos extends StatefulWidget {
  const listDeseos({super.key});

  @override
  State<listDeseos> createState() => _listDeseosState();
}

class _listDeseosState extends State<listDeseos> {
  List<dynamic> deseos = [];

  Future<void> obtenerDeseos() async {
    //no esta funcionando el limite
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/listadeseos.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          deseos = jsonData.values.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          print(deseos);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerDeseos();
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<userData>(context);
    dynamic user = Data.userDatos;

    String emailUser = user['email'];

    print(emailUser);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Lista de Futuros Viajes",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: deseos.isEmpty
              ? CircularProgressIndicator()
              : ListWheelScrollView.useDelegate(
                  physics: FixedExtentScrollPhysics(),
                  itemExtent: 400,
                  diameterRatio: 6,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: deseos.length,
                    builder: (context, index) {
                      final idCiity = deseos[index]['idCiudad'];
                      final email = deseos[index]['email'];
                      final image = deseos[index]['imagen'];
                      final name = deseos[index]['name'];
                      final fecha = deseos[index]['fecha'];
                      final pais = deseos[index]['pais'];
                      final ciudad = deseos[index]['ciudad'];
                      for (var listaDeseo in deseos) {
                        if (email == emailUser) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 130,
                                    ),
                                    Text(
                                      "$ciudad ($pais)",
                                      style: TextStyle(
                                          color: Colors.blue.shade800,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add_box_outlined,
                                          color: Colors.green,
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 400,
                                  margin: EdgeInsets.only(bottom: 15, top: 10),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover,
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Text(name,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  shape: StadiumBorder()),
                                              icon: Icon(
                                                CupertinoIcons.bin_xmark,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ),
        ));
  }
}
