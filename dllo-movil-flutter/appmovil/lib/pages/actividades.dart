import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Actividades extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Actividades();
  }
}

class _Actividades extends State<Actividades> {
  List<dynamic> image = [
    "https://i.pinimg.com/564x/08/2f/3c/082f3c618f2399d9c6ccfb01312cb429.jpg",
    "https://i.pinimg.com/564x/d3/43/bd/d343bd41d7c4461f79a554f6db577f29.jpg",
    "https://i.pinimg.com/564x/6f/ae/cc/6faecc71e59fc56cf184e663ff81357a.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return PlaceDetailScreen(
        image: image, screenHeight: MediaQuery.of(context).size.height);
  }
}

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({
    super.key,
    required this.image,
    required this.screenHeight,
  });

  final List image;
  final double screenHeight;

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
                                          itemCount: widget.image.length,
                                          physics: BouncingScrollPhysics(),
                                          controller: PageController(
                                              viewportFraction: .9),
                                          itemBuilder: (context, index) {
                                            final imageUrl =
                                                widget.image[index];
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
                                      "Actividad",
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
                                        "Ciudad",
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
                                        label: Text("300")),
                                    Spacer(),
                                    TextButton.icon(
                                        onPressed: () {},
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
                                        label: Text("Check-in")),
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
                                      child: Text(
                                    "LOCALIZACIÒN",
                                    style: TextStyle(color: Colors.blue),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ))
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
                    Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "COMENTARIOS:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )),
            //ARREGLAR TAMAÑO DEL BOX PORQUE NO SE ADAPTA AL TAMAÑO
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10000,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemExtent: 90,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      elevation: 5,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Usuario"),
                            subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
                          )
                        ],
                      ),
                    );
                  },
                ),
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
