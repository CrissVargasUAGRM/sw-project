import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';

class DetallesScreen extends StatefulWidget {
  static const routeName = '/detalles-screen';

  @override
  _DetallesScreenState createState() => _DetallesScreenState();
}

class _DetallesScreenState extends State<DetallesScreen> {
  final prefs = new PreferenciasUsuario();
  List data = [];
  bool estado = false;

  getTemperatura() async {
    var url =
        Uri.parse('https://project-sw1.herokuapp.com/api/getTemperatures');
    var response =
        await http.post(url, body: {'username': '${prefs.userName}'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        estado = true;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('No Responde la Base de Datos'),
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
  }

  String fecha(String fecha) {
    List lista = fecha.split('T');
    print(lista);
    return lista[0];
  }

  String hora(String fecha) {
    List lista = fecha.split('T');
    String hora = lista[1];
    List listahora = hora.split('.');
    return listahora[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTemperatura();
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = DetallesScreen.routeName;
    return Scaffold(
        appBar: AppBar(
          title: Text('Historial de Temperaturas'),
        ),
        resizeToAvoidBottomInset: false,
        drawer: MenuWidget(),
        body: !estado
            ? ListTile(
                title: Text(
                  "Cargando datos",
                  textAlign: TextAlign.center,
                ),
              )
            : (data.length == 0)
                ? ListTile(
                    title: Text("Aun no hay datos guardados"),
                  )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        title: Text("Temperatura ${data[index]['valor']} C"),
                        subtitle: Text("Hora: ${hora(data[index]['fecha'])}"),
                        trailing: Text("${fecha(data[index]['fecha'])}"),
                        leading: Icon(
                          Icons.thermostat,
                          color: grado(data[index]['valor']),
                        ),
                      );
                    },
                  ));
  }
}

grado(data) {
  if (data >= 37) {
    return Colors.red;
  } else {
    return Colors.blue;
  }
}
