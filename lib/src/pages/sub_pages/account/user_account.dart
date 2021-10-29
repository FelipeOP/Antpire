import 'dart:convert';

import 'package:antpire/config.dart';
import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';

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

  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();

  late FocusNode salaryFocusNode;

  @override
  void dispose() {
    salaryFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    salaryFocusNode = FocusNode();
    Firestore().getUserData().then((value) {
      _salaryController.text = value!['salary'].toString().isNotEmpty
          ? value['salary'].toString()
          : '';
      _frequencyController.text = value['frequency'].toString().isNotEmpty
          ? value['frequency'].toString()
          : '';
    }).onError((e, stackTrace) => _authController.getErrorMessage(e));
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _userInfo(),
          _financialInfo(),
          // SizedBox(width: 100, height: Config.screenHeight! * 0.09),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_signOut(), _deleteAccount()],
          )
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
              initialValue: _authController.displayName,
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
              initialValue: _authController.userEmail,
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

  Widget _financialInfo() {
    return CupertinoFormSection.insetGrouped(
        header: const Text('Información financiera'),
        children: [
          CupertinoFormRow(
            prefix: Text('Salario',
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
            child: CupertinoTextFormFieldRow(
              focusNode: salaryFocusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: _salaryController,
              readOnly: false,
              style: GoogleFonts.josefinSans(),
              textAlign: TextAlign.end,
              onChanged: (String? value) {
                setState(() {
                  _wasChanged = true;
                });
              },
              validator: (String? salary) {
                if (salary.toString().isEmpty) {
                  return "El campo salario no puede estar vacío";
                }
                if (_numbersExp.hasMatch(salary.toString())) {
                  double finalSalary = double.parse(salary.toString());
                  if (!((finalSalary >= 50))) {
                    return "Ingrese un sueldo válido";
                  }
                } else {
                  return "Solo debe contener numeros";
                }
                return salaryFocusNode.hasFocus
                    ? NumberFormat.currency(
                        locale: 'es_MX',
                        symbol: r'$ ',
                        decimalDigits: 0,
                      ).format(int.parse(salary.toString()))
                    : null;
              },
            ),
          ),
          CupertinoFormRow(
            prefix: Text('Frecuencia',
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
            child: CupertinoTextFormFieldRow(
              controller: _frequencyController,
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
                  Firestore()
                      .updateUserData(
                          frequency: _frequencyController.text,
                          salary: int.parse(_salaryController.text.trim()))
                      .then((value) {
                    if (value.compareTo('updated') == 0) {
                      Get.snackbar(
                        'Cambios guardados',
                        'Se han actualizado los datos correctamente.',
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  }, onError: (e) {
                    _authController.getErrorMessage(e);
                  });

                  setState(() {
                    _wasChanged = false;
                  });
                }
              }
            : null,
        child: const Text("Actualizar",
            style: TextStyle(fontWeight: FontWeight.bold)));
  }

  Widget _signOut() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.grey),
      icon: const Icon(Icons.exit_to_app),
      label: const Text('Cerrar sesión',
          style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () => _signOutDialog(),
    );
  }

  Widget _deleteAccount() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.red[600]),
      icon: const Icon(Icons.delete_forever),
      label: const Text('Eliminar cuenta',
          style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () => _deleteAccountDialog(),
    );
  }

  AwesomeDialog _signOutDialog() {
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
        btnOkOnPress: () => _authController.signOut())
      ..show();
  }

  AwesomeDialog _deleteAccountDialog() {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: true,
        animType: AnimType.SCALE,
        title: 'Quieres eliminar tu cuenta?',
        desc:
            'Esta acción no se puede deshacer.\nDebes re-autentificarte para llevar a cabo este proceso',
        btnOkText: "Continuar",
        btnCancelText: "Cancelar",
        buttonsTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        showCloseIcon: true,
        btnCancelOnPress: () => Get.back(),
        btnOkOnPress: () {
          _authController.deleteAccount();
        })
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
                    _frequencyController.text = _freq[index].data!;
                    _wasChanged = true;
                  });
                },
                itemExtent: 35.0,
                children: _freq),
          );
        });
  }
}
