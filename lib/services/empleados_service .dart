import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:rrhh/models/empleados.dart';

class EmpleadosService {
  Future<List<Empleado>>? getEmpleados() async {
    final url = 'https://getdataproject.com/rrhh/public/api/empleados';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final empleadosResponse = empleadosFromMap(response.body);
      return empleadosResponse.empleados;
    }
    return [];
  }
}
