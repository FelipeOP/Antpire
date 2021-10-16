import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterExpensesPage extends StatefulWidget {
  const RegisterExpensesPage({Key? key}) : super(key: key);

  @override
  _RegisterExpensesPageState createState() => _RegisterExpensesPageState();
}

class _RegisterExpensesPageState extends State<RegisterExpensesPage> {
  int _deiber = 1;
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
            //por favor, váyase Salamanca, fuera,
            //transform: Matrix4.rotationZ(0.5),
            // decoration: BoxDecoration(
            //     //image: DecorationImage(
            //     //image: NetworkImage(
            //     //'https://c.tenor.com/Uh4Mcry2P8EAAAAC/pato-bailar.gif'),
            //     //),
            //     //borderRadius: BorderRadius.all(Radius.circular(5)),
            //     //color: Colors.white,
            //     //border: Border.all(color: Colors.red, width: 1)
            //     ),

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
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          hintText: 'Arriendo',
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Descripción del gasto ',
                          focusColor: Colors.red,
                          fillColor: Colors.grey,
                          hoverColor: Colors.grey,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          hintText: r'$$$$$$$',
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Gasto ',
                          focusColor: Colors.red,
                          fillColor: Colors.grey,
                          hoverColor: Colors.grey,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 3.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Text("Baja"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Alta"),
                            value: 2,
                          )
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            _deiber = value;
                          });
                        },
                        hint: Text("Prioridad"),
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 20,
                      ),
                    ),
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
