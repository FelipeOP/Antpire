import 'package:antpire/config.dart';
import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestorePage extends StatefulWidget {
  RestorePage({Key? key}) : super(key: key);

  @override
  State<RestorePage> createState() => _RestorePageState();
}

class _RestorePageState extends State<RestorePage> {
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  late MainAxisAlignment alignment = MainAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    !Config.isKeyboardOn!
        ? alignment = MainAxisAlignment.center
        : alignment = MainAxisAlignment.spaceAround;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(mainAxisAlignment: alignment, children: <Widget>[
              if (!Config.isKeyboardOn!) _restoreImage(),
              Column(children: <Widget>[
                _restoreText(),
                _emailField(),
                _restoreButton()
              ]),
              const Divider(
                color: Colors.white,
              ),
            ]),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: FloatingActionButton(
              mini: true,
              child: const Icon(Icons.arrow_back),
              backgroundColor: Colors.red[800],
              focusColor: Colors.red[800],
              autofocus: true,
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.to(() => const LoginPage());
              },
            )),
      ),
    );
  }

  ElevatedButton _restoreButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            primary: Colors.red,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                side: BorderSide(width: 1, color: Colors.black))),
        child: const Text(
          "Recuperar Contraseña",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String email = _emailController.text.trim();
            _authController.resetPassword(email);
          }
        });
  }

  Padding _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(15),
            labelStyle: TextStyle(color: Colors.grey),
            hintText: "Correo electrónico",
            labelText: "Correo",
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
          },
        ),
      ),
    );
  }

  Text _restoreText() {
    return Text("¿Se te perdió algo?",
        style: GoogleFonts.josefinSans(
            textStyle:
                const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)));
  }

  Image _restoreImage() {
    return Image(
      image: const AssetImage('images/yo.jpeg'),
      width: Config.screenWidth! * 0.75,
      height: Config.screenHeight! * 0.40,
    );
  }
}
