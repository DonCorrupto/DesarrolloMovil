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
      var sexo = int.parse(stdin.readLineSync().toString()!);
      print("Ingrese el estado civil del paciente, 1 - Soltero, 2 - Casado, 3 - Viudo");
      var estadoCivil = int.parse(stdin.readLineSync().toString()!);
      print("Ingrese la edad del paciente");
      var edadPaciente = int.parse(stdin.readLineSync().toString()!);

      listTemporal.add(sexo);
      listTemporal.add(estadoCivil);
      listTemporal.add(edadPaciente);
      listCentroAsistencial.add(listTemporal);
    }


    if (input == "2") {
      var suma = 0;
      var sumaCasado = 0;

      for (var i = 0; i < listCentroAsistencial.length; i++) {
        //print(listCentroAsistencial[i][1]);
        if (listCentroAsistencial[i][0] == 1) {
          suma += 1;
          if (listCentroAsistencial[i][1] == 2 ) {
            sumaCasado += int.parse(listCentroAsistencial[i][1]);
          }
        }
      }

      var promedioCasado = sumaCasado / suma;
      print("El promedio de edad de hombres casados son $promedioCasado");
    }

    if (input == "3") {
      var sumaMujerSoltera = 0;
      var sumaPersonaSolteras = 0;
      for (var i = 0; i < listCentroAsistencial.length; i++) {
        if (listCentroAsistencial[i][0] == 2 && listCentroAsistencial[i][1] == 1) {
          sumaMujerSoltera += 1;
        }

        if (listCentroAsistencial[i][1] == 1) {
          sumaPersonaSolteras += 1;
        }
      }

      var porcentajeMujeresSolteraspersonasSolteras = (sumaMujerSoltera/sumaPersonaSolteras)*100;

      print("El porcentaje de mujeres solteras respecto al total de personas solteras son $porcentajeMujeresSolteraspersonasSolteras %");
    }

    if (input == "4") {
      var sumaHombresSolteros = 0;
      var sumaHombresAsistentes = 0;
      for (var i = 0; i < listCentroAsistencial.length; i++) {
        if (listCentroAsistencial[i][0] == 1 && listCentroAsistencial[i][1] == 1) {
          sumaHombresSolteros += 1;
        }
        if (listCentroAsistencial[i][0] == 1) {
          sumaHombresAsistentes += 1;
        }

      }

      var porcentajeHombresSolterosHombresAsistentes = (sumaHombresSolteros/sumaHombresAsistentes)*100;
      print("El porcentaje de hombres solteros que alli han asistido en una semana respecto al total de hombres asistentes $porcentajeHombresSolterosHombresAsistentes %");
    }

  }
}
