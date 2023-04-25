import 'package:appmovil/pages/ciudades.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class checkLista extends StatefulWidget {
  const checkLista({super.key});

  @override
  State<checkLista> createState() => _checkListaState();
}

class _checkListaState extends State<checkLista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Lista de Deseos",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: "Hecho");
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Ciudades()));
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
              "Ciudad-Pais",
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
              itemCount: 3,
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
                                  child: Image.network(
                                      "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg",
                                      fit: BoxFit.cover,
                                      width: 50),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Actividad",
                                        style: TextStyle(
                                            color: Colors.blue.shade800,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.blue.shade800,
                                            fontSize: 12),
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Fecha",
                                              style: TextStyle(
                                                  color: Colors.purple.shade800,
                                                  fontSize: 15),
                                            ),
                                            IconButton(
                                                alignment: Alignment.bottomLeft,
                                                onPressed: () {
                                                  QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType
                                                          .success,
                                                      text: "Eliminado");
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
