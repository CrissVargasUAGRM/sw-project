import 'package:flutter/material.dart';
import 'package:sw1/src/chat/home_chat.dart';
import 'package:sw1/src/screens/home_screen.dart';
import 'package:sw1/src/screens/perfil_screen.dart';
import 'package:sw1/src/settings_user/preferencias_usuario.dart';
import 'package:sw1/src/widget/menu_widget.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/menu-screen';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuScreen> {
  final prefs = new PreferenciasUsuario();
  PageController _pageController = PageController();
  //List<Widget> _screens = [HomeScreen(), PerfilScreen()];
  List<Widget> _screens = [HomeScreen(), HomeChat()];

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = MenuScreen.routeName;
    return Scaffold(
      //drawer: MenuWidget(),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.purple : Colors.purple,
              ),
              title: Text(
                'Inicio',
                style: TextStyle(
                  color: _selectedIndex == 0 ? Colors.purple : Colors.purple,
                ),
              ),
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: _selectedIndex == 1 ? Colors.purple : Colors.purple,
              ),
              title: Text(
                'Chat',
                style: TextStyle(
                  color: _selectedIndex == 1 ? Colors.purple : Colors.purple,
                ),
              ),
              backgroundColor: Colors.blueGrey),
        ],
      ),
    );
  }
}
