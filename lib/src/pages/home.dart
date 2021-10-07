import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/user_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _titles = <Widget>[
    Text(
      'Gastos',
      style: optionStyle,
    ),
    Text(
      'Reportes',
      style: optionStyle,
    ),
    Text(
      'Inicio',
      style: optionStyle,
    ),
    Text(
      'Notificaciones',
      style: optionStyle,
    ),
    Text(
      'Cuenta',
      style: optionStyle,
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Gastos',
      style: optionStyle,
    ),
    Text(
      'Reportes',
      style: optionStyle,
    ),
    Text(
      'Inicio',
      style: optionStyle,
    ),
    Text(
      'Notificaciones',
      style: optionStyle,
    ),
    UserAccount()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: _titles.elementAt(_selectedIndex),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: GetBuilder<AuthController>(
          builder: (_authController) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _widgetOptions.elementAt(_selectedIndex),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_atm_rounded),
            backgroundColor: Colors.red[400],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            backgroundColor: Colors.red[500],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.red,
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            backgroundColor: Colors.red[500],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            backgroundColor: Colors.red[400],
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        // fixedColor: Colors.black,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
