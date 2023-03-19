import 'package:actividades/Actividad4/pages/home.dart';
import 'package:actividades/Actividad4/pages/profile.dart';
import 'package:flutter/material.dart';


class MainAppEjemplo1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppEjemplo1();
  }
}

class _MainAppEjemplo1 extends State<MainAppEjemplo1> {
  final List<Widget> pages = [Home(), Profile()];
  int currentlyIndex = 0;

  void changePage(int index) {

    setState(() {
      currentlyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generador de Contraseñas"),
      ),
      body: pages[currentlyIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: BottomNavigationBar(
          onTap: changePage,
          currentIndex:currentlyIndex,
          items: [
            BottomNavigationBarItem(
              label: "Inicio",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Perfil",
              icon: Icon(Icons.person),
            )
          ],
        ),
      ),
    );
  }
}