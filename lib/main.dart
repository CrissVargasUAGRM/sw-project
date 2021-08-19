// @dart=2.9
import 'package:flutter/material.dart';
import 'package:sw1/src/Clinica/clinica_screen.dart';
import 'package:sw1/src/Clinica/detalles_clinica.dart';
import 'package:sw1/src/Doctor/detalles_doctor.dart';
import 'package:sw1/src/Doctor/doctor_screen.dart';
import 'package:sw1/src/chat/home_chat.dart';
import 'package:sw1/src/screens/detalles_screen.dart';
import 'package:sw1/src/screens/home_screen.dart';
import 'package:sw1/src/screens/login_screen.dart';
import 'package:sw1/src/screens/menu_screen.dart';
import 'package:sw1/src/screens/perfil_screen.dart';
import 'package:sw1/src/screens/principal_screen.dart';
import 'package:sw1/src/screens/registrarse_screen.dart';
import 'package:sw1/src/settings_user/audio_settings.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: prefs.ultimaPagina,
      routes: {
        DetallesDoctor.routeName:(ctx)=> DetallesDoctor(),
        DetallesClinica.routeName:(ctx)=> DetallesClinica(),
        PrincipalScreen.routeName:(ctx)=> PrincipalScreen(),
        DoctorScreen.routeName:(ctx) => DoctorScreen(),
        ClinicaScreen.routeName:(ctx)=> ClinicaScreen(),
        AudioSettings.routeName: (ctx)=> AudioSettings(),
        HomeChat.routeName: (ctx) => HomeChat(),
        MenuScreen.routeName: (ctx) => MenuScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        DetallesScreen.routeName: (ctx) => DetallesScreen(),
        PerfilScreen.routeName: (ctx) => PerfilScreen(),
        RegistrarseScreen.routeName: (ctx) => RegistrarseScreen(),
      },
    );
  }
}
