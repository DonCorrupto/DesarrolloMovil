import 'dart:convert';

import 'package:appmovil/models/user.dart';
import 'package:appmovil/pages/main_app.dart';
import 'package:appmovil/services/firebase_service.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';

import '../common/theme_helper.dart';
import 'widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();

  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();

  List<dynamic> users = [];

  Future<void> obtenerUsers() async {
    //no esta funcionando el limite
    const url = 'https://appmovil-88754-default-rtdb.firebaseio.com/users.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          users = jsonData.values.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          //print(users);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerUsers();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    final myData = Provider.of<userData>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder(
              future: FirebaseService.firebaseInit(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: _headerHeight,
                          child: HeaderWidget(
                              _headerHeight,
                              true,
                              Icons
                                  .login_rounded), //let's create a common header widget
                        ),
                        SafeArea(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              margin: EdgeInsets.fromLTRB(20, 10, 20,
                                  10), // This will be the login form
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hola',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Inicio de Sesión',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 30.0),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: TextFormField(
                                              controller: first,
                                              decoration: ThemeHelper()
                                                  .textInputDecoration(
                                                      'Correo Electronico',
                                                      'Ingresa tu email'),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (val) {
                                                if (!(val!.isEmpty) &&
                                                    !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                        .hasMatch(val)) {
                                                  return "Ingrese un Correo Electronico Valido";
                                                } else if (val!.isEmpty) {
                                                  return "Por favor, Ingrese su Correo Electronico";
                                                }
                                                return null;
                                              },
                                            ),
                                            decoration: ThemeHelper()
                                                .inputBoxDecorationShaddow(),
                                          ),
                                          SizedBox(height: 30.0),
                                          Container(
                                            child: TextFormField(
                                              controller: second,
                                              obscureText: true,
                                              decoration: ThemeHelper()
                                                  .textInputDecoration(
                                                      'Contraseña',
                                                      'Ingresa tu Contraseña'),
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Por favor, Ingrese la Contraseña";
                                                }
                                                return null;
                                              },
                                            ),
                                            decoration: ThemeHelper()
                                                .inputBoxDecorationShaddow(),
                                          ),
                                          SizedBox(height: 15.0),
                                          Container(
                                            decoration: ThemeHelper()
                                                .buttonBoxDecoration(context),
                                            child: ElevatedButton(
                                              style:
                                                  ThemeHelper().buttonStyle(),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    40, 10, 40, 10),
                                                child: Text(
                                                  'Iniciar Sesión'
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onPressed: () {
                                                //print("$first , $second");
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  int pasaUser = 0;
                                                  for (var user in users) {
                                                    if (user['email'] ==
                                                        first.text) {
                                                      if (user['password'] ==
                                                          second.text) {
                                                        //print(user.runtimeType);

                                                        myData.updateUser(user);
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            MainAppViaje()),
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                        pasaUser = 1;
                                                        break;
                                                      }
                                                    }
                                                  }
                                                  if (pasaUser == 0) {
                                                    //print("Incorrecto");
                                                    ArtSweetAlert.show(
                                                        context: context,
                                                        artDialogArgs: ArtDialogArgs(
                                                            type:
                                                                ArtSweetAlertType
                                                                    .danger,
                                                            title: "Oops...",
                                                            text:
                                                                "Email o Contraseña son incorrectas :("));
                                                    Future.delayed(
                                                      Duration(milliseconds: 5),
                                                      () {
                                                        first.clear();
                                                        second.clear();
                                                      },
                                                    );
                                                  }
                                                } else {
                                                  print("Error");
                                                }
                                                //After successful login we will redirect to profile page. Let's create profile page now
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "O ingresa usando cuenta de google",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(height: 25.0),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .googlePlus,
                                                      size: 35,
                                                      color:
                                                          HexColor("#EC2D2F"),
                                                    ),
                                                    onTap: () async {
                                                      User? userFirebase =
                                                          await FirebaseService
                                                              .signInWithGoogle();

                                                      List<String>? partesName =
                                                          userFirebase
                                                              ?.displayName
                                                              ?.split(' ');

                                                      //print(partesName?[0]);

                                                      Map<String, dynamic>
                                                          userGoogle = {};

                                                      userGoogle['email'] =
                                                          userFirebase?.email;
                                                      userGoogle['name'] =
                                                          partesName?[0];
                                                      userGoogle['lastname'] =
                                                          partesName?[1];
                                                      userGoogle['imagen'] =
                                                          userFirebase
                                                              ?.photoURL;
                                                      userGoogle['google'] =
                                                          userFirebase
                                                              ?.emailVerified;

                                                      myData.updateUser(
                                                          userGoogle);

                                                      Navigator.of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MainAppViaje()),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                    })
                                              ]),
                                        ],
                                      )),
                                ],
                              )),
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
