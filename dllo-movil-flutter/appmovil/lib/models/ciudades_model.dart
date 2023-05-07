import 'package:appmovil/controller/ciudades.dart';
import 'package:appmovil/models/actividad_model.dart';

import 'imagenes_model.dart';

class Ciudad {
  dynamic key;
  String? ciudad;
  String? description;
  int? follow;
  String? location;
  String? pais;
  List actividad;
  List imagenes;

  Ciudad(
      {this.key,
      required String this.ciudad,
      required String this.description,
      required int this.follow,
      required String this.location,
      required String this.pais,
      required List this.actividad,
      required List this.imagenes});
}
