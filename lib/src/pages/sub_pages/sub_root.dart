import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/sub_pages/account/user_account.dart';
import 'package:antpire/src/pages/sub_pages/home/home.dart';
import 'package:antpire/src/pages/sub_pages/expenses/register_expenses_page.dart';
import 'package:antpire/src/pages/sub_pages/notifications/notification.dart';
import 'package:antpire/src/pages/sub_pages/reports/spending_page.dart';
import 'package:flutter/material.dart';

class SubRoot extends StatefulWidget {
  const SubRoot({Key? key}) : super(key: key);

  @override
  _SubRootState createState() => _SubRootState();
}

class _SubRootState extends State<SubRoot> {
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
    RegisterExpensesPage(),
    SpendingPage(),
    Home(),
    Text('Hola'),
    UserAccount()
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      final Notifications deiber = Notifications();
      deiber.init();
      deiber.showNotification().whenComplete(() => print("ok"));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              toolbarHeight: 50,
              title: _titles.elementAt(_selectedIndex),
              backgroundColor: Colors.red[400],
              centerTitle: true,
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.local_atm_rounded),
                  backgroundColor: Colors.red[400],
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.assessment),
                  backgroundColor: Colors.red[400],
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  backgroundColor: Colors.red[400],
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.notifications),
                  backgroundColor: Colors.red[400],
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_circle),
                  backgroundColor: Colors.red[400],
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              // fixedColor: Colors.black,
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,
            )),
      ),
    );
  }
}
