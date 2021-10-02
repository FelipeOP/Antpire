import 'package:antpire/src/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _password = '';
  late String _password2 = '';
  late FocusNode _focusNode;
  static final RegExp _lettersExp = RegExp(r'^[a-zA-Z]+$');
  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Divider(),
                const Divider(),
                _textTitle(),
                const Divider(),
                _antpireLogo(),
                const Divider(),
                _inputName(),
                const Divider(),
                _inputLastName(),
                const Divider(),
                _age(),
                const Divider(),
                _email(),
                const Divider(),
                _inputPassword(),
                const Divider(),
                _validatePassword(),
                const Divider(),
                _continueButton()
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

  Widget _inputName() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese su(s) nombre(s)',
          labelText: 'Nombre: ',
          //helperText: '',
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
            return 'El campo no puede estar vacío';
          }
          return _lettersExp.hasMatch(name.toString())
              ? null
              : "Solo debe contener letras";
        });
  }

  Widget _inputLastName() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Ingrese su(s) apellido(s)',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Apellidos: ',
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
            return 'El campo no puede estar vacío';
          }
          return _lettersExp.hasMatch(surnames.toString())
              ? null
              : "Solo debe contener letras";
        });
  }

  Widget _age() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 18, color: Colors.red),
        decoration: const InputDecoration(
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
        validator: (String? age) {
          if (age.toString().isEmpty) {
            return "El campo no puede estar vacío";
          }
          if (_numbersExp.hasMatch(age.toString())) {
            int newAge = int.parse(age.toString());
            if (!((newAge > 18) && (newAge < 100))) {
              return "Digite una edad valida";
            }
          } else {
            return "Solo debe contener numeros";
          }
        });
  }

  Widget _email() {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'user@example.com',
          labelStyle: TextStyle(color: Colors.grey),
          labelText: 'Email: ',
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
            return 'El campo no puede estar vacío';
          }
          return EmailValidator.validate(email.toString())
              ? null
              : "Ingrese un e-mail válido";
        });
  }

  Widget _inputPassword() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      obscureText: true,
      decoration: const InputDecoration(
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
      validator: (String? password) {
        return password.toString().isEmpty
            ? "El campo no puede estar vacío."
            : null;
      },
      onChanged: (password) {
        setState(() {
          _password2 = password;
        });
      },
    );
  }

  Widget _validatePassword() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      obscureText: true,
      decoration: const InputDecoration(
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
      validator: (String? password) {
        if (password.toString().isEmpty) {
          return 'El campo no puede estar vacío';
        }
        return verifyPassword() ? null : "Las contraseñas deben coincidir";
      },
      onChanged: (password) {
        setState(() {
          _password = password;
        });
      },
    );
  }

  bool verifyPassword() {
    return _password.compareTo(_password2) == 0;
  }

  Widget _continueButton() {
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
        child: const Text('Continuar'),
      ),
    );
  }

  Widget _antpireLogo() {
    return const CircleAvatar(
      radius: 122.0,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: 120.0,
        backgroundImage: AssetImage('images/icon.png'),
        backgroundColor: Colors.white,
      ),
    );
  }
}
