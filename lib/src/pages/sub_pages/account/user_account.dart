import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');
  static final RegExp _lettersExp =
      RegExp(r"^[\p{L} ]+$", caseSensitive: false, unicode: true, dotAll: true);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _formUsuario(),
          const Divider(),
          const Divider(),
          _salary(),
          const Divider(),
          _saveButton(),
          TextButton(
            child: const Text('Sign out'),
            onPressed: () => _authController.signout(),
          ),
        ],
      ),
    );
  }

/*   Widget _textTitle() {
    return const Text(
      'Cuenta',
      style: TextStyle(
          fontSize: 45.0,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold),
    );
  } */

  Widget _salary() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese la suma de su sueldo',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Sueldo: ',
          suffixIcon: Icon(Icons.attach_money, color: Colors.red),
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

  Widget _formUsuario() {
    return CupertinoPageScaffold(
      child: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {},
          child: CupertinoFormSection.insetGrouped(
              header: const Text('Datos personles'),
              children: [
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    textAlign: TextAlign.end,
                    initialValue: _authController.auth.currentUser!.displayName,
                    readOnly: true,
                    validator: (String? name) {
                      if (name.toString().isEmpty) {
                        return 'El campo no puede estar vacío';
                      }
                      return _lettersExp.hasMatch(name.toString())
                          ? null
                          : "Solo debe contener letras";
                    },
                  ),
                  prefix: const Text('Nombre: '),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    textAlign: TextAlign.end,
                    initialValue: _authController.auth.currentUser!.email,
                    readOnly: true,
                    validator: (String? name) {
                      if (name.toString().isEmpty) {
                        return 'El campo no puede estar vacío';
                      }
                      return _lettersExp.hasMatch(name.toString())
                          ? null
                          : "Solo debe contener letras";
                    },
                  ),
                  prefix: const Text('Correo'),
                )
              ]),
        ),
      ),
    );
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
