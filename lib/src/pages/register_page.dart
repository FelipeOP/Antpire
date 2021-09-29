import 'package:antpire/src/pages/start_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final String _nombre = '';
  late FocusNode _focusNode;

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

  // FocusNode ourFocusNode() {
  //   FocusNode _focusNode;

  // }

  Widget _inputName() {
    return const TextField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Ingrese su(s) nombre(s)',
        labelText: 'Nombre: ',
        suffixIcon: Icon(Icons.accessibility, color: Colors.red),
        icon: Icon(
          Icons.account_circle,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        fillColor: Colors.red,
        hoverColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      cursorColor: Colors.red,
    );
  }

  Widget _inputLastName() {
    return const TextField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Ingrese su(s) apellido(s)',
        labelText: 'Apellidos: ',
        suffixIcon: Icon(Icons.contact_support, color: Colors.red),
        icon: Icon(
          Icons.contact_page_rounded,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        fillColor: Colors.red,
        hoverColor: Colors.red,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      cursorColor: Colors.red,
    );
  }

  Widget _age() {
    return const TextField(
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(fontSize: 18, color: Colors.red),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Ingrese su edad',
        labelText: 'Edad: ',
        helperText: 'Unicamente números',
        suffixIcon: Icon(Icons.calendar_today_sharp, color: Colors.red),
        icon: Icon(
          Icons.pin,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        fillColor: Colors.red,
        hoverColor: Colors.red,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      // cursorColor: Colors.red,
      // validator: (String? age) {
      //   RegExp r = new RegExp(r"^[1-9]$");
      //   // ignore: avoid_print
      //   return r.hasMatch(age.toString()) ? null : 'Solo numeros';
      // }
    );
  }

  Widget _email() {
    return const TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'user@example.com',
        labelText: 'Email: ',
        suffixIcon: Icon(Icons.alternate_email, color: Colors.red),
        icon: Icon(
          Icons.email,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        fillColor: Colors.red,
        hoverColor: Colors.red,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      cursorColor: Colors.red,
    );
  }

  //
  Widget _inputPassword() {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Más de 8 caracteres',
        labelText: 'Contraseña ',
        helperText: 'Incluya letras y numeros',
        suffixIcon: Icon(Icons.lock_outline, color: Colors.red),
        icon: Icon(
          Icons.lock_open_outlined,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        fillColor: Colors.red,
        hoverColor: Colors.red,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      cursorColor: Colors.red,
    );
  }

  Widget _validatePassword() {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        hintText: 'Confirme su contraseña',
        labelText: 'Confirmar Contraseña ',
        helperText: 'Incluya letras y numeros',
        suffixIcon: Icon(Icons.password_outlined, color: Colors.red),
        icon: Icon(
          Icons.lock_open_outlined,
          color: Colors.red,
        ),
        focusColor: Colors.red,
        fillColor: Colors.red,
        hoverColor: Colors.red,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      cursorColor: Colors.red,
    );
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
