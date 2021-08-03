import 'package:flutter/material.dart';
import 'package:rrhh/models/empleados.dart';
import 'services/empleados_service .dart';

// ignore: use_key_in_widget_constructors
class ListadoEmpleados extends StatefulWidget {
  static const String route = 'home';

  _ListadoEmpleadosState createState() => _ListadoEmpleadosState();
}

class _ListadoEmpleadosState extends State<ListadoEmpleados> {
  @override
  void didUpdateWidget(ListadoEmpleados oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de empleados'),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/loginpage');
            },
            child: const Text(
              'log out ',
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Empleado>>(
        future: EmpleadosService().getEmpleados(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Empleado>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Empleado item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (DismissDirection direction) {
                    // ClientDatabaseProvider.db.deleteClientWithId(item.id);
                  },
                  child: ListTile(
                    title: Text(item.cargo),
                    subtitle: Text(item.usuario),
                    leading: CircleAvatar(
                      child: Text(item.id.toString()),
                    ),
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => AddEditClientPage(
                      //       true,
                      //       client: item,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context).pushNamed(AddEditClientPage.route);
        },
      ),
    );
  }
}
