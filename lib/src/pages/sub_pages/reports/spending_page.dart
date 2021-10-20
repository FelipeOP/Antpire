import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_expenses.dart';

class SpendingPage extends StatelessWidget {
  const SpendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 130.0,
          backgroundImage: AssetImage('images/home.jpeg'),
          backgroundColor: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('¿Cómo va todo?',
              style: GoogleFonts.josefinSans(
                  textStyle: const TextStyle(
                      fontSize: 31, fontWeight: FontWeight.bold))),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(550, 10),
                  primary: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              icon: const Icon(Icons.arrow_right),
              label: const Text('Historial de gastos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {
                Get.to(() => DataTableDemo());
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(550, 10),
                  primary: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              icon: const Icon(Icons.arrow_right),
              label: const Text('Reporte de gastos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {}),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(550, 10),
                  primary: Colors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              icon: const Icon(Icons.arrow_right),
              label: const Text('Balances',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onPressed: () {}),
        ),
      ],
    );
  }
}
