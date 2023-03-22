import 'package:consumir_api/api/pages/home.dart';
import 'package:consumir_api/api/pages/list_users.dart';
import 'package:consumir_api/api/pages/profile.dart';
import 'package:flutter/material.dart';

class MainAppEjemplo1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppEjemplo1();
  }
}

class _MainAppEjemplo1 extends State<MainAppEjemplo1> {
  final List<Widget> pages = [Home(), Profile(), CharactersMarvel()];
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
        title: const Text("Tareas"),
      ),
      body: pages[currentlyIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: BottomNavigationBar(
          onTap: changePage,
          currentIndex: currentlyIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Inicio",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Perfil",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "Usuarios",
              icon: Icon(Icons.people),
            )
          ],
        ),
      ),
    );
  }
}