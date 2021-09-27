import 'package:antpire/src/pages/login_page.dart';
import 'package:antpire/src/pages/register_page.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antpire',
      debugShowCheckedModeBanner: false,
      home: const StartPage(),
      initialRoute: LoginPage.id,
      routes: <String, WidgetBuilder>{
        'Home': (BuildContext context) => const StartPage(),
        'LoginPage': (BuildContext context) => const LoginPage(),
        'RegisterPage': (BuildContext context) => const RegisterPage()
      },
    );
  }
}
