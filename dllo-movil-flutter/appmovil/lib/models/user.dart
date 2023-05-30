import 'package:flutter/material.dart';

class userData extends ChangeNotifier {
   dynamic userDatos;

  void updateUser(dynamic user) {
    userDatos = user;
    notifyListeners();
  }

  void clearUser() {
    userDatos;
  }
}
