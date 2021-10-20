import 'package:antpire/config.dart';
import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');
  static final RegExp _lettersExp =
      RegExp(r"^[\p{L} ]+$", caseSensitive: false, unicode: true, dotAll: true);

  final _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  final TextEditingController _salaryController =
      TextEditingController(text: r'$$$$$$$$');
  final TextEditingController _frecuencyController =
      TextEditingController(text: "Firestore");

  String? __getCurrentUserName() {
    if (_authController.auth.currentUser != null) {
      return _authController.auth.currentUser!.displayName;
    }
    return _authController.googleAccount.value!.displayName;
  }

  String? __getCurrentUserEmail() {
    if (_authController.auth.currentUser != null) {
      return _authController.auth.currentUser!.email;
    }
    return _authController.googleAccount.value!.email;
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _userInfo(),
          _financialInfo(),
          SizedBox(width: 100, height: Config.screenHeight! * 0.09),
          _signOut(),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return CupertinoFormSection.insetGrouped(
        header: const Text('Datos personales'),
        children: [
          CupertinoFormRow(
            prefix: Text('Nombre',
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
            child: CupertinoTextFormFieldRow(
              style: GoogleFonts.josefinSans(),
              textAlign: TextAlign.end,
              initialValue: __getCurrentUserName(),
              readOnly: true,
              // validator: (String? name) {
              //   if (name.toString().isEmpty) {
              //     return 'El campo no puede estar vacío';
              //   }
              //   return _lettersExp.hasMatch(name.toString())
              //       ? null
              //       : "Solo debe contener letras";
              // },
            ),
          ),
          CupertinoFormRow(
            prefix: Text('Correo',
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
            child: CupertinoTextFormFieldRow(
              style: GoogleFonts.josefinSans(),
              textAlign: TextAlign.end,
              initialValue: __getCurrentUserEmail(),
              readOnly: true,
              // validator: (String? name) {
              //   if (name.toString().isEmpty) {
              //     return 'El campo no puede estar vacío';
              //   }
              //   return _lettersExp.hasMatch(name.toString())
              //       ? null
              //       : "Solo debe contener letras";
              // },
            ),
          )
        ]);
  }

  bool _wasChanged = false;
  bool _readOnly = true;

  Widget _financialInfo() {
    return CupertinoFormSection.insetGrouped(
        header: const Text('Información financiera'),
        children: [
          CupertinoFormRow(
            prefix: Text('Sueldo',
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
            child: CupertinoTextFormFieldRow(
              controller: _salaryController,
              readOnly: _readOnly,
              textAlign: TextAlign.end,
              onTap: () {
                setState(() {
                  _readOnly = !_readOnly;
                });
              },
              onChanged: (String? value) {
                setState(() {
                  _wasChanged = true;
                });
              },
              validator: (String? salary) {
                if (salary.toString().isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return _lettersExp.hasMatch(salary.toString())
                    ? null
                    : "Solo debe contener letras";
              },
            ),
          ),
          CupertinoFormRow(
            prefix: Text('Frecuencia',
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
            child: CupertinoTextFormFieldRow(
              controller: _frecuencyController,
              style: GoogleFonts.josefinSans(),
              textAlign: TextAlign.end,
              readOnly: true,
              onTap: () {
                _showPicker();
              },
              validator: (String? name) {
                if (name.toString().isEmpty) {
                  return 'El campo no puede estar vacío';
                }
                return _lettersExp.hasMatch(name.toString())
                    ? null
                    : "Solo debe contener letras";
              },
            ),
          ),
          _updateInfo()
        ]);
  }

  TextButton _updateInfo() {
    return TextButton(
        onPressed: _wasChanged
            ? () {
                if (_formKey.currentState!.validate()) {
                  Get.snackbar(
                    "Valor actualizado",
                    "Se han guardado los cambios correctamente.",
                    backgroundColor: Colors.white,
                  );
                  setState(() {
                    _wasChanged = false;
                    _readOnly = true;
                  });
                }
              }
            : null,
        child: const Text("Actualizar",
            style: TextStyle(fontWeight: FontWeight.bold)));
  }

  Widget _signOut() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.grey),
      child: const Text('Cerrar sesión',
          style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () => _showMyDialog(),
    );
  }

  AwesomeDialog _showMyDialog() {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        headerAnimationLoop: true,
        animType: AnimType.TOPSLIDE,
        title: 'Quieres cerrar sesión?',
        desc: 'Saldrás de tu cuenta',
        btnOkText: "Si",
        btnCancelText: "Cancelar",
        buttonsTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        showCloseIcon: true,
        btnCancelOnPress: () => Get.back(),
        btnOkOnPress: () => _authController.signout())
      ..show();
  }

  static const List<Text> _freq = [
    Text('Semanal'),
    Text('Quincenal'),
    Text('Mensual')
  ];

  Future<void> _showPicker() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: CupertinoPicker(
                looping: true,
                backgroundColor: Colors.white,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _frecuencyController.text = _freq[index].data!;
                    _wasChanged = true;
                  });
                },
                itemExtent: 35.0,
                children: _freq),
          );
        });
  }
}
