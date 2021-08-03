import 'package:flutter/material.dart';
import 'package:rrhh/listadoempleado.dart';
import 'package:rrhh/listadopersona.dart';
import 'dart:convert'; //Importamos libreria de dart a json
import 'package:http/http.dart' as http; //Redefino mi libreria

void main() => runApp(LoginApp());
String username = '';

//String username;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Oculta el spam en la pagina
      title: 'RRHH|FLUTTER',
      home: LoginPage(),

      //initialRoute: LoginPage.id,
      routes: <String, WidgetBuilder>{
        //Llamar a otras paginas y definimos sus rutas

        '/loginpage': (BuildContext context) => LoginPage(),
        '/listadopersona': (BuildContext context) => new ListadoPersonas(),
        '/listadoempleado': (BuildContext context) => new ListadoEmpleados(),

        //      LoginPage.id : (context) => LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUserEmp =
      new TextEditingController(); //Dato del user
  TextEditingController controllerPass =
      new TextEditingController(); //PasswordUser

  String mensaje = '';

  void Login() async {
    //Llamada post/request a nuestra api  para autentificar su logeo
    print(controllerUserEmp.text);
    print(controllerPass.text);
    var url =
        Uri.parse('https://getdataproject.com/rrhh/public/api/autentificar');

    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'login': controllerUserEmp.text, 'pass': controllerPass.text}));

    var datauserEmp = json
        .decode(response.body); //La consulta de la api, la almacena en response

    if (datauserEmp['success']) {
      Navigator.pushReplacementNamed(context, '/listadopersona');
      setState(() {
        username = datauserEmp[
            'nombre']; //Asigno el usuario que obtengo de mi response, username declarada.
      });
    } else {
      setState(() {
        mensaje = "Data User Employer doesnt match and isnt safety";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //Centramos el cuerpo

            children: [
              new Text('BIENVENIDO AL SISTEMA DE RRHH!'),
              Flexible(
                //Añadimos el flexible en torno a la imagen, para adaptabilidad y baje acorde al teclado del telefono y se acomode
                child: Image.asset(
                  'assets/images/rh.png',
                  height: 200.0, //Altura de la imagen (propiedades)
                ),
              ),
              SizedBox(
                height: 15.0,
              ), //Separacion espacio
              _usertextfield(),
              SizedBox(
                height: 15,
              ),
              _passwordtextfiled(),
              SizedBox(
                height: 20.0,
              ),
              _bottomLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usertextfield() {
    //Creamos metodos para cada cuadro del login
    return StreamBuilder(
        // ignore: non_constant_identifier_names
        builder: (BuildContext context, AsyncSnapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20.0), //Forma del cuadro para insertar dato
        child: TextFormField(
          controller:
              controllerUserEmp, //Recibira el controlador q recibe el atributo de la tabla despues de hacer la peticion "username"

          decoration: InputDecoration(
            icon: Icon(Icons.email), //Icono
            // hintText: 'ejemplo@correo.com' ,//Texto de fondo del cuadro
            labelText: 'UserName',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _passwordtextfiled() {
    return StreamBuilder(
        // ignore: non_constant_identifier_names
        builder: (BuildContext context, AsyncSnapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20.0), //Forma del cuadro para insertar dato
        child: TextFormField(
          controller:
              controllerPass, //pasamos el campo password de la tabla usuarios obtenida por la api
          obscureText: true,
          decoration: InputDecoration(
            //Va a ser un input
            icon: Icon(Icons.lock), //Icono
            hintText: '***', //Texto de fondo del cuadro
            labelText: 'Put your Password',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _bottomLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      // ignore: deprecated_member_use
      return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Submit'),
          ),
          shape: RoundedRectangleBorder(
              //Para los bordes del buttom sean rectangulos
              borderRadius: BorderRadius.circular(10)),
          elevation: 10.0, //Elevacion tipo sombreado al boton
          color: Colors.lightBlue,
          onPressed: () {
            //Aqui tenemos q llamar a la funcion login
            Login();
          });
    });
  }
}
