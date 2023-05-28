import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:appmovil/pages/main_app.dart';
import 'package:appmovil/pages/perfil.dart';
import 'package:appmovil/pages/widgets/header_widget.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../common/theme_helper.dart';
import '../models/user.dart';
import '../services/firebase_storage.dart';
import '../services/upload_image.dart';
import 'login.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  List<dynamic> users = [];
  List<dynamic> usersKey = [];

  final fb = FirebaseDatabase.instance;

  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();

  File? imagen_to_upload;

  Future<void> obtenerUsers() async {
    //no esta funcionando el limite
    const url = 'https://appmovil-88754-default-rtdb.firebaseio.com/users.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          users = jsonData.values.toList();
          usersKey = jsonData.keys.toList();
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

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    //print(users);
    final Data = Provider.of<userData>(context);
    dynamic user = Data.userDatos;

    String name = user['name'];
    String lastname = user['lastname'];
    String emailUser = user['email'];
    String urlImage = user['imagen'];

    dynamic onlyUser;
    dynamic onlyKey;

    for (var i = 0; i < users.length; i++) {
      if (emailUser == users[i]['email']) {
        onlyUser = users[i];
        onlyKey = usersKey[i];
        break;
      }
    }

    //print(onlyUser);
    //print(onlyKey.runtimeType);

    GlobalKey<FormState> formKey = GlobalKey();

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
                                '$name*', 'Ingrese su Primer Nombre'),
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
                                '$lastname*', 'Ingrese su Primer Apellido'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Por favor, Ingrese su Primer Apellido";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Editar Perfil".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              var uploaded;
                              var key = onlyKey.toString();

                              final ref = fb.ref().child('users/$key');
                              print(key);

                              if (_formKey.currentState!.validate()) {
                                if (imagen_to_upload != null) {
                                  uploaded =
                                      await uploadImage(imagen_to_upload!);
                                  ref.update({
                                    "name": first.text,
                                    "lastname": second.text,
                                    "imagen": uploaded
                                  }).asStream();
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.success,
                                        title: "Tu perfil ha sido actualizado!",
                                      ));
                                  Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      setState(() {});
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainAppViaje()),
                                          (Route<dynamic> route) => false);
                                    },
                                  );
                                } else {
                                  ref.update({
                                    "name": first.text,
                                    "lastname": second.text,
                                    "imagen": urlImage
                                  }).asStream();
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                        type: ArtSweetAlertType.success,
                                        title: "Tu perfil ha sido actualizado!",
                                      ));
                                  Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      setState(() {});
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainAppViaje()),
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
