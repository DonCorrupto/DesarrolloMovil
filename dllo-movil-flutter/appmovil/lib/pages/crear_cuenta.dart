import 'package:appmovil/pages/login.dart';
import 'package:flutter/material.dart';

import 'custom_input.dart';

class CrearCuenta extends StatefulWidget {
  const CrearCuenta({super.key});

  @override
  State<CrearCuenta> createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  Map<String, dynamic> userInfo = {
    "name": "",
    "email": "",
    "phone": "",
    "password": "",
    "rol": "",
    "semester": 0.0,
    "is_student": false,
  };

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Cuenta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const Text("Crear Cuenta"),
              // Nombre
              CustomInput(
                userInfo: userInfo,
                property: "name",
                labelText: "Nombre",
                hintText: "Ingrese su nombre",
                // autofocus: true,
              ),
              // Correo
              CustomInput(
                userInfo: userInfo,
                property: "email",
                labelText: "Email",
                type: TextInputType.emailAddress,
              ),
              CustomInput(
                userInfo: userInfo,
                property: "phone",
                labelText: "Celular",
                type: TextInputType.phone,
              ),
              CustomInput(
                labelText: "Contraseña",
                obscureText: true,
                userInfo: userInfo,
                property: "password",
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    FormState? state = formKey.currentState;
                    if (state != null && state.validate()) {
                      print("OK");
                      print(userInfo);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    } else {
                      print("Form invalido");
                    }
                  },
                  child: Text("Guardar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
