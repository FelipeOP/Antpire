import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 122.0,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 120.0,
                  backgroundImage: AssetImage('images/icon.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              const Text(
                'Bienvenido!',
                style: TextStyle(fontSize: 40.0, fontFamily: 'JosefinSans'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                child: TextField(
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    hintText: 'Correo electrónico',
                    labelText: 'Correo',
                    suffixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onSubmitted: (email) {
                    _email = email;
                    // ignore: avoid_print
                    print('El correo es $_email');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: TextField(
                  enableInteractiveSelection: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Constraseña',
                    labelText: 'Constraseña',
                    suffixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onSubmitted: (password) {
                    _password = password;
                    // ignore: avoid_print
                    print('El correo es $_password');
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(width: 1, color: Colors.black),
                    )),
                  ),
                  onPressed: () {
                    // ignore: avoid_print
                    print('El correo es $_email');
                    // ignore: avoid_print
                    print('La contraseña es $_password');
                  },
                  child: const Text('Iniciar sesión'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
