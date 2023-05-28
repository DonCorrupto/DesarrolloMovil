import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:appmovil/pages/actividades.dart';
import 'package:appmovil/pages/main_app.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';

class Ciudades extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Ciudades();
  }
}

class _Ciudades extends State<Ciudades> {
  List<dynamic> ciudad = [];
  List<dynamic> ciudadKey = [];

  Future<void> obtenerCiudades() async {
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/ciudades.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          ciudad = jsonData.values.toList();
          ciudadKey = jsonData.keys.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          //print(ciudad);
          //print(ciudadKey);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerCiudades();
  }

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseDatabase.instance;

    final Data = Provider.of<userData>(context);
    dynamic user = Data.userDatos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Ciudades del Mundo",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Center(
          child: ciudad.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: ciudad.length,
                    itemBuilder: (context, index) {
                      final city = ciudad[index]['Ciudad'];
                      final cityDescription = ciudad[index]['Descripcion'];
                      var cityFollow;
                      var listFollow;
                      var listFollowKeys;

                      var emailContador;
                      var KeyContador;

                      try {
                        cityFollow = ciudad[index]['Follow'].length.toString();
                        listFollow = ciudad[index]['Follow'].values.toList();
                        listFollowKeys = ciudad[index]['Follow'].keys.toList();
                      } catch (e) {
                        cityFollow = "0";
                        listFollow = ["user"];
                        listFollowKeys = ["000"];
                      }
                      final cityLocalizacion = ciudad[index]['Localizacion'];
                      final cityPais = ciudad[index]['Pais'];
                      final cityImages =
                          ciudad[index]['Imagenes'].values.toList();
                      final cityActividad =
                          ciudad[index]['Actividad'].values.toList();

                      if (listFollow[0] == user['email']) {
                        emailContador = 1;
                        KeyContador = listFollowKeys[0];
                      } else {
                        emailContador = 0;
                        KeyContador = "000";
                      }
                      return InkWell(
                        onTap: () async {
                          Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (_, animation, __) {
                              return FadeTransition(
                                  opacity: animation,
                                  child: PlaceDetailScreen(
                                    index: index,
                                    city: city,
                                    cityDescription: cityDescription,
                                    cityFollow: cityFollow,
                                    cityLocalizacion: cityLocalizacion,
                                    cityPais: cityPais,
                                    cityImages: cityImages,
                                    cityActividad: cityActividad,
                                    user: user['email'],
                                    ciudadKey: ciudadKey[index],
                                    contadorEmail: emailContador,
                                    contadorKey: KeyContador,
                                    screenHeight:
                                        MediaQuery.of(context).size.height,
                                  ));
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                                height: 400,
                                margin: EdgeInsets.only(bottom: 15, top: 10),
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                )),
                            Container(
                              height: 400,
                              margin: EdgeInsets.only(bottom: 15, top: 10),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(cityImages[0]),
                                    fit: BoxFit.cover,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(ciudad[index]['Ciudad'],
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(ciudad[index]['Pais'],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: TextButton.icon(
                                            onPressed: () {
                                              final key = ciudadKey[index];
                                              var rng = Random();
                                              var k =
                                                  rng.nextInt(10000).toString();

                                              final keyFollow =
                                                  listFollowKeys[0];

                                              if (listFollow[0] ==
                                                  user['email']) {
                                                fb
                                                    .ref()
                                                    .child(
                                                        'ciudades/$key/Follow/$keyFollow')
                                                    .remove()
                                                    .then((_) {
                                                  //print("Dato Borrado");
                                                  setState(() {
                                                    ciudad = [];
                                                    ciudadKey = [];
                                                    obtenerCiudades();
                                                  });
                                                });
                                              } else {
                                                final refDeseos = fb
                                                    .ref()
                                                    .child(
                                                        'ciudades/$key/Follow');
                                                refDeseos.update({
                                                  k: user['email'],
                                                }).then((_) {
                                                  setState(() {
                                                    ciudad = [];
                                                    ciudadKey = [];
                                                    obtenerCiudades();
                                                  });
                                                });
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                shape: StadiumBorder()),
                                            icon: Icon(
                                                CupertinoIcons.heart_fill,
                                                color: listFollow[0] !=
                                                        user['email']
                                                    ? Colors.black
                                                    : Colors.red),
                                            label: Text(
                                              cityFollow.toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen(
      {super.key,
      required this.index,
      required this.screenHeight,
      required this.city,
      required this.cityDescription,
      required this.cityFollow,
      required this.cityLocalizacion,
      required this.cityPais,
      required this.cityImages,
      required this.cityActividad,
      required this.user,
      required this.ciudadKey,
      required this.contadorEmail,
      required this.contadorKey});

  final int index;
  final double screenHeight;
  final String city;
  final String cityDescription;
  final String cityFollow;
  final String cityLocalizacion;
  final String cityPais;
  final dynamic cityImages;
  final dynamic cityActividad;
  final dynamic user;
  final dynamic ciudadKey;
  final dynamic contadorEmail;
  final dynamic contadorKey;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late ScrollController _controller;
  late ValueNotifier<double> bottomPercentNotifier;

  void _scrollListener() {
    var percent =
        _controller.position.pixels / MediaQuery.of(context).size.height;
    bottomPercentNotifier.value = (percent / .3).clamp(0.0, 1.0);
  }

  void _isScrollingListener() {
    var percent = _controller.position.pixels / widget.screenHeight;

    if (!_controller.position.isScrollingNotifier.value) {
      if (percent < .3 && percent > .1) {
        _controller.animateTo(widget.screenHeight * .3,
            duration: kThemeAnimationDuration, curve: Curves.decelerate);
      }
      if (percent < .1 && percent > 0) {
        _controller.animateTo(0,
            duration: kThemeAnimationDuration, curve: Curves.decelerate);
      }
      if (percent < .5 && percent > .3) {
        _controller.animateTo(widget.screenHeight * .3,
            duration: kThemeAnimationDuration, curve: Curves.decelerate);
      }
    }
  }

  List<dynamic> ciudadFollow = [];
  List<dynamic> ciudadKeyFollow = [];

  List<dynamic> ciudad = [];
  List<dynamic> ciudadKey = [];

  var contadorFollowEmail;
  var contadorFollowKey;

  Future<void> obtenerCiudades() async {
    const url =
        'https://appmovil-88754-default-rtdb.firebaseio.com/ciudades.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          ciudad = jsonData.values.toList();
          ciudadKey = jsonData.keys.toList();
          //final acti = ciudad[0]['Actividad'].values.toList();
          //print(ciudadFollow[0]['Follow']);
          //print(ciudadKeyFollow);

          for (var i = 0; i < ciudad.length; i++) {
            if (ciudad[i]['Ciudad'] == widget.city &&
                ciudad[i]['Pais'] == widget.cityPais) {
              try {
                ciudadFollow.add(ciudad[i]['Follow'].values.toList());
                ciudadKeyFollow.add(ciudad[i]['Follow'].keys.toList());
              } catch (e) {
                ciudadFollow.add(["user"]);
                ciudadKeyFollow.add(["000"]);
              }
            }
          }

          for (var x = 0; x < ciudadFollow.length; x++) {
            if (ciudadFollow[x][0].toString() == widget.user) {
              setState(() {
                contadorFollowEmail = 1;
                contadorFollowKey = ciudadKeyFollow[x][0].toString();
              });
              break;
            }
          }
          //print(contadorFollowEmail);
        });
      }
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  void initState() {
    obtenerCiudades();
    contadorFollowEmail = widget.contadorEmail;
    contadorFollowKey = widget.contadorKey;
    _controller =
        ScrollController(initialScrollOffset: widget.screenHeight * .3);
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.position.isScrollingNotifier
          .addListener(_isScrollingListener);
    });
    bottomPercentNotifier = ValueNotifier(1.0);
    super.initState();
  }

  Future<void> _launchUrl() async {
    final url = Uri.parse(widget.cityLocalizacion);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Ciud = widget.city;
    final Pai = widget.cityPais;
    final imagenes = widget.cityImages;
    final fb = FirebaseDatabase.instance;

    //print(contadorFollowEmail);
    //print(contadorFollowKey);

    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: BuilderPersistentDelegate(
                  maxExtent: MediaQuery.of(context).size.height,
                  minExtent: 240,
                  builder: (percent) {
                    final double topPercent =
                        ((1 - percent) / .7).clamp(0.0, 1.0);
                    final double bottomPercent = (percent / .3).clamp(0.0, 1.0);
                    final topPadding = MediaQuery.of(context).padding.top;
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRect(
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: (20 + topPadding) * (1 - bottomPercent),
                                  bottom: 160 * (1 - bottomPercent),
                                ),
                                child: Transform.scale(
                                  scale: lerpDouble(1, 1.3, bottomPercent)!,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: PageView.builder(
                                          itemCount: imagenes.length,
                                          physics: BouncingScrollPhysics(),
                                          controller: PageController(
                                              viewportFraction: .9),
                                          itemBuilder: (context, index) {
                                            final imageUrl = imagenes[index];
                                            return AnimatedContainer(
                                              duration: kThemeAnimationDuration,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 10,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: NetworkImage(imageUrl),
                                                  fit: BoxFit.cover,
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black26,
                                                      BlendMode.darken),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: topPadding,
                                  left: -60 * (1 - bottomPercent),
                                  child: BackButton(
                                    color: Colors.white,
                                    onPressed: () => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainAppViaje()),
                                            (Route<dynamic> route) => false),
                                  )),
                              Positioned(
                                  top: lerpDouble(20, 140, topPercent)!
                                      .clamp(topPadding + 10, 140),
                                  left: lerpDouble(60, 20, topPercent)!
                                      .clamp(20.0, 50.0),
                                  right: 20,
                                  child: AnimatedOpacity(
                                    duration: kThemeAnimationDuration,
                                    opacity: bottomPercent < 1 ? 0 : 1,
                                    child: Text(
                                      widget.city,
                                      style: TextStyle(
                                          fontSize:
                                              lerpDouble(20, 40, topPercent),
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Positioned(
                                left: 20,
                                top: 200,
                                child: AnimatedOpacity(
                                    opacity: bottomPercent < 1 ? 0 : 1,
                                    duration: kThemeAnimationDuration,
                                    child: Opacity(
                                      opacity: topPercent,
                                      child: Text(
                                        widget.cityPais,
                                        style: TextStyle(
                                            fontSize:
                                                lerpDouble(20, 30, topPercent),
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        Positioned.fill(
                            top: null,
                            bottom: -140 * (1 - topPercent),
                            child: TranslateAnimation(
                              child: Container(
                                height: 140,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () async {
                                          final key = widget.ciudadKey;
                                          var rng = Random();
                                          var k = rng.nextInt(10000).toString();

                                          if (contadorFollowEmail == 1) {
                                            var cantidad =
                                                int.parse(widget.cityFollow) -
                                                    1;
                                            fb
                                                .ref()
                                                .child(
                                                    'ciudades/$key/Follow/$contadorFollowKey')
                                                .remove();
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaceDetailScreen(
                                                            index: widget.index,
                                                            city: widget.city,
                                                            cityDescription: widget
                                                                .cityDescription,
                                                            cityFollow: cantidad.toString(),
                                                            cityLocalizacion:
                                                                widget
                                                                    .cityLocalizacion,
                                                            cityPais: widget
                                                                .cityPais,
                                                            cityImages:
                                                                widget
                                                                    .cityImages,
                                                            cityActividad: widget
                                                                .cityActividad,
                                                            user: widget.user,
                                                            ciudadKey:
                                                                widget
                                                                    .ciudadKey,
                                                            contadorEmail: 0,
                                                            contadorKey: "000",
                                                            screenHeight: widget
                                                                .screenHeight)),
                                                (Route<dynamic> route) =>
                                                    false);
                                          } else {
                                            var cantidad =
                                                int.parse(widget.cityFollow) +
                                                    1;
                                            final refDeseos = fb
                                                .ref()
                                                .child('ciudades/$key/Follow');
                                            refDeseos.update({
                                              k: widget.user,
                                            });
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) => PlaceDetailScreen(
                                                        index: widget.index,
                                                        city: widget.city,
                                                        cityDescription: widget
                                                            .cityDescription,
                                                        cityFollow:
                                                            cantidad.toString(),
                                                        cityLocalizacion: widget
                                                            .cityLocalizacion,
                                                        cityPais:
                                                            widget.cityPais,
                                                        cityImages:
                                                            widget.cityImages,
                                                        cityActividad: widget
                                                            .cityActividad,
                                                        user: widget.user,
                                                        ciudadKey:
                                                            widget.ciudadKey,
                                                        contadorEmail: 1,
                                                        contadorKey:
                                                            contadorFollowKey,
                                                        screenHeight: widget
                                                            .screenHeight)),
                                                (Route<dynamic> route) =>
                                                    false);
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                            primary: Colors.black,
                                            textStyle: TextStyle(fontSize: 17),
                                            shape: StadiumBorder()),
                                        icon: Icon(
                                          CupertinoIcons.heart_fill,
                                          color: contadorFollowEmail == 0
                                              ? Colors.black
                                              : Colors.red,
                                          size: 26,
                                        ),
                                        label: Text(
                                          widget.cityFollow,
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    Spacer(),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Actividades(
                                                        estado: 0,
                                                        actividades: widget
                                                            .cityActividad,
                                                        id: widget.index,
                                                        ciudad: widget.city,
                                                        pais: widget.cityPais,
                                                      )));
                                        },
                                        icon:
                                            Icon(CupertinoIcons.bag_badge_plus),
                                        label: Text(
                                          "Futuros Viajes",
                                          style: TextStyle(fontSize: 12),
                                        )),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Actividades(
                                                        estado: 1,
                                                        actividades: widget
                                                            .cityActividad,
                                                        id: widget.index,
                                                        ciudad: widget.city,
                                                        pais: widget.cityPais,
                                                      )));
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade100,
                                            primary: Colors.blue.shade600,
                                            textStyle: TextStyle(fontSize: 17),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        icon: Icon(
                                          Icons.check_circle_outline_outlined,
                                          size: 26,
                                        ),
                                        label: Text(
                                          "Agregar al Itinerario",
                                          style: TextStyle(fontSize: 12),
                                        )),
                                  ],
                                ),
                              ),
                            )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.white,
                            height: 10,
                          ),
                        ),
                        Positioned.fill(
                          top: null,
                          child: TranslateAnimation(
                            child: Container(
                              height: 70,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.black26),
                                  Flexible(
                                      child: InkWell(
                                    child: Text(
                                      "$Ciud, $Pai",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () => _launchUrl(),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            SliverToBoxAdapter(
                child: TranslateAnimation(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.cityDescription),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "ACTIVIDADES EN ESTA CIUDAD",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 150,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: widget.cityActividad.length,
                  itemBuilder: (context, index) {
                    final collectionPage =
                        widget.cityActividad[index]['imagen'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              collectionPage,
                              fit: BoxFit.cover,
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
              ),
            )
          ],
        ),
      ],
    ));
  }
}

class BuilderPersistentDelegate extends SliverPersistentHeaderDelegate {
  BuilderPersistentDelegate({
    required double maxExtent,
    required double minExtent,
    required this.builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 100 * value),
          child: child,
        );
      },
      child: child,
    );
  }
}
