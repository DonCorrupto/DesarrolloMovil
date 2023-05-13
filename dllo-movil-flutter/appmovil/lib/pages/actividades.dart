import 'package:appmovil/pages/check_lista.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class Actividades extends StatefulWidget {
  Actividades(
      {required this.estado,
      required this.actividades,
      required this.id,
      required this.ciudad,
      required this.pais});

  final int estado;
  final dynamic actividades;
  final int id;
  final String ciudad;
  final String pais;

  final List<dynamic> selectActividad = [];

  @override
  State<StatefulWidget> createState() {
    return _Actividades();
  }
}

class _Actividades extends State<Actividades> {
  List<dynamic> image = [
    "https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg",
    "https://i.pinimg.com/564x/d3/43/bd/d343bd41d7c4461f79a554f6db577f29.jpg",
    "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg"
  ];

  TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [];

    widget.actividades.forEach((dynamic element) {
      titles.add(element['name']);
    });

    final List<Widget> images = [];

    widget.actividades.forEach((dynamic element) {
      images.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            element['imagen'],
            fit: BoxFit.cover,
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: widget.estado == 0
            ? Text(
                "Agrega las Actividades a tu Lista de Deseos",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 13),
              )
            : Text(
                "Agrega las Actividades a tu Itinerario",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
        actions: [
          IconButton(
            onPressed: widget.estado == 0
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Seleccione una fecha"),
                          content: TextField(
                            controller: _date,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today_rounded),
                                labelText: "Ingrese la Fecha"),
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickeddate != null) {
                                setState(() {
                                  _date.text = DateFormat('yyyy-MM-dd')
                                      .format(pickeddate);
                                });
                              }
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Actividades(
                                            estado: 0,
                                            actividades: null,
                                            id: widget.id,
                                            ciudad: "",
                                            pais: "",
                                          ))),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => checkLista(
                                            estado: 0,
                                            selectActividad:
                                                widget.selectActividad,
                                            fecha: _date.text,
                                            id: widget.id,
                                            ciudad: widget.ciudad,
                                            pais: widget.pais,
                                          ))),
                              child: const Text('OK'),
                            )
                          ],
                        );
                      },
                    );
                  }
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => checkLista(
                                  estado: 1,
                                  selectActividad: widget.selectActividad,
                                  fecha: _date.text,
                                  id: widget.id,
                                  ciudad: widget.ciudad,
                                  pais: widget.pais,
                                )));
                  },
            icon: widget.estado == 0
                ? Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.library_add,
                    color: Colors.black,
                  ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: VerticalCardPager(
                    titles: titles, // required
                    images: images, // required
                    textStyle: TextStyle(
                        fontFamily: "Bevan",
                        color: Colors.white,
                        fontWeight: FontWeight.bold), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      setState(() {
                        widget.selectActividad.add(widget.actividades[index]);
                        bool isRepeated = widget.selectActividad
                                .map((e) => e['name'])
                                .toSet()
                                .length !=
                            widget.selectActividad.length;
                        if (isRepeated) {
                          widget.selectActividad.removeLast();
                          showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(
                                Duration(seconds: 2),
                                () {
                                  Navigator.of(context).pop(true);
                                },
                              );
                              return AlertDialog(
                                title: Container(
                                  child: Center(
                                      child: Text(
                                          "Esta Actividad ya esta seleccionada")),
                                ),
                              );
                            },
                          );
                        }
                        //print(isRepeated);
                        //print(widget.selectActividad);
                      });
                      //print(widget.selectActividad);
                    },
                    initialPage: 0, // optional
                    align: ALIGN.CENTER // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
