import 'dart:convert';

import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2/context.pb.dart';
import 'package:flutter/material.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:sw1/src/widget/menu_widget.dart';

class DetallesDoctor extends StatefulWidget {
  static const routeName = '/detalle-doctor';
  @override
  _DetallesDoctorState createState() => _DetallesDoctorState();
}

class _DetallesDoctorState extends State<DetallesDoctor> {
  final prefs = new PreferenciasUsuario();
  bool estado = false;
  List data = [];
  getClinica() async {
    var url = Uri.parse('https://project-sw1.herokuapp.com/api/doctors');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode==200){
      setState(() {
      data = json.decode(response.body);
      estado = true;
    });
    }else{
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClinica();
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = DetallesDoctor.routeName;
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctores'),
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
                : 
                // Column(
                //     children: [
                      // Text(
                      //   "Listado Doctores",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 25, fontWeight: FontWeight.w500),
                      // ),
                      // SizedBox(
                      //   height: 25,
                      // ),
                      ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                            title: Text("${data[index]['nombre']}"),
                            subtitle: Text('${data[index]['especialidad']}'),
                            trailing: Text('${data[index]['matricula']}'),
                            leading: Icon( Icons.person,size: 34.0),
                          );
                        },
                      ),
                  //   ],
                  // )
                  );
  }
}
