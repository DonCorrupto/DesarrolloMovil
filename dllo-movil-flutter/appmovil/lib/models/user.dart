import 'package:flutter/material.dart';

class userData extends ChangeNotifier {

  late dynamic userDatos;

  void updateUser (dynamic user) {
    userDatos = user;
    notifyListeners();
  }
  
}