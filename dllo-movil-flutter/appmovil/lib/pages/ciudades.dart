import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:appmovil/models/imagenes_model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/ciudades_model.dart';
import '../models/actividad_model.dart';
import 'actividades.dart';

class Ciudades extends StatefulWidget {
  const Ciudades({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Ciudades();
  }
}

class _Ciudades extends State<Ciudades> {
  List<dynamic> image = [
    "https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg",
    "https://i.pinimg.com/564x/d3/43/bd/d343bd41d7c4461f79a554f6db577f29.jpg",
    "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg"
  ];

  dynamic infoAllCity;

  final _ref = FirebaseDatabase.instance.ref();
  late StreamSubscription _ciudades;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = _ref.child('ciudades');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Ciudades",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
        body: FirebaseAnimatedList(
          query: data,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map Ciudad = snapshot.value as Map;
            final id = index + 1;
            final city = Ciudad['Ciudad'];
            final cityDescription = Ciudad['Descripcion'];
            final cityFollow = Ciudad['Follow'];
            final cityLocalizacion = Ciudad['Localizacion'];
            final cityPais = Ciudad['Pais'];

            return InkWell(
              onTap: () async {
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (_, animation, __) {
                    return FadeTransition(
                        opacity: animation,
                        child: PlaceDetailScreen(
                          id: id,
                          city: city,
                          cityDescription: cityDescription,
                          cityFollow: cityFollow,
                          cityLocalizacion: cityLocalizacion,
                          cityPais: cityPais,
                          screenHeight: MediaQuery.of(context).size.height,
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
                          image: NetworkImage(Ciudad['Imagenes']['0001I']),
                          fit: BoxFit.cover,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(Ciudad['Ciudad'],
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(Ciudad['Pais'],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            TextButton.icon(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    shape: StadiumBorder()),
                                icon: Icon(CupertinoIcons.heart),
                                label: Text(Ciudad['Follow'].toString()))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _ciudades.cancel();
  }
}

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen(
      {super.key,
      required this.screenHeight,
      required this.id,
      required this.city,
      required this.cityDescription,
      required this.cityFollow,
      required this.cityLocalizacion,
      required this.cityPais});

  final double screenHeight;
  final int id;
  final String city;
  final String cityDescription;
  final int cityFollow;
  final String cityLocalizacion;
  final String cityPais;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late ScrollController _controller;
  late ValueNotifier<double> bottomPercentNotifier;

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.https(url))) {
      await launchUrl(Uri.https(url));
    } else {
      throw 'No se pudo abrir la URL $url';
    }
  }

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

  @override
  void initState() {
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

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ciu = widget.city;
    final country = widget.cityPais;
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
                                        itemCount: 3,
                                        physics: BouncingScrollPhysics(),
                                        controller: PageController(
                                            viewportFraction: .9),
                                        itemBuilder: (context, index) {
                                          return AnimatedContainer(
                                            duration: kThemeAnimationDuration,
                                            margin: EdgeInsets.only(right: 10),
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
                                                image: NetworkImage(
                                                    "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg"),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black26,
                                                    BlendMode.darken),
                                              ),
                                            ),
                                          );
                                        },
                                      )),
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
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                            primary: Colors.black,
                                            textStyle: TextStyle(fontSize: 17),
                                            shape: StadiumBorder()),
                                        icon: Icon(
                                          CupertinoIcons.heart,
                                          size: 26,
                                        ),
                                        label:
                                            Text(widget.cityFollow.toString())),
                                    Spacer(),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Actividades(
                                                        estado: 0,
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
                                      child: TextButton(
                                          onPressed: () {
                                            print(widget.cityLocalizacion);
                                          },
                                          child: Text("$ciu, $country",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              maxLines: 1,
                                              overflow:
                                                  TextOverflow.ellipsis))),
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final collectionPage =
                        "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg";
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
                height: 20,
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
