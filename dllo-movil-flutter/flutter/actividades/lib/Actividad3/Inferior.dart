import 'package:actividades/Actividad3/Cuadrito.dart';
import 'package:flutter/material.dart';

class Inferior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration:
      //    BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Cuadrito(),
          Cuadrito(),
          Cuadrito(),
          Cuadrito(),
          Cuadrito(),
          Cuadrito(),
        ],
      ),
    );
  }
}
