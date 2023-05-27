import 'dart:math';

import 'package:appmovil/pages/main_app.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../models/user.dart';

class checkLista extends StatefulWidget {
  checkLista(
      {required this.estado,
      required this.selectActividad,
      required this.fecha,
      required this.id,
      required this.ciudad,
      required this.pais});

  final int estado;
  final dynamic selectActividad;
  final dynamic fecha;
  final int id;
  final String ciudad;
  final String pais;

  @override
  State<checkLista> createState() => _checkListaState();
}

class _checkListaState extends State<checkLista> {
  final fb = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<userData>(context);
    dynamic user = Data.userDatos;

    final city = widget.ciudad;
    final pais = widget.pais;
    print(widget.selectActividad);

    final Actividades = widget.selectActividad;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: widget.estado == 0
            ? Text(
                "Verifica tu lista de Deseos",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15),
              )
            : Text(
                "Verifica tu Itinerario",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
        actions: [
          IconButton(
            onPressed: widget.estado == 0
                ? () {
                    //print(user);
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: "Felicidades!",
                            text: "Acabaste de agregar las actividades a tu lista de deseos"));
                    for (var activity in Actividades) {
                      var rng = Random();
                      var k = rng.nextInt(10000);

                      final refDeseos = fb.ref().child('listadeseos/$k');
                      refDeseos.set({
                        "email": user['email'],
                        "imagen": activity['imagen'],
                        "name": activity['name'],
                        "fecha": widget.fecha,
                        "pais": pais,
                        "ciudad": city
                      });
                    }

                    Future.delayed(
                      Duration(seconds: 2),
                      () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MainAppViaje()),
                            (Route<dynamic> route) => false);
                      },
                    );
                  }
                : () {
                    //SE AGREGA AL ITINERARIO Y SE MUESTRA EN EL PERFIL
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: "Felicidades!",
                            text: "Acabaste de agregar las actividades a tu lista de itinerario"));
                    for (var activity in Actividades) {
                      var rng = Random();
                      var k = rng.nextInt(10000);

                      final refDeseos = fb.ref().child('listaactividades/$k');
                      refDeseos.set({
                        "email": user['email'],
                        "imagen": activity['imagen'],
                        "name": activity['name'],
                        "pais": pais,
                        "ciudad": city
                      });
                    }
                    Future.delayed(
                      Duration(seconds: 2),
                      () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MainAppViaje()),
                            (Route<dynamic> route) => false);
                      },
                    );
                  },
            icon: Icon(
              Icons.done,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "$city ($pais)",
              style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Center(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: widget.selectActividad.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                        height: 120.0,
                        child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            elevation: 6,
                            shadowColor: Colors.black54,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          widget.selectActividad[index]
                                              ['imagen'],
                                          fit: BoxFit.cover,
                                          width: 50),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: widget.estado == 0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.selectActividad[index]
                                                  ['name'],
                                              style: TextStyle(
                                                  color: Colors.blue.shade800,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    widget.fecha,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .purple.shade800,
                                                        fontSize: 15),
                                                  ),
                                                  IconButton(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      onPressed: () {
                                                        QuickAlert.show(
                                                            context: context,
                                                            type: QuickAlertType
                                                                .success,
                                                            text: "Eliminado");
                                                        Future.delayed(
                                                          Duration(seconds: 1),
                                                          () {
                                                            setState(() {
                                                              widget
                                                                  .selectActividad
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.clear_rounded,
                                                        color: Colors.red,
                                                      ))
                                                ]),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.selectActividad[index]
                                                  ['name'],
                                              style: TextStyle(
                                                  color: Colors.blue.shade800,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        QuickAlert.show(
                                                            context: context,
                                                            type: QuickAlertType
                                                                .success,
                                                            text: "Eliminado");
                                                        Future.delayed(
                                                          Duration(seconds: 1),
                                                          () {
                                                            setState(() {
                                                              widget
                                                                  .selectActividad
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.clear_rounded,
                                                        color: Colors.red,
                                                      ))
                                                ]),
                                          ],
                                        ),
                                )
                              ],
                            ))),
                  ],
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
