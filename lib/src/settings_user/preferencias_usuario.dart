import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

    // GET y SET del user Name
  String get userName {
    return _prefs.getString('username') ?? 'You';
  }

  set userName(String value) {
    _prefs.setString('username', value);
  }

  // GET y SET del nombreUsuario
  String get nombreCompleto {
    return _prefs.getString('nombreCompleto') ?? 'You';
  }

  set nombreCompleto(String value) {
    _prefs.setString('nombreCompleto', value);
  }

  // GET y SET de la última página
  String get email{
    return _prefs.getString('email') ?? 'example.com';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  int get ci{
    return _prefs.getInt('ci') ?? 0;
  }

  set ci(int value) {
    _prefs.setInt('ci', value);
  }

  String get rol{
    return _prefs.getString('rol') ?? 'Cliente';
  }

  set rol(String value) {
    _prefs.setString('rol', value);
  }

  //************************************** */
  // AUDIO SETTINGS
  double get volume {
    return _prefs.getDouble('volume') ?? 1;
  }

  set volume(double value) {
    _prefs.setDouble('volume', value);
  }

  double get rate {
    return _prefs.getDouble('rate') ?? 1.0;
  }

  set rate(double value) {
    _prefs.setDouble('rate', value);
  }
  double get pitch {
    return _prefs.getDouble('pitch') ?? 1.0;
  }

  set pitch(double value) {
    _prefs.setDouble('pitch', value);
  }

    // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? '/principal-screen';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}
