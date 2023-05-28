import 'package:appmovil/pages/ciudades.dart';
import 'package:appmovil/pages/perfil.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: GNav(
              gap: 8,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.blue.shade900,
              tabBackgroundColor: Colors.blue.shade100,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              onTabChange: (index) {
                changePage(index);
                
              },
              tabs: [
                GButton(
                  icon: Icons.location_city,
                  text: "Ciudades",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Perfil",
                )
              ]),
        ),
      ),
    );
  }
}
