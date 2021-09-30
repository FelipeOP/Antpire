import 'package:antpire/src/pages/start_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late String _email;
  // late String _password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    radius: 100.0,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 98.0,
                      backgroundImage: AssetImage('images/icon.png'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const Text(
                    'Bienvenido!',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: TextFormField(
                      // controller: _loginController.emailController,
                      // key: _loginController.formKey,
                      enableInteractiveSelection: true,

                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: 'Correo electrónico',
                        labelText: 'Correo',
                        suffixIcon: Icon(Icons.mail, color: Colors.red),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusColor: Colors.red,
                        fillColor: Colors.grey,
                        hoverColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: TextFormField(
                      // controller: _loginController.passwordController,
                      enableInteractiveSelection: true,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: 'Constraseña',
                        labelText: 'Constraseña',
                        suffixIcon: Icon(Icons.lock, color: Colors.red),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusColor: Colors.red,
                        fillColor: Colors.red,
                        hoverColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 1, color: Colors.black),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.red.shade800),
                      ),
                      child: const Text('Iniciar sesión',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        // context.signInWithEmailAndPassword();
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: TextButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 1, color: Colors.black),
                        )),
                      ),
                      label: const Text('Continuar con Google',
                          style: TextStyle(color: Colors.red)),
                      icon: const Icon(Icons.account_circle, color: Colors.red),
                      onPressed: () {
                        // context.signInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.arrow_back),
            backgroundColor: Colors.red[800],
            focusColor: Colors.red[800],
            autofocus: true,
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => const StartPage());
              Navigator.push(context, route);
            },
          )),
    );
  }
}
