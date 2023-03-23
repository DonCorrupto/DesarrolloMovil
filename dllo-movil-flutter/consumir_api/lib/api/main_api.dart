import 'package:consumir_api/api/pages/home.dart';
import 'package:consumir_api/api/pages/list_personajes.dart';
import 'package:consumir_api/api/pages/profile.dart';
import 'package:flutter/material.dart';

class MainAppMarvel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppMarvel();
  }
}

class _MainAppMarvel extends State<MainAppMarvel> {
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
        title: const Text("Marvel", style: TextStyle(fontSize: 25),),
        backgroundColor: Colors.red,
        centerTitle: true,

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
              label: "Personajes",
              icon: Icon(Icons.people),
            )
          ],
        ),
      ),
    );
  }
}