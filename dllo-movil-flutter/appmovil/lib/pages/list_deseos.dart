import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_database/firebase_database.dart';
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
  List<dynamic> listaDeseos = [];
  List<dynamic> listDeseo = [];

  dynamic listaDeseosKeys = [];
  List<dynamic> listDeseoKeys = [];

  Future<void> obtenerDeseos() async {
    //no esta funcionando el limite
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/listadeseos.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          listaDeseos = jsonData.values.toList();
          listaDeseosKeys = jsonData.keys.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          print(listaDeseosKeys);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  void borrar(index, fb) {
    final key = index;
    fb.ref().child('listadeseos/$key').remove().then((_) {
      print("Dato Borrado");
      setState(() {
        listaDeseos = [];
        listDeseo = [];
        listaDeseosKeys = [];
        listDeseoKeys = [];
        obtenerDeseos();
      });
    }).catchError((error) {
      print("Error al borrar el dato: $error");
    });
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

    for (int i = 0; i < listaDeseos.length; i++) {
      if (listaDeseos[i]['email'] == emailUser) {
        setState(() {
          listDeseo.add(listaDeseos[i]);
          listDeseoKeys.add(listaDeseosKeys[i]);
        });
      }
    }

    //print(emailUser);

    final fb = FirebaseDatabase.instance;

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
          child: listDeseo.isEmpty
              ? CircularProgressIndicator()
              : ListWheelScrollView.useDelegate(
                  physics: FixedExtentScrollPhysics(),
                  itemExtent: 400,
                  diameterRatio: 6,
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: listDeseo.length,
                      builder: (context, index) {
                        final image = listDeseo[index]['imagen'];
                        final name = listDeseo[index]['name'];
                        final fecha = listDeseo[index]['fecha'];
                        final pais = listDeseo[index]['pais'];
                        final ciudad = listDeseo[index]['ciudad'];
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$ciudad ($pais)",
                                    style: TextStyle(
                                        color: Colors.blue.shade800,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Text(name,
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          fecha,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () async {
                                              final key = listDeseoKeys[index];
                                              ArtDialogResponse response =
                                                  await ArtSweetAlert.show(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      artDialogArgs: ArtDialogArgs(
                                                          denyButtonText:
                                                              "Cancelar",
                                                          title:
                                                              "Estas Seguro?",
                                                          text:
                                                              "Piensalo Dos Veces!",
                                                          confirmButtonText:
                                                              "Si, Borralo",
                                                          type:
                                                              ArtSweetAlertType
                                                                  .warning));

                                              if (response == null) {
                                                return;
                                              }

                                              if (response.isTapConfirmButton) {
                                                ArtSweetAlert.show(
                                                    context: context,
                                                    artDialogArgs: ArtDialogArgs(
                                                        type: ArtSweetAlertType
                                                            .success,
                                                        title: "Borrado!"));
                                                return borrar(key, fb);
                                              }
                                            },
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
                      }),
                ),
        ));
  }
}
