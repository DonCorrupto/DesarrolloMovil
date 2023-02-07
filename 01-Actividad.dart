import 'dart:io';

void main(List<String> args) {
  print(
      "Bienvenidos al centro asistencial para lisiados. Pulsa cualquier tecla");

  var listCentroAsistencial = [];
  String input = stdin.readLineSync().toString();

  while (input != "0") {
    print("1 - Ingresar un paciente, 2 - Edad promedio de hombres casados, 3 - Porcentaje de mujeres solteras respecto al total de personas solteras, 4 - Porcentaje de hombres solteros que han asistido en una semana respecto al total de hombres asistentes o 0 para salir");
    input = stdin.readLineSync().toString();
    var listTemporal = [];
    if (input == "1") {
      print("Ingrese el sexo del paciente. 1 - Hombre o 2 - Mujer");
      var sexo = int.parse(stdin.readLineSync()!);
      print("Ingrese el estado civil del paciente, 1- Soltero, 2 - Casado, 3 - Viudo");
      var estadoCivil = int.parse(stdin.readLineSync()!);
      print("Ingrese la edad del paciente");
      var edadPaciente = int.parse(stdin.readLineSync()!);

      listTemporal.add(sexo);
      listTemporal.add(estadoCivil);
      listTemporal.add(edadPaciente);
    }
    listCentroAsistencial.add(listTemporal);

    if (input == "2") {
      for (var i = 0; i < listCentroAsistencial.length; i++) {
        for (var x = 0; x < listCentroAsistencial.length ; x++) {
          
        }
      }
    }

    if (input == "3") {
      
    }

  }
}
