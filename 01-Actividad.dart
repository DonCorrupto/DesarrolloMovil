import 'dart:io';

void main(List<String> args) {
  print(
      "Bienvenidos al centro asistencial para lisiados. Pulsa cualquier tecla");

  var listCentroAsistencial = [];
  String input = stdin.readLineSync().toString();

  while (input != "0") {
    print(
        "1 - Ingresar un paciente, 2 - Porcentaje de hombres solteros que han asistido en una semana respecto al total de hombres asistentes, 3 - Edad promedio de hombres casados, 4 - Porcentaje de mujeres solteras respecto al total de personas solteras o 0 para salir");
    input = stdin.readLineSync().toString();
    var listTemporal = [];
    if (input == "1") {
      print("Ingrese el sexo del paciente. 1 - Hombre o 2 - Mujer");
      var sexo = int.parse(stdin.readLineSync().toString());
      print(
          "Ingrese el estado civil del paciente, 1 - Soltero, 2 - Casado, 3 - Viudo");
      var estadoCivil = int.parse(stdin.readLineSync().toString());
      print("Ingrese la edad del paciente");
      var edadPaciente = int.parse(stdin.readLineSync().toString());

      listTemporal.add(sexo);
      listTemporal.add(estadoCivil);
      listTemporal.add(edadPaciente);
      listCentroAsistencial.add(listTemporal);
    }

    if (input == "2") {
      dynamic sumaHombresSolteros = 0;
      dynamic sumaHombresAsistentes = 0;
      for (var i = 0; i < listCentroAsistencial.length; i++) {
        if (listCentroAsistencial[i][0] == "M" && listCentroAsistencial[i][1] == "S") {
          sumaHombresSolteros += 1;
        }
        if (listCentroAsistencial[i][0] == "M") {
          sumaHombresAsistentes += 1;
        }
      }

      var porcentajeHombresSolterosHombresAsistentes =
          (sumaHombresSolteros / sumaHombresAsistentes) * 100;
      print(
          "El porcentaje de hombres solteros que alli han asistido en una semana respecto al total de hombres asistentes $porcentajeHombresSolterosHombresAsistentes %");
    }

    if (input == "3") {
      dynamic suma = 0;
      dynamic sumaCasado = 0;

      for (var i = 0; i < listCentroAsistencial.length; i++) {
        if (listCentroAsistencial[i][1] == "C" &&
            listCentroAsistencial[i][0] == "M") {
          sumaCasado += listCentroAsistencial[i][2];
          suma += 1;
        }
      }
      var promedioCasado = sumaCasado / suma;
      print("El promedio de edad de hombres casados son $promedioCasado");
    }

    if (input == "4") {
      dynamic sumaMujerSoltera = 0;
      dynamic sumaPersonaSolteras = 0;
      for (var i = 0; i < listCentroAsistencial.length; i++) {
        if (listCentroAsistencial[i][0] == "F" &&
            listCentroAsistencial[i][1] == "S") {
          sumaMujerSoltera += 1;
        }

        if (listCentroAsistencial[i][1] == "S") {
          sumaPersonaSolteras += 1;
        }
      }

      var porcentajeMujeresSolteraspersonasSolteras =
          (sumaMujerSoltera / sumaPersonaSolteras) * 100;

      print(
          "El porcentaje de mujeres solteras respecto al total de personas solteras son $porcentajeMujeresSolteraspersonasSolteras %");
    }
  }
}
