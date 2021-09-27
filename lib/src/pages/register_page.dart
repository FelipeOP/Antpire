import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register_page';
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: Text('Register Page')));
  }
}
