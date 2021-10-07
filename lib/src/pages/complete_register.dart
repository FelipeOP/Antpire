import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteRegisterPage extends StatefulWidget {
  const CompleteRegisterPage({Key? key}) : super(key: key);

  @override
  _CompleteRegisterPageState createState() => _CompleteRegisterPageState();
}

class _CompleteRegisterPageState extends State<CompleteRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Divider(
                  color: Colors.white,
                ),
                _textTitle(),
                const Divider(
                  color: Colors.white,
                ),
                _antpireLogo(),
                const Divider(
                  color: Colors.white,
                ),
                _fullName(),
                const Divider(),
                const Divider(),
                _salary(),
                const Divider(),
                _saveButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textTitle() {
    return const Text(
      'Cuenta',
      style: TextStyle(
          fontSize: 45.0,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold),
    );
  }

  Widget _fullName() {
    return Text(
      "Nombre:  ${_authController.displayName.toString()}",
    );
  }

  Widget _salary() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese su edad',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Edad: ',
          suffixIcon: Icon(Icons.pin, color: Colors.red),
          focusColor: Colors.red,
          fillColor: Colors.grey,
          hoverColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        cursorColor: Colors.grey,
        validator: (String? salary) {
          if (salary.toString().isEmpty) {
            return "El campo no puede estar vacío";
          }
          if (_numbersExp.hasMatch(salary.toString())) {
            int finalSalary = int.parse(salary.toString());
            if (!((finalSalary >= 0))) {
              return "Ingrese un sueldo válido";
            }
          } else {
            return "Solo debe contener numeros";
          }
        });
  }

  Widget _saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
        ),
        onPressed: () {},
        child: const Text('Guardar'),
      ),
    );
  }

  Widget _antpireLogo() {
    return const CircleAvatar(
      radius: 120.0,
      backgroundImage: AssetImage('images/icon.png'),
      backgroundColor: Colors.white,
    );
  }
}
