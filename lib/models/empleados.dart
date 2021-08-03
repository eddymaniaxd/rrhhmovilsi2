// To parse this JSON data, do
//
//     final empleados = empleadosFromMap(jsonString);

import 'dart:convert';

Empleados empleadosFromMap(String str) => Empleados.fromMap(json.decode(str));

String empleadosToMap(Empleados data) => json.encode(data.toMap());

class Empleados {
  Empleados({
    required this.empleados,
    required this.total,
    required this.parPaginacion,
  });

  List<Empleado> empleados;
  int total;
  ParPaginacion parPaginacion;

  factory Empleados.fromMap(Map<String, dynamic> json) => Empleados(
        empleados: List<Empleado>.from(
            json["empleados"].map((x) => Empleado.fromMap(x))),
        total: json["total"],
        parPaginacion: ParPaginacion.fromMap(json["parPaginacion"]),
      );

  Map<String, dynamic> toMap() => {
        "empleados": List<dynamic>.from(empleados.map((x) => x.toMap())),
        "total": total,
        "parPaginacion": parPaginacion.toMap(),
      };
}

class Empleado {
  Empleado({
    required this.id,
    required this.usuario,
    required this.perfil,
    required this.persona,
    required this.tipoEmpleado,
    required this.cargo,
    required this.sucursal,
  });

  int id;
  String usuario;
  String perfil;
  String persona;
  String tipoEmpleado;
  String cargo;
  String sucursal;

  factory Empleado.fromMap(Map<String, dynamic> json) => Empleado(
        id: json["id"],
        usuario: json["usuario"],
        perfil: json["perfil"],
        persona: json["persona"],
        tipoEmpleado: json["tipo_empleado"],
        cargo: json["cargo"],
        sucursal: json["sucursal"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "usuario": usuario,
        "perfil": perfil,
        "persona": persona,
        "tipo_empleado": tipoEmpleado,
        "cargo": cargo,
        "sucursal": sucursal,
      };
}

class ParPaginacion {
  ParPaginacion({
    required this.pagActual,
    required this.totPaginas,
  });

  int pagActual;
  int totPaginas;

  factory ParPaginacion.fromMap(Map<String, dynamic> json) => ParPaginacion(
        pagActual: json["pagActual"],
        totPaginas: json["totPaginas"],
      );

  Map<String, dynamic> toMap() => {
        "pagActual": pagActual,
        "totPaginas": totPaginas,
      };
}
