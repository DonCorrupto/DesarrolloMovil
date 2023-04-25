import 'package:appmovil/pages/actividades.dart';
import 'package:appmovil/pages/crear_cuenta.dart';
import 'package:appmovil/pages/home.dart';
import 'package:appmovil/pages/ciudades.dart';
import 'package:appmovil/pages/check_lista.dart';
import 'package:appmovil/pages/login.dart';
import 'package:appmovil/pages/perfil.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home(),
      //  Scaffold(
      //     appBar: AppBar(
      //       title: const Text("To Do"),
      //       titleSpacing: 100,
      //     ),
      //     body:ButtonBase(),

      //  )
    );
  }
}
