import 'package:flutter/material.dart';
import 'package:sw1/src/Clinica/detalles_clinica.dart';
import 'package:sw1/src/screens/menu_screen.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';

import 'package:http/http.dart' as http;

class ClinicaScreen extends StatefulWidget {
  static const routeName = '/clinica-screen';

  @override
  _ClinicaScreenState createState() => _ClinicaScreenState();
}

class _ClinicaScreenState extends State<ClinicaScreen> {
  final prefs = new PreferenciasUsuario();

  final name = TextEditingController();
  final direccion = TextEditingController();

  void guardarDatos() async {
    if (name.text == '' || direccion.text == '') {
      respuesta('llene los datos en los campos', 'Alerta');
    } else {
      var url =
          Uri.parse('https://project-sw1.herokuapp.com/api/registerClinic');
      var response = await http.post(url,
          body: {'nombre': '${name.text}', "direccion": "${direccion.text}"});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        name.clear();
        direccion.clear();
        print('exisitosamente');
        respuesta('Se inserto Corectamente la clinica ${name.text}', 'Clinica');
      } else {
        print('no se inserto');
        respuesta('No se inserto', 'Error');
      }
    }
  }

  respuesta(mensaje, alerta) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$alerta'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('${mensaje}'),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = ClinicaScreen.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Clinica'),
      ),
      drawer: MenuWidget(),
      backgroundColor: Color(0xffeceff1),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Agregar Clinica",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Nombre de la Clinica",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.house),
                      onPressed: null,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: direccion,
                decoration: InputDecoration(
                    labelText: "Direccion",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.location_city),
                      onPressed: null,
                    )),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      guardarDatos();
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "GUARDAR",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, DetallesClinica.routeName);
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "MOSTRAR",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
