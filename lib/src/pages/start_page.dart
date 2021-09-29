import 'package:antpire/src/pages/login_page.dart';
import 'package:antpire/src/pages/register_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  static String id = 'start_page';
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  HomeLogo(),
                  HomeTitle(),
                  // SizedBox(
                  //   width: 550.0,
                  //   height: 50.0,
                  //   child: Divider(color: Colors.black),
                  // ),
                  SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: Divider(
                        color: Colors.white,
                      )),
                  TextAntpire(),
                  Divider(
                    height: 60.0,
                  ),
                  StartButton(),
                  // SizedBox(
                  //   width: 5,
                  //   height: 5,
                  //   child: Divider(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  LoginButton()
                ])
          ]),
    );
  }
}

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Antpire',
      style:
          TextStyle(fontSize: 50.0, fontFamily: 'NotoSans', color: Colors.red),
    );
  }
}

class HomeLogo extends StatelessWidget {
  const HomeLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 130.0,
      backgroundImage: AssetImage('images/home.jpeg'),
      backgroundColor: Colors.black,
    );
  }
}

class TextAntpire extends StatelessWidget {
  const TextAntpire({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '¡Queremos ayudarte con tus finanzas personales!',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 16.0, fontFamily: 'NotoSans', color: Colors.black),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
        ),
        onPressed: () {
          final route =
              MaterialPageRoute(builder: (context) => const RegisterPage());
          Navigator.push(context, route);
        },
        child: const Text('Comienza ahora',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12, color: Colors.black),
      ),
      onPressed: () {
        final route =
            MaterialPageRoute(builder: (context) => const LoginPage());
        Navigator.push(context, route);
      },
      child: const Text('Ya tengo una cuenta',
          style: TextStyle(
            color: Colors.black,
          )),
    );
  }
}
