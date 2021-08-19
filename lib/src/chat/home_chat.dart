

import 'package:flutter/material.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';

import 'chat.dart';

class HomeChat extends StatefulWidget {
  static final String routeName = 'chat';
  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomeChat.routeName;
    return Scaffold(
        appBar: AppBar(
          // tomamos el title del padre llamando con el widget
          title: Text('Chat Bot'),
          //backgroundColor: (prefs.genero==1)? Colors.blue:Colors.amber,
        ),
        drawer: MenuWidget(),
        body: Center(
            child: Chat()
        )
    );
  }
}
