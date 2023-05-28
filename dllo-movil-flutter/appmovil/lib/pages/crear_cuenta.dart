import 'dart:io';
import 'dart:math';

import 'package:appmovil/pages/login.dart';
import 'package:appmovil/pages/widgets/header_widget.dart';
import 'package:appmovil/services/firebase_storage.dart';
import 'package:appmovil/services/upload_image.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../common/theme_helper.dart';

class CrearCuenta extends StatefulWidget {
  const CrearCuenta({super.key});

  @override
  State<CrearCuenta> createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();

  final fb = FirebaseDatabase.instance;

  File? imagen_to_upload;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();

    var rng = Random();
    var k = rng.nextInt(10000);

    final ref = fb.ref().child('users/$k');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 150,
                child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  child: imagen_to_upload != null
                                      ? ClipOval(
                                          child: Image.file(imagen_to_upload!,
                                              fit: BoxFit.cover,
                                              width: 150,
                                              height: 150))
                                      : Icon(
                                          Icons.person,
                                          color: Colors.grey.shade300,
                                          size: 80.0,
                                        ),
                                  onTap: () async {
                                    final imagen = await getImage();
                                    setState(() {
                                      imagen_to_upload = File(imagen!.path);
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: TextFormField(
                            controller: first,
                            decoration: ThemeHelper().textInputDecoration(
                                'Primer Nombre*', 'Ingrese su Primer Nombre'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Por favor, Ingrese su Primer Nombre";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: second,
                            decoration: ThemeHelper().textInputDecoration(
                                'Primer Apellido*',
                                'Ingrese su Primer Apellido'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Por favor, Ingrese su Primer Apellido";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: third,
                            decoration: ThemeHelper().textInputDecoration(
                                "Correo Electronico*",
                                "Ingrese su Correo Electronico"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Ingrese un Correo Electronico Valido";
                              } else if (val.isEmpty) {
                                return "Por favor, Ingrese su Correo Electronico";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: fourth,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Contraseña*", "Ingrese tu Contraseña"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Por favor, Ingrese la Contraseña";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "Acepta todos los terminos y condiciones",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'Necesitas aceptar los terminos y condiciones';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Registrar".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              var uploaded;

                              if (_formKey.currentState!.validate()) {
                                if (imagen_to_upload != null) {
                                  uploaded =
                                      await uploadImage(imagen_to_upload!);
                                  ref.set({
                                    "name": first.text,
                                    "lastname": second.text,
                                    "email": third.text,
                                    "password": fourth.text,
                                    "imagen": uploaded
                                  }).asStream();
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.success,
                                        title: "Tu cuenta ha sido creada!",
                                      ));
                                  Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      setState(() {});
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                          (Route<dynamic> route) => false);
                                    },
                                  );
                                } else {
                                  ref.set({
                                    "name": first.text,
                                    "lastname": second.text,
                                    "email": third.text,
                                    "password": fourth.text
                                  }).asStream();
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.success,
                                        title: "Tu cuenta ha sido creada!",
                                      ));
                                  Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      setState(() {});
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                          (Route<dynamic> route) => false);
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
