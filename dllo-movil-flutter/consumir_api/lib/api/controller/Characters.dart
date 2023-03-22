class Names {
  late String name;

  Names.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
  }

  @override
  String toString() {
    return name.toString();
  }
}

class Imagen {
  late String urlImagen;

  Imagen.fromJson(Map<String, dynamic> json) {
    urlImagen = json["thumbnail"]["path"];
  }

  @override
  String toString() {
    return urlImagen.toString() + ".jpg";
  }
}
