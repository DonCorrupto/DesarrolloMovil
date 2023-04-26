import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class listItinerario extends StatefulWidget {
  const listItinerario({super.key});

  @override
  State<listItinerario> createState() => _listItinerarioState();
}

class _listItinerarioState extends State<listItinerario> {

  List<dynamic> image = [
    "https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg",
    "https://i.pinimg.com/564x/d3/43/bd/d343bd41d7c4461f79a554f6db577f29.jpg",
    "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg"
  ];
  
  @override
  Widget build(BuildContext context) {
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
        body: ListWheelScrollView.useDelegate(
          physics: FixedExtentScrollPhysics(),
          itemExtent: 250,
          diameterRatio: 6,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: image.length,
            builder: (context, index) {
              return Container(
                height: 400,
                margin: EdgeInsets.only(bottom: 15, top: 10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(image[index]),
                      fit: BoxFit.cover,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text("Actividad",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                primary: Colors.white, shape: StadiumBorder()),
                            icon: Icon(
                              CupertinoIcons.bin_xmark,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}