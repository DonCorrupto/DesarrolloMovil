import 'dart:convert';

import 'package:appmovil/models/user.dart';
import 'package:appmovil/pages/edit_profile.dart';
import 'package:appmovil/pages/list_Itinerario.dart';
import 'package:appmovil/pages/list_deseos.dart';
import 'package:appmovil/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class perfil extends StatefulWidget {
  const perfil({super.key});

  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  List<dynamic> listaActividades = [];
  List<dynamic> listActivity = [];

  Future<void> obtenerListaActividades() async {
    //no esta funcionando el limite
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/listaactividades.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          listaActividades = jsonData.values.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          //print(listaActividades);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  List<dynamic> ciudad = [];

  Future<void> obtenerCiudades() async {
    //no esta funcionando el limite
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/ciudades.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          ciudad = jsonData.values.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          //print(acti);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerListaActividades();
    obtenerCiudades();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Data = Provider.of<userData>(context);
    dynamic user = Data.userDatos;

    String name = user['name'];
    String lastname = user['lastname'];

    //print(user);

    for (var actividadUser in listaActividades) {
      if (actividadUser['email'] == user['email']) {
        setState(() {
          listActivity.add(actividadUser);
        });
      }
    }

    print(listActivity);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: listActivity.isEmpty
          ? Container(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.6,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 130,
                              ),
                              Text(
                                'Mi Perfil',
                                style: GoogleFonts.josefinSans(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (Route<dynamic> route) => false);
                                  },
                                  icon: Icon(
                                    Icons.dark_mode_outlined,
                                    color: Colors.indigoAccent,
                                  ))
                            ],
                          ),
                          ClipOval(
                            child: Image.network(
                              user['imagen'] ?? "https://raw.githubusercontent.com/InvenceSaltillo/flutter_profile_screen/main/assets/me.jpg",
                              width: size.width * 0.6,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: '$name $lastname \n',
                              style: GoogleFonts.josefinSans(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomElevatedButton(
                                text: 'Editar Perfil',
                                primary: Color(0xff4245ff),
                                estadoBoton: 0,
                              ),
                              CustomElevatedButton(
                                text: 'Futuros Viajes',
                                primary: Color(0xff4245ff),
                                estadoBoton: 1,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 1),
                  for (dynamic actividad in listActivity)
                   
                    CustomCard(
                      activity: actividad,
                      infoCiudad: ciudad,
                    ),
                  SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key, required this.text, this.primary, required this.estadoBoton})
      : super(key: key);

  final String text;
  final Color? primary;
  final int estadoBoton;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return estadoBoton == 0
        ? ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editProfile()));
            },
            child: Text('$text'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: primary != null
                  ? BorderSide.none
                  : BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
              fixedSize: Size(size.width * 0.4, size.height * .065),
              padding: const EdgeInsets.all(10),
              primary: primary != null ? primary : Colors.white,
              onPrimary: primary != null ? Colors.white : Colors.grey[500],
              textStyle: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => listDeseos()));
            },
            child: Text('$text'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: primary != null
                  ? BorderSide.none
                  : BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
              fixedSize: Size(size.width * 0.4, size.height * .065),
              padding: const EdgeInsets.all(10),
              primary: primary != null ? primary : Colors.white,
              onPrimary: primary != null ? Colors.white : Colors.grey[500],
              textStyle: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.activity,
      required this.infoCiudad})
      : super(key: key);

  final dynamic activity;
  final dynamic infoCiudad;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: size.height * 0.5,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 7),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => listItinerario()));
                    },
                    child: Image.network(
                      'https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.heart,
                            color: Colors.red,
                            size: 20,
                          ),
                          Text(
                            '500',
                            style: GoogleFonts.josefinSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pais-Ciudad',
                        style: GoogleFonts.josefinSans(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ubicación',
                    style: GoogleFonts.josefinSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
