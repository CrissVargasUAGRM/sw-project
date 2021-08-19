import 'package:flutter/material.dart';
import 'package:sw1/src/screens/principal_screen.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';

import 'menu_screen.dart';

class PerfilScreen extends StatefulWidget {
  static const routeName = '/perfil-screen';

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = PerfilScreen.routeName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
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
                "INFORMACION DEL USUARIO",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/perfil.png'),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                title: Text('${prefs.nombreCompleto}'),
                subtitle: Text('Nombre Completo'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                title: Text('${prefs.email}'),
                subtitle: Text('correo'),
                leading: Icon(Icons.email),
              ),
              ListTile(
                title: Text('${prefs.userName}'),
                subtitle: Text('Username'),
                leading: Icon(Icons.verified),
              ),
              ListTile(
                title: Text('${prefs.rol}'),
                subtitle: Text('Rol'),
                leading: Icon(Icons.category),
              ),
              ListTile(
                title: Text('${prefs.ci}'),
                subtitle: Text('Carnet'),
                leading: Icon(Icons.badge),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MenuScreen.routeName);
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "VOLVER",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
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
}
