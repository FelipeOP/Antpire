import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestorePage extends StatelessWidget {
  RestorePage({Key? key}) : super(key: key);
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const CircleAvatar(
                  radius: 130.0,
                  backgroundImage: AssetImage('images/home.jpeg'),
                  backgroundColor: Colors.white,
                ),
                Text("¿Se te perdió algo?",
                    style: GoogleFonts.josefinSans(
                        textStyle: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: "Correo electrónico",
                        labelText: "Correo",
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
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                    child: const Text("Recuperar Contraseña"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text.trim();
                        _authController.resetPassword(email);
                      }
                    }),
              ]),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          mini: true,
          child: const Icon(Icons.arrow_back),
          backgroundColor: Colors.red[800],
          focusColor: Colors.red[800],
          autofocus: true,
          onPressed: () {
            Get.to(() => const LoginPage());
          },
        ));
  }
}
