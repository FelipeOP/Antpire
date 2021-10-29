import 'package:antpire/config.dart';
import 'package:antpire/src/models/spending.dart';
import 'package:antpire/src/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterExpensesPage extends StatefulWidget {
  const RegisterExpensesPage({Key? key}) : super(key: key);

  @override
  _RegisterExpensesPageState createState() => _RegisterExpensesPageState();
}

class _RegisterExpensesPageState extends State<RegisterExpensesPage> {
  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');
  static final RegExp _lettersExp =
      RegExp(r"^[\p{L} ]+$", caseSensitive: false, unicode: true, dotAll: true);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _deiber;
    Config().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: Config.screenWidth! - 1,
            height: Config.screenHeight! * 0.80,
            color: Colors.white,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Registra tu gasto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _expenseImage(),
                    _nameField(),
                    _expenseField(),
                    _priorityField(),
                    _elevatedButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _expenseImage() {
    return Image(
      image: const AssetImage('images/herecomes.jpeg'),
      width: Config.screenWidth! * 0.90,
      height: Config.screenHeight! * 0.30,
    );
  }

  Padding _nameField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                color: Colors.red,
                tooltip: "Una breve descripción del gasto.",
                icon: const Icon(Icons.info),
                onPressed: () {}),
            contentPadding: const EdgeInsets.all(15),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            hintText: 'Arriendo',
            labelStyle: const TextStyle(color: Colors.grey),
            labelText: 'Nombre del producto',
            focusColor: Colors.red,
            fillColor: Colors.grey,
            hoverColor: Colors.grey,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
          validator: (String? name) {
            if (name.toString().isEmpty) {
              return 'El campo descripción no puede estar vacío';
            }
            return _lettersExp.hasMatch(name.toString())
                ? null
                : 'Solo puede contener letras';
          }),
    );
  }

  Padding _expenseField() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  tooltip: "El valor total del gasto.",
                  icon: const Icon(Icons.monetization_on),
                  focusColor: Colors.red,
                  color: Colors.red,
                  onPressed: () {}),
              contentPadding: const EdgeInsets.all(15),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              hintText: r'$$$$$$$',
              labelStyle: const TextStyle(color: Colors.grey),
              labelText: 'Gasto ',
              focusColor: Colors.red,
              fillColor: Colors.grey,
              hoverColor: Colors.grey,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            ),
            validator: (String? spending) {
              if (spending.toString().isEmpty) {
                return 'El campo no puede estar vacío';
              }
              if (_numbersExp.hasMatch(spending.toString())) {
                int newSpending = int.parse(spending.toString());
                if (!(newSpending > 50)) {
                  return 'Digite un precio válido';
                }
              } else {
                return 'Solo debe contener números';
              }
            }));
  }

  Padding _priorityField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
          readOnly: true,
          controller: _priorityController,
          decoration: InputDecoration(
            labelText: "Prioridad",
            labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.all(15),
            focusColor: Colors.red,
            fillColor: Colors.grey,
            hoverColor: Colors.grey,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(Icons.arrow_downward, color: Colors.red),
              iconSize: 24,
              onSelected: (String value) {
                _priorityController.text = value;
              },
              itemBuilder: (BuildContext context) {
                return <String>['Baja', 'Alta']
                    .map<PopupMenuItem<String>>((String value) {
                  return PopupMenuItem(child: Text(value), value: value);
                }).toList();
              },
            ),
          ),
          validator: (String? priority) {
            if (priority.toString().isEmpty) {
              return 'El campo no puede estar vacío';
            }
          }),
    );
  }

  ElevatedButton _elevatedButton() {
    return ElevatedButton.icon(
        icon: const Icon(Icons.money),
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
        label: const Text(
          'Registar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Spending spending = Spending(
                name:
                    _nameController.text.trim().toLowerCase().capitalizeFirst!,
                price: int.parse(_priceController.text.trim()),
                priority: _priorityController.text.trim());
            Firestore().addSpending(spending).then((value) => Get.snackbar(
                  'Registrado!',
                  "Se ha guardado correctamente",
                  snackPosition: SnackPosition.TOP,
                ));
          }
        });
  }
}
