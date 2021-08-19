import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sw1/src/Doctor/detalles_doctor.dart';
import 'package:sw1/src/screens/menu_screen.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';
import 'package:http/http.dart' as http;

class DoctorScreen extends StatefulWidget {
  static const routeName = '/doctor-screen';

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final prefs = new PreferenciasUsuario();
  bool showPassword = false;
  List items = [];
  String? value;
  int? idClinica;

  final name = TextEditingController();
  final matricula = TextEditingController();
  final especialidad = TextEditingController();
  final telefono = TextEditingController();

  getClinicas() async {
    var url = Uri.parse('https://project-sw1.herokuapp.com/api/getClinics');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      items = json.decode(response.body);
    });
  }

  void guardarDatos() async {
    if (idClinica == null || name.text=='' || matricula.text == '' || especialidad.text=='' || telefono.text=='') {
      respuesta('llene los datos en los campos', 'Alerta');
    } else {
      var url =
          Uri.parse('https://project-sw1.herokuapp.com/api/registerDoctor');
      var response = await http.post(url, body: {
        'nombre': '${name.text}',
        "matricula": "${matricula.text}",
        "especialidad": "${especialidad.text}",
        "idclinic": "${idClinica}",
        "telefono": "${telefono.text}"
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('exisitosamente');
        respuesta('Se inserto Corectamente el doctor ${name.text}', 'Doctor');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClinicas();
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = DoctorScreen.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Doctor'),
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
                "Agregar Doctor",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Nombre del Doctor",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.person_add),
                      onPressed: null,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: matricula,
                decoration: InputDecoration(
                    labelText: "Matricula",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.confirmation_number),
                      onPressed: null,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: especialidad,
                decoration: InputDecoration(
                    labelText: "Especialidad",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_box),
                      onPressed: null,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              // TextField(
              //   controller: idClinica,
              //   decoration: InputDecoration(
              //       labelText: "Id Clinica",
              //       border: OutlineInputBorder(),
              //       suffixIcon: IconButton(
              //         icon: Icon(Icons.add_location),
              //         onPressed: null,
              //       )),
              //       keyboardType: TextInputType.number,
              // ),
              DropdownButton<String>(
                hint: Text("id clinica"),
                value: value,
                iconSize: 36,
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                isExpanded: true,
                items: items.map(buildMenuItem).toList(),
                onChanged: (value) {
                  items.forEach((element) {
                    if (element["nombre"] == value) {
                      idClinica = element['idclinic'];
                    }
                  });
                  print(idClinica);
                  setState(() {
                    this.value = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: telefono,
                decoration: InputDecoration(
                    labelText: "Telefono",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.call),
                      onPressed: null,
                    )),
                keyboardType: TextInputType.phone,
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
                          context, DetallesDoctor.routeName);
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
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(item) => DropdownMenuItem(
        value: item["nombre"],
        child: Text(
          item["nombre"],
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        ),
      );
}
