import 'package:antpire/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = Get.put(LoginController());
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (context) {
              return ListView(
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
                        style:
                            TextStyle(fontSize: 30.0, fontFamily: 'NotoSans'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        child: TextFormField(
                          controller: _loginController.emailController,
                          // key: _loginController.formKey,
                          enableInteractiveSelection: true,
                          decoration: const InputDecoration(
                            hintText: 'Correo electrónico',
                            labelText: 'Correo',
                            suffixIcon: Icon(Icons.mail, color: Colors.red),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: TextFormField(
                          controller: _loginController.passwordController,
                          enableInteractiveSelection: true,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Constraseña',
                            labelText: 'Constraseña',
                            suffixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusColor: Colors.red,
                            fillColor: Colors.red,
                            hoverColor: Colors.red,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                            )),
                          ),
                          child: const Text('Iniciar sesión'),
                          onPressed: () {
                            context.signInWithEmailAndPassword();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: TextButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  width: 1, color: Colors.black),
                            )),
                          ),
                          label: const Text('Continuar con Google'),
                          icon: const Icon(Icons.account_circle),
                          onPressed: () {
                            context.signInWithGoogle();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
