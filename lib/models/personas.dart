// To parse this JSON data, do
//
//     final personas = personasFromMap(jsonString);

import 'dart:convert';

Personas personasFromMap(String str) => Personas.fromMap(json.decode(str));

String personasToMap(Personas data) => json.encode(data.toMap());

class Personas {
  Personas({
    required this.personas,
    required this.total,
    required this.parPaginacion,
  });

  final List<Persona> personas;
  final int total;
  final ParPaginacion parPaginacion;

  factory Personas.fromMap(Map<String, dynamic> json) => Personas(
        personas:
            List<Persona>.from(json["personas"].map((x) => Persona.fromMap(x))),
        total: json["total"],
        parPaginacion: ParPaginacion.fromMap(json["parPaginacion"]),
      );

  Map<String, dynamic> toMap() => {
        "personas": List<dynamic>.from(personas.map((x) => x.toMap())),
        "total": total,
        "parPaginacion": parPaginacion.toMap(),
      };
}

class ParPaginacion {
  ParPaginacion({
    required this.pagActual,
    required this.totPaginas,
  });

  final int pagActual;
  final int totPaginas;

  factory ParPaginacion.fromMap(Map<String, dynamic> json) => ParPaginacion(
        pagActual: json["pagActual"],
        totPaginas: json["totPaginas"],
      );

  Map<String, dynamic> toMap() => {
        "pagActual": pagActual,
        "totPaginas": totPaginas,
      };
}

class Persona {
  Persona({
    required this.id,
    required this.nombres,
    required this.primerApellido,
    required this.segundoApellido,
    required this.genero,
    required this.ci,
    required this.ciExp,
    required this.fechaNacimiento,
    required this.celular,
    required this.telefono,
    required this.direccion,
    required this.correo,
    required this.activo,
    required this.eliminado,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String nombres;
  final String? primerApellido;
  final String? segundoApellido;
  final String? genero;
  final String? ci;
  final String? ciExp;
  final DateTime? fechaNacimiento;
  final String? celular;
  final String? telefono;
  final String? direccion;
  final String? correo;
  final int activo;
  final int eliminado;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        id: json["id"],
        nombres: json["nombres"],
        primerApellido: json["primer_apellido"],
        segundoApellido: json["segundo_apellido"],
        genero: json["genero"],
        ci: json["ci"],
        ciExp: json["ci_exp"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        celular: json["celular"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        correo: json["correo"],
        activo: json["activo"],
        eliminado: json["eliminado"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombres": nombres,
        "primer_apellido": primerApellido,
        "segundo_apellido": segundoApellido,
        "genero": genero,
        "ci": ci,
        "ci_exp": ciExp,
        "fecha_nacimiento":
            "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
        "celular": celular,
        "telefono": telefono,
        "direccion": direccion == null ? null : direccion,
        "correo": correo,
        "activo": activo,
        "eliminado": eliminado,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
