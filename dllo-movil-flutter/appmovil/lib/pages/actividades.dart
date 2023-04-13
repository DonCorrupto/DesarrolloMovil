import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Paises extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Paises();
  }
}

class _Paises extends State<Paises> {
  List<dynamic> image = [
    "https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg",
    "https://i.pinimg.com/564x/d3/43/bd/d343bd41d7c4461f79a554f6db577f29.jpg",
    "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Actividades",
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
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: image.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (_, animation, __) {
                    return FadeTransition(
                        opacity: animation,
                        child: Scaffold(
                            body: CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: BuilderPersistentDelegate(
                                  maxExtent: MediaQuery.of(context).size.height,
                                  minExtent: 240,
                                  builder: (percent) {
                                    final double topPercent =
                                        ((1 - percent) / .7).clamp(0.0, 1.0);
                                    final double bottomPercent =
                                        (percent / .3).clamp(0.0, 1.0);
                                    final topPadding =
                                        MediaQuery.of(context).padding.top;
                                    return Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ClipRRect(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: (20 + topPadding) *
                                                  (1 - bottomPercent),
                                              bottom: 160 * (1 - bottomPercent),
                                            ),
                                            child: Transform.scale(
                                              scale: lerpDouble(
                                                  1, 1.3, bottomPercent)!,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: PageView.builder(
                                                      itemCount: image.length,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      controller:
                                                          PageController(
                                                              viewportFraction:
                                                                  .9),
                                                      itemBuilder:
                                                          (context, index) {
                                                        final imageUrl =
                                                            image[index];
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                blurRadius: 10,
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                      imageUrl),
                                                              fit: BoxFit.cover,
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .black26,
                                                                      BlendMode
                                                                          .darken),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: List.generate(
                                                        image.length,
                                                        (index) => Container(
                                                              color:
                                                                  Colors.black,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          3),
                                                              height: 3,
                                                              width: 10,
                                                            )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                            top: null,
                                            child: Container(
                                              height: 140,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue.shade50,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              30))),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton.icon(
                                                      onPressed: () {},
                                                      style: TextButton.styleFrom(
                                                          primary: Colors.black,
                                                          textStyle: TextStyle(fontSize: 17),
                                                          shape:
                                                              StadiumBorder()),
                                                      icon: Icon(
                                                          CupertinoIcons.heart),
                                                      label: Text("500"))
                                                ],
                                              ),
                                            )),
                                        Positioned.fill(
                                            top: null,
                                            child: Container(
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              30))),
                                            ))
                                      ],
                                    );
                                  }),
                            ),
                            SliverToBoxAdapter(child: Placeholder()),
                            SliverToBoxAdapter(child: Placeholder()),
                            SliverToBoxAdapter(child: Placeholder()),
                          ],
                        )));
                  },
                ));
              },
              child: Container(
                height: 400,
                margin: EdgeInsets.only(bottom: 15, top: 10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(image[index]),
                      fit: BoxFit.cover,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://us.123rf.com/450wm/tuktukdesign/tuktukdesign1712/tuktukdesign171200016/91432570-icono-de-usuario-vector-s%C3%ADmbolo-de-s%C3%ADmbolo-de-persona-masculina-avatar-iniciar-sesi%C3%B3n-ilustraci%C3%B3n-de.jpg"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Usuario",
                                style: TextStyle(color: Colors.white)),
                            Text("Creador de Contenido",
                                style: TextStyle(color: Colors.white70))
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Spacer(),
                    Text("Pais, Ciudad",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "Actividad",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                primary: Colors.white, shape: StadiumBorder()),
                            icon: Icon(CupertinoIcons.heart),
                            label: Text("500"))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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
