import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'dart:math';

Random random = new Random();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final password = RandomPasswordGenerator();
  bool Mayuscula = false;
  bool Minuscula = false;
  bool Numeros = false;
  bool Caracteres = false;
  String newPassword = "";
  double randomNumber = random.nextInt(20) + 10;

  void generate() {
    setState(() {
      newPassword = password.randomPassword(
          letters: Minuscula,
          numbers: Numeros,
          passwordLength: randomNumber,
          specialChar: Caracteres,
          uppercase: Mayuscula);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CheckboxListTile(
                  value: Mayuscula,
                  onChanged: (bool ? value) {
                    setState(() {
                      if (value == true) {
                        Mayuscula = true;
                      }
                      else {
                        Mayuscula = false;
                      }
                    });
                  },
                  title: const Text("Mayusculas")),
              CheckboxListTile(
                  value: Minuscula,
                  onChanged: (bool ? value) {
                    setState(() {
                      if (value == true) {
                        Minuscula = true;
                      }
                      else {
                        Minuscula = false;
                      }
                    });
                  },
                  title: const Text("Minusculas")),
              CheckboxListTile(
                  value: Numeros,
                  onChanged: (bool ? value) {
                    setState(() {
                      if (value == true) {
                        Numeros = true;
                      }
                      else {
                        Numeros = false;
                      }
                    });
                  },
                  title: const Text("Numeros")),
              CheckboxListTile(
                  value: Caracteres,
                  onChanged: (bool ? value) {
                    setState(() {
                      if (value == true) {
                        Caracteres = true;
                      }
                      else {
                        Caracteres = false;
                      }
                    });
                  },
                  title: const Text("Caracteres Especiales")),
              ElevatedButton(
                onPressed: () {
                  generate();
                },
                child: const Text("Generar"),
              ),
              Padding(padding: EdgeInsets.only(top: 10) ,child: Text("${newPassword}", textAlign: TextAlign.center))
            ]));
  }
}
