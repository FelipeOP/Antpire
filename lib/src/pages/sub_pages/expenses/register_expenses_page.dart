import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterExpensesPage extends StatefulWidget {
  const RegisterExpensesPage({Key? key}) : super(key: key);

  @override
  _RegisterExpensesPageState createState() => _RegisterExpensesPageState();
}

class _RegisterExpensesPageState extends State<RegisterExpensesPage> {
  static final RegExp _numbersExp = RegExp(r'^[0-9]+$');
  static final RegExp _lettersExp =
      RegExp(r"^[\p{L} ]+$", caseSensitive: false, unicode: true, dotAll: true);

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _deiber;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 450,
            height: 450,
            color: Colors.white,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Registra tu gasto',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                          controller: _descriptionController,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: 'Arriendo',
                            labelStyle: const TextStyle(color: Colors.grey),
                            labelText: 'Descripción',
                            focusColor: Colors.red,
                            fillColor: Colors.grey,
                            hoverColor: Colors.grey,
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                          ),
                          validator: (String? description) {
                            if (description.toString().isEmpty) {
                              return 'El campo descripción no puede estar vacío';
                            }
                            return _lettersExp.hasMatch(description.toString())
                                ? null
                                : 'Solo puede contener letras';
                          }),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  tooltip: "El valor total del gasto.",
                                  icon: const Icon(Icons.monetization_on),
                                  focusColor: Colors.red,
                                  color: Colors.red,
                                  onPressed: () {}),
                              contentPadding: const EdgeInsets.all(15),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              hintText: r'$$$$$$$',
                              labelStyle: const TextStyle(color: Colors.grey),
                              labelText: 'Gasto ',
                              focusColor: Colors.red,
                              fillColor: Colors.grey,
                              hoverColor: Colors.grey,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            validator: (String? spending) {
                              if (spending.toString().isEmpty) {
                                return 'El campo no puede estar vacío';
                              }
                              if (_numbersExp.hasMatch(spending.toString())) {
                                int newSpending =
                                    int.parse(spending.toString());
                                if (!(newSpending > 50)) {
                                  return 'Digite un precio válido';
                                }
                              } else {
                                return 'Solo debe contener números';
                              }
                            })),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
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
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_downward,
                                color: Colors.red),
                            iconSize: 24,
                            onSelected: (String value) {
                              _priorityController.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return <String>['Baja', 'Alta']
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    child: Text(value), value: value);
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ),
                    Image.network(
                      'https://c.tenor.com/Uh4Mcry2P8EAAAAC/pato-bailar.gif',
                      height: 90,
                      width: 90,
                    ),
                    ElevatedButton.icon(
                        icon: const Icon(Icons.money),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))),
                        label: const Text(
                          'Registar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
