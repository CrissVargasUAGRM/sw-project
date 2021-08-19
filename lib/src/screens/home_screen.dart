import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';
import 'detalles_screen.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final dref = FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;

  bool medirTemperatura = false;

  final prefs = new PreferenciasUsuario();

  showData() async {
    if (medirTemperatura) {
      DataSnapshot snapshot = await dref.once();
      double tm = snapshot.value["temperature"];
      print(tm);
      int x = tm.round();
      print(x);

      var url = Uri.parse('https://project-sw1.herokuapp.com/api/dataRegister');
      var response = await http
          .post(url, body: {'username': '${prefs.userName}', 'valor': '$x'});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(response.statusCode==200){
        respuesta('Se inserto Corectamente $x C', 'Temperatura');
      }else{
        respuesta('No se inserto', 'Error');
      }

    } else {
      respuesta('Precione Medir Temperatura para tomar datos', 'Alerta');
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
    super.initState();
    databaseReference = dref;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Temperatura'),
      ),
      drawer: MenuWidget(),
      body: Container(
        
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FirebaseAnimatedList(
                shrinkWrap: true,
                query: databaseReference,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation animation, int index) {
                  double x = snapshot.value;
                  if (x > 100 || !medirTemperatura) {
                    x = 0;
                  }
                  return CircularPercentIndicator(
                    radius: 235.0,
                    lineWidth: 20.0,
                    animation: true,
                    animationDuration: 1000,
                    percent: x / 100,
                    animateFromLastPercent: true,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${x.toStringAsFixed(3)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.0),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'C',
                          style: TextStyle(fontSize: 20.0),
                        )
                      ],
                    ),
                    footer: Text(
                      "Temperatura",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.purple,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent),
                    onPressed: () => medirTemperatura = !medirTemperatura,
                    child: Text('Medir Temperatura',
                        style: TextStyle(fontSize: 23, color: Colors.white))),
              
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: showData,
                child: Text(
                  'Registrar',
                  style: TextStyle(fontSize: 23, color: Colors.white),
                )),
            // Center(
            //   child: TextButton(
            //     child: Text(
            //       'Ir a detalles',
            //       style: TextStyle(fontSize: 23),
            //     ),
            //     onPressed: () {
            //       Navigator.pushReplacementNamed(
            //           context, DetallesScreen.routeName);
            //     },
            //   ),
            // )
            TextButton(
                child: Text(
                  'Ir a detalles',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, DetallesScreen.routeName);
                },
              ),
          ],
        ),
      ),
    );
  }
}
