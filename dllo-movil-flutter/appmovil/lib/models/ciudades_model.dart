import 'package:appmovil/controller/ciudades.dart';
import 'package:appmovil/models/actividad_model.dart';

import 'imagenes_model.dart';

class Ciudad {
  late int key;
  late String ciudad;
  late String description;
  late int follow;
  late String location;
  late String pais;

  Ciudad(
      {required int this.key,
      required String this.ciudad,
      required String this.description,
      required int this.follow,
      required String this.location,
      required String this.pais});
}
