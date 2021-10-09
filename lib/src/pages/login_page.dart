import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/home.dart';
import 'package:antpire/src/pages/restore_page.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loginImage(),
                    _loginText(),
                    _emailField(),
                    _passwordField(),
                    _signInButton(),
                    _signInButtonGoogle(),
                    _restoreButton(),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: FloatingActionButton(
            mini: true,
            child: const Icon(Icons.arrow_back),
            backgroundColor: Colors.red[800],
            focusColor: Colors.red[800],
            autofocus: true,
            onPressed: () {
              Get.to(() => const StartPage());
            },
          )),
    );
  }

  TextButton _restoreButton() {
    return TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 10, color: Colors.black),
        ),
        onPressed: () {
          Get.to(() => RestorePage());
        },
        child: const Text(
          'Olvidaste tu contraseña?',
          style: TextStyle(color: Colors.blue),
        ));
  }

  CircleAvatar _loginImage() {
    return const CircleAvatar(
      radius: 100.0,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 98.0,
        backgroundImage: AssetImage('images/icon.png'),
        backgroundColor: Colors.white,
      ),
    );
  }

  Text _loginText() {
    return const Text(
      'Bienvenido!',
      style: TextStyle(
          fontSize: 40.0,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold),
    );
  }

  Padding _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: TextFormField(
          controller: _emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(15),
            labelStyle: TextStyle(color: Colors.grey),
            hintText: 'Correo electrónico',
            labelText: 'Correo',
            suffixIcon: Icon(Icons.mail, color: Colors.red),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusColor: Colors.red,
            fillColor: Colors.grey,
            hoverColor: Colors.grey,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
          validator: (String? email) {
            if (email.toString().isEmpty) {
              return 'El campo no puede estar vacío';
            }
            return EmailValidator.validate(email.toString())
                ? null
                : "Ingrese un e-mail válido";
          }),
    );
  }

  Padding _passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        controller: _passwordController,
        enableInteractiveSelection: true,
        obscureText: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          labelStyle: TextStyle(color: Colors.grey),
          hintText: 'Constraseña',
          labelText: 'Constraseña',
          suffixIcon: Icon(Icons.lock, color: Colors.red),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusColor: Colors.red,
          fillColor: Colors.red,
          hoverColor: Colors.red,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }

  Padding _signInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
        ),
        child:
            const Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String email = _emailController.text.trim();
            String password = _passwordController.text;

            _authController.signIn(email, password);
          }
        },
      ),
    );
  }

  SignInButton _signInButtonGoogle() {
    return SignInButton(
      btnText: 'Iniciar sesión con Google',
      width: 215,
      // buttonSize: ButtonSize.large,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(width: 1, color: Colors.black)),
      buttonType: ButtonType.google,
      onPressed: () {
        _authController.signInWithGoogle();
      },
    );
  }
}
