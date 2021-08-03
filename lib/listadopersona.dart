import 'package:flutter/material.dart';
import 'package:rrhh/listadoempleado.dart';
import 'package:rrhh/models/personas.dart';
import 'package:rrhh/services/personas_service.dart';

// ignore: use_key_in_widget_constructors
class ListadoPersonas extends StatefulWidget {
  static const String route = 'home';

  @override
  _ListadoPersonasState createState() => _ListadoPersonasState();
}

class _ListadoPersonasState extends State<ListadoPersonas> {
  @override
  void didUpdateWidget(ListadoPersonas oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de personas'),
        actions: <Widget>[
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListadoEmpleados()),
                );
              },
              child: Text("Ver Empleado")),
        ],
      ),
      body: FutureBuilder<List<Persona>>(
        future: PersonasService().getPersonas(),
        builder: (BuildContext context, AsyncSnapshot<List<Persona>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Persona item = snapshot.data![index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (DismissDirection direction) {
                    // ClientDatabaseProvider.db.deleteClientWithId(item.id);
                  },
                  child: ListTile(
                    title: Text(item.nombres),
                    subtitle: Text(item.celular!),
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
