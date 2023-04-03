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
            return Container(
              height: 400,
              margin: EdgeInsets.only(bottom: 15, top: 10),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(image[index]),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.darken))),
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
                          Text("Usuario", style: TextStyle(color: Colors.white)),
                          Text("Creador de Contenido",
                              style: TextStyle(color: Colors.white70))
                        ],
                      ),
                      Spacer(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz, color: Colors.white,))
                    ],
                  ),
                  Spacer(),
                  Text("Pais, Ciudad",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  Text("Actividad",
                    style: TextStyle(fontSize: 20, color: Colors.white70)),
                ],
              ),
            );
          },
        ));
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Countries",
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
        body: Container(
          child: Center(
            child: image.isEmpty
                ? CircularProgressIndicator()
                : MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: image.length,
                      itemBuilder: (context, index) {
                        final imagenes = image[index];
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imagenes),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.darken))),
                        );
                      },
                    )),
          ),
        ));
  }
  */
}
