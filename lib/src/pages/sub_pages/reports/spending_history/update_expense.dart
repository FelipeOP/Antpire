import 'package:antpire/config.dart';
import 'package:antpire/src/models/spending.dart';
import 'package:antpire/src/models/spending_data_source.dart';
import 'package:antpire/src/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateExpensesPage extends StatefulWidget {
  final Spending spending;
  const UpdateExpensesPage({Key? key, required this.spending})
      : super(key: key);

  @override
  _RegisterExpensesPageState createState() => _RegisterExpensesPageState();
}

class _RegisterExpensesPageState extends State<UpdateExpensesPage> {
  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.spending.name;
    super.initState();
  }

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
            height: Config.screenHeight! * 0.50,
            color: Colors.white,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Actualiza tu gasto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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

  Padding _nameField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: _nameController,
        readOnly: true,
        enabled: false,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Gasto en actualización',
          suffixIcon: IconButton(
              color: Colors.red,
              tooltip: "Una breve descripción del gasto.",
              icon: const Icon(Icons.info),
              onPressed: () {}),
          contentPadding: const EdgeInsets.all(15),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          labelStyle: const TextStyle(color: Colors.grey),
          fillColor: Colors.grey,
          hoverColor: Colors.grey,
        ),
      ),
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
        icon: const Icon(Icons.update),
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
        label: const Text(
          'Actualizar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Spending spending = Spending(
                name:
                    _nameController.text.trim().toLowerCase().capitalizeFirst!,
                price: int.parse(_priceController.text.trim()),
                priority: _priorityController.text.trim(),
                date: widget.spending.date);

            Firestore().addSpending(spending).then((value) => Get.snackbar(
                  'Actualizado!',
                  "Se ha guardado correctamente",
                  snackPosition: SnackPosition.TOP,
                ));
            Get.back();
            spendings.removeWhere((element) => element.name == spending.name);
            spendings.add(spending);
          }
        });
  }
}
