import 'package:antpire/config.dart';
import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/authentication/restore_page.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Config().init(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (!Config.isKeyboardOn!) _loginImage(),
                  _loginText(),
                  Column(
                    children: [
                      _emailField(),
                      _passwordField(),
                      _signInButton(),
                    ],
                  ),
                  _signInButtonGoogle(),
                  _restoreButton(),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: FloatingActionButton(
              mini: true,
              child: const Icon(Icons.arrow_back),
              backgroundColor: Colors.red[800],
              focusColor: Colors.red[800],
              autofocus: true,
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.to(() => const StartPage());
              },
            )),
      ),
    );
  }

  Widget _loginImage() {
    return Image(
      image: const AssetImage('images/login.png'),
      width: Config.screenWidth! * 0.75,
      height: Config.screenHeight! * 0.38,
    );
  }

  Text _loginText() {
    return const Text(
      'Bienvenido',
      style: TextStyle(
          fontSize: 40.0,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold),
    );
  }

  Padding _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextFormField(
          controller: _emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextFormField(
          controller: _passwordController,
          enableInteractiveSelection: true,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
          validator: (String? password) {
            if (password.toString().isEmpty) {
              return 'El campo no puede estar vacío';
            }
          }),
    );
  }

  Padding _signInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12.5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
        ),
        child: const Text('Iniciar sesión',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
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
      btnText: 'Continuar con Google',
      buttonSize: ButtonSize.medium,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(width: 1, color: Colors.black)),
      buttonType: ButtonType.google,
      onPressed: () {
        try {
          _authController.signInWithGoogle();
        } catch (e) {
          _authController.getErrorMessage(e);
        }
      },
    );
  }

  TextButton _restoreButton() {
    return TextButton(
        style: TextButton.styleFrom(
          textStyle: GoogleFonts.josefinSans(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Get.to(() => RestorePage());
        },
        child: const Text(
          'Olvidaste tu contraseña?',
          style: TextStyle(color: Colors.blue),
        ));
  }
}
