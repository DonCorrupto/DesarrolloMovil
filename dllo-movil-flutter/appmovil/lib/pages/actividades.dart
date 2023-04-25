import 'dart:ui';

import 'package:appmovil/pages/check_lista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class Actividades extends StatefulWidget {
  final int estado;
  Actividades({required this.estado});

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

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "Actividad",
      "Actividad",
      "Actividad",
    ];

    final List<Widget> images = [
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          "https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg",
          fit: BoxFit.cover,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          "https://i.pinimg.com/564x/d3/43/bd/d343bd41d7c4461f79a554f6db577f29.jpg",
          fit: BoxFit.cover,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg",
          fit: BoxFit.cover,
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: widget.estado == 0
            ? Text(
                "Lista de Deseos",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              )
            : Text(
                "Check In",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
        actions: [
          IconButton(
            onPressed: widget.estado == 0
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => checkLista()));
                  }
                : () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => checkLista()));
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
                      // optional
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
