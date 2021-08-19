import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sw1/src/screens/menu_screen.dart';
import 'package:http/http.dart' as http;
import 'package:sw1/src/screens/principal_screen.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final prefs = new PreferenciasUsuario();

  final usuario = TextEditingController();
  final password = TextEditingController();

  String use = '';
  String pass = '';

  void validarDatos(context) async {
    use = usuario.text;
    pass = password.text;
    print(use);
    print(pass);
    var url = Uri.parse('https://project-sw1.herokuapp.com/api/singin');
    var response =
        await http.post(url, body: {'username': "$use", 'password': "$pass"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      Map user = json.decode(response.body);
      user = user["user"];
      print(user);
      prefs.userName = user["username"];
      prefs.nombreCompleto = user["name"];
      prefs.email = user["email"];
      prefs.ci = user["ci"];
      prefs.rol = user["rol"];
      Navigator.pushReplacementNamed(context, MenuScreen.routeName);
      print(prefs.ci);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alerta'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('El correo o contraseña es incorrecta'),
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
  Widget build(BuildContext context) {
    prefs.ultimaPagina = LoginScreen.routeName;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text('Login'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(context, PrincipalScreen.routeName);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 90,
            ),
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                    image: AssetImage('assets/images/login.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: usuario,
              style: TextStyle(fontSize: 18, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nombre Usuario',
                contentPadding: const EdgeInsets.all(15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              obscureText: true,
              style: TextStyle(fontSize: 18, color: Colors.black54),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Contraseña',
                contentPadding: const EdgeInsets.all(15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            FlatButton(
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(15),
              textColor: Colors.white,
              onPressed: () {
                validarDatos(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => MenuScreen(),
                //     ));
              },
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
