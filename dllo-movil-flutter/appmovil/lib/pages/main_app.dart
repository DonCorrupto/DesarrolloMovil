import 'package:appmovil/pages/actividades.dart';
import 'package:appmovil/pages/ciudades.dart';
import 'package:appmovil/pages/perfil.dart';
import 'package:flutter/material.dart';

class MainAppViaje extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppViaje();
  }
}

class _MainAppViaje extends State<MainAppViaje> {
  final List<Widget> pages = [Ciudades(), perfil()];
  int currentlyIndex = 0;

  void changePage(int index) {
    setState(() {
      currentlyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentlyIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: changePage,
          currentIndex: currentlyIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Ciudades",
              icon: Icon(Icons.home, color: Colors.red,),
            ),
            BottomNavigationBarItem(
              label: "Perfil",backgroundColor:Colors.red,
              icon: Icon(Icons.people, color: Colors.red,),
            )
          ],
        ),
      ),
    );
  }
}