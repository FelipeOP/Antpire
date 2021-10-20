import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/models/person.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _surnamesController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _frecuencyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static final RegExp _lettersExp =
      RegExp(r"^[\p{L} ]+$", caseSensitive: false, unicode: true, dotAll: true);
  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');

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
                  _inputName(),
                  const Divider(),
                  _inputLastName(),
                  const Divider(),
                  _age(),
                  const Divider(),
                  _email(),
                  const Divider(),
                  _salary(),
                  const Divider(),
                  _inputPassword(),
                  const Divider(),
                  _validatePassword(),
                  const Divider(),
                  _comboSalary(),
                  const Divider(),
                  _continueButton(),
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
        ));
  }

  Widget _textTitle() {
    return const Text(
      'Bienvenido!',
      style: TextStyle(
          fontSize: 45.0,
          fontFamily: 'JosefinSans',
          fontWeight: FontWeight.bold),
    );
  }

  Widget _antpireLogo() {
    return const CircleAvatar(
      radius: 120.0,
      backgroundImage: AssetImage('images/icon.png'),
      backgroundColor: Colors.white,
    );
  }

  Widget _inputName() {
    return TextFormField(
        controller: _namesController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese su(s) nombre(s)',
          labelText: 'Nombres',
          labelStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(Icons.accessibility, color: Colors.red),
          focusColor: Colors.red,
          fillColor: Colors.grey,
          hoverColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        cursorColor: Colors.grey,
        validator: (String? name) {
          if (name.toString().isEmpty) {
            return 'El campo nombre no puede estar vacío';
          }
          return _lettersExp.hasMatch(name.toString())
              ? null
              : "Solo debe contener letras";
        });
  }

  Widget _inputLastName() {
    return TextFormField(
        controller: _surnamesController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese su(s) apellido(s)',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Apellidos',
          suffixIcon: Icon(Icons.contact_support, color: Colors.red),
          focusColor: Colors.red,
          fillColor: Colors.grey,
          hoverColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        cursorColor: Colors.grey,
        validator: (String? surnames) {
          if (surnames.toString().isEmpty) {
            return 'El campo apellido no puede estar vacío';
          }
          return _lettersExp.hasMatch(surnames.toString())
              ? null
              : "Solo debe contener letras";
        });
  }

  Widget _age() {
    return TextFormField(
        controller: _ageController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        //style: const TextStyle(fontSize: 18, color: Colors.red),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese su edad',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Edad',
          suffixIcon: Icon(Icons.pin, color: Colors.red),
          focusColor: Colors.red,
          fillColor: Colors.grey,
          hoverColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        cursorColor: Colors.grey,
        validator: (String? age) {
          if (age.toString().isEmpty) {
            return "El campo no puede estar vacío";
          }
          if (_numbersExp.hasMatch(age.toString())) {
            int newAge = int.parse(age.toString());
            if (!((newAge >= 18) && (newAge < 100))) {
              return "Digite una edad valida";
            }
          } else {
            return "Solo debe contener numeros";
          }
        });
  }

  Widget _email() {
    return TextFormField(
        controller: _emailController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'user@example.com',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Email ',
          suffixIcon: Icon(Icons.alternate_email, color: Colors.red),
          focusColor: Colors.red,
          fillColor: Colors.grey,
          hoverColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        cursorColor: Colors.grey,
        validator: (String? email) {
          if (email.toString().isEmpty) {
            return 'El campo correo electrónico no puede estar vacío';
          }
          return EmailValidator.validate(email.toString())
              ? null
              : "Ingrese un e-mail válido";
        });
  }

  Widget _salary() {
    return TextFormField(
        controller: _salaryController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese la suma de su sueldo',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Sueldo',
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
            return "El campo salario no puede estar vacío";
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

  Widget _inputPassword() {
    return TextFormField(
      controller: _passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: true,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Más de 8 caracteres',
        labelStyle: TextStyle(color: Colors.grey),
        labelText: 'Contraseña ',
        helperText: 'Incluya letras y numeros',
        suffixIcon: Icon(Icons.lock_outline, color: Colors.red),
        focusColor: Colors.red,
        fillColor: Colors.grey,
        hoverColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      cursorColor: Colors.grey,
      validator: (String? _password) {
        return _password.toString().isEmpty
            ? "El campo contraseña no puede estar vacío."
            : null;
      },
    );
  }

  Widget _validatePassword() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: true,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Confirme su contraseña',
        labelStyle: TextStyle(color: Colors.grey),
        labelText: 'Confirmar Contraseña ',
        helperText: 'Incluya letras y numeros',
        suffixIcon: Icon(Icons.password_outlined, color: Colors.red),
        focusColor: Colors.red,
        fillColor: Colors.grey,
        hoverColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      cursorColor: Colors.grey,
      validator: (String? _password) {
        if (_password.toString().isEmpty) {
          return 'El campo contraseña no puede estar vacío';
        }
        return __verifyPassword(_password!)
            ? null
            : "Las contraseñas deben coincidir";
      },
    );
  }

  bool __verifyPassword(String _password) {
    return _passwordController.text.compareTo(_password) == 0;
  }

  Widget _comboSalary() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      controller: _frecuencyController,
      decoration: InputDecoration(
        labelText: "Frecuencia de pago",
        labelStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(15),
        focusColor: Colors.red,
        fillColor: Colors.grey,
        hoverColor: Colors.grey,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_downward, color: Colors.red),
          iconSize: 24,
          onSelected: (String value) {
            _frecuencyController.text = value;
          },
          itemBuilder: (BuildContext context) {
            return <String>['Semanal', 'Quincenal', 'Mensual']
                .map<PopupMenuItem<String>>((String value) {
              return PopupMenuItem(child: Text(value), value: value);
            }).toList();
          },
        ),
      ),
      validator: (String? frecuency) {
        return frecuency.toString().isEmpty
            ? "El campo no puede estar vacío."
            : null;
      },
    );
  }

  Widget _continueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12.5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.black),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          overlayColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Person _person = __getUserData();
            _authController.signUp(_person);
          }
        },
        child: const Text('Continuar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Person __getUserData() {
    String _names = _namesController.text.trim();
    String _surnames = _surnamesController.text.trim();
    int _age = int.parse(_ageController.text.trim());
    String _email = _emailController.text.trim();
    double _salary = double.parse(_salaryController.text.trim());
    String _password = _passwordController.text.trim();
    String _frecuency = _frecuencyController.text.trim();
    Person person =
        Person(_names, _surnames, _email, _password, _age, _salary, _frecuency);
    return person;
  }
}
