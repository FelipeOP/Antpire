import 'package:antpire/config.dart';
import 'package:antpire/src/pages/login_page.dart';
import 'package:antpire/src/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _homeLogo(),
        _homeTitle(),
        SizedBox(
            height: 60.0,
            width: Config.screenWidth! * 0.90,
            child: const Divider(
              color: Colors.black,
            )),
        _textHome(),
        const Divider(height: 30.0, color: Colors.transparent),
        _startButton(),
        _loginButton()
      ]),
    );
  }

  CircleAvatar _homeLogo() {
    return CircleAvatar(
      radius: Config.screenHeight! * 0.23,
      backgroundImage: const AssetImage('images/home.jpeg'),
      backgroundColor: Colors.white,
    );
  }

  Text _homeTitle() {
    return const Text(
      'Antpire',
      style: TextStyle(
          fontSize: 50.0,
          fontFamily: 'Josefinsans',
          color: Colors.red,
          fontWeight: FontWeight.bold),
    );
  }

  Text _textHome() {
    return const Text(
      '¡Queremos ayudarte con tus finanzas personales!',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Josefinsans',
          color: Colors.black,
          fontWeight: FontWeight.bold),
    );
  }

  Padding _startButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12.5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
        ),
        onPressed: () {
          Get.to(() => const RegisterPage());
        },
        child: const Text('Comienza ahora',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  TextButton _loginButton() {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      onPressed: () {
        Get.to(() => const LoginPage());
      },
      child: const Text('Ya tengo una cuenta',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
